#version 460 core
#include <flutter/runtime_effect.glsl>

// Bulle « perle » de la barre d'onglets.
// Porté depuis docs/design/prototype/perle-et-verre.html (script #frag, WebGL).
// Repère : origine en bas à gauche, comme dans la maquette (uH sert à retourner y).

precision highp float;

uniform float uH;      // hauteur du dessin en pixels
uniform float uT;      // temps en secondes
uniform float uIri;    // irisé
uniform float uK;      // fusion entre les deux gouttes
uniform float uWob;    // ondulation
uniform float uLum;    // lumière du doigt
uniform float uTeinte; // 1 = teinte du dégradé de la marque
uniform vec4 uA;       // x, y, rayon, pointe
uniform vec4 uB;       // x, y, rayon, pointe (goutte qui suit)
uniform vec3 uDoigt;   // x, y, force
uniform vec3 uOnde;    // x, y, âge

out vec4 fragColor;

float smin(float a, float b, float k) {
  float h = max(k - abs(a - b), 0.) / k;
  return min(a, b) - h * h * k * .25;
}

float goutte(vec3 p, vec4 g) {
  vec3 q = p - vec3(g.xy, 0.);
  float r = g.z, t = g.w;
  float w = uWob * r * .022 * (sin(q.y / r * 4.5 + uT * 2.1) + sin(q.x / r * 3.7 - uT * 1.7));
  vec2 vers = p.xy - uDoigt.xy;
  w -= uDoigt.z * r * .15 * exp(-dot(vers, vers) / (r * r * .4));
  if (uOnde.z < 2.5) {
    float l = length(p.xy - uOnde.xy) / r;
    w += r * .045 * sin(l * 13. - uOnde.z * 17.) * exp(-uOnde.z * 2.6 - l * 1.1);
  }
  float corps = length(q) - r + w;
  float pointe = length(q - vec3(0., r * (.35 + .95 * t), 0.)) - r * .1;
  return smin(corps, pointe, r * (.2 + .75 * t));
}

float carte(vec3 p) {
  float d = 1e5;
  if (uA.z > .5) d = goutte(p, uA);
  if (uB.z > .5) d = smin(d, goutte(p, uB), uK);
  return d;
}

vec3 normale(vec3 p) {
  vec2 e = vec2(.6, -.6);
  return normalize(e.xyy * carte(p + e.xyy) + e.yyx * carte(p + e.yyx) + e.yxy * carte(p + e.yxy) + e.xxx * carte(p + e.xxx));
}

float ombre(vec2 p, vec4 g) {
  if (g.z < .5) return 0.;
  vec2 s = (p - g.xy - vec2(g.z * .12, -g.z * 1.14)) / vec2(g.z * .92, g.z * .24);
  return exp(-dot(s, s)) * .2;
}

void main() {
  vec2 p = vec2(FlutterFragCoord().x, uH - FlutterFragCoord().y);
  // Les pixels loin des gouttes sortent tout de suite.
  float da = uA.z > .5 ? length(p - uA.xy - vec2(0., uA.z * .3)) / uA.z : 9.;
  float db = uB.z > .5 ? length(p - uB.xy - vec2(0., uB.z * .3)) / uB.z : 9.;
  if (min(da, db) > 2.3) { fragColor = vec4(0.); return; }

  float zMax = max(uA.z, uB.z) * 1.7;
  float z = zMax, proche = 1e5, zProche = z;
  for (int i = 0; i < 34; i++) {
    float d = carte(vec3(p, z));
    if (d < proche) { proche = d; zProche = z; }
    if (d < .2) break;
    z -= d * .85;
    if (z < -zMax) break;
  }
  float couvre = clamp(1. - proche, 0., 1.);
  float o = ombre(p, uA) + ombre(p, uB);
  vec4 sol = vec4(vec3(.72, .3, .42) * o, o);
  if (couvre <= 0.) { fragColor = sol; return; }

  vec3 n = normale(vec3(p, zProche));
  vec3 v = vec3(0., 0., 1.);
  vec3 r = reflect(-v, n);
  float fres = pow(1. - clamp(n.z, 0., 1.), 2.1);

  vec3 ciel = mix(vec3(1., .79, .7), vec3(.98, .72, .84), .5 + .5 * r.y);
  vec3 c = mix(vec3(1., .975, .965), ciel, .28 + .55 * fres);

  float caustique = pow(max(dot(n, normalize(vec3(.34, -.78, .52))), 0.), 3.);
  c += vec3(1., .62, .46) * caustique * .34;

  float film = (1. - n.z) * 3.2 + r.x * 1.4 + r.y * .8 + uT * .18 + uLum * length(p - uDoigt.xy) / 260.;
  vec3 irise = .68 + .32 * cos(6.2832 * (film + vec3(0., .33, .67)));
  c = mix(c, irise, uIri * smoothstep(.02, .7, fres + .12));

  c = mix(c, vec3(.66, .3, .44), pow(fres, 3.2) * .62);

  // La perle teintée avec le dégradé de la marque, pour le menu.
  if (uTeinte > 0.) {
    float m = clamp(.5 - .55 * n.y + .3 * n.x, 0., 1.);
    vec3 teinte = m < .6
        ? mix(vec3(1., .7, .59), vec3(.84, .29, .45), m / .6)
        : mix(vec3(.84, .29, .45), vec3(.59, .12, .25), (m - .6) / .4);
    c = mix(c, teinte + caustique * .1, uTeinte);
  }

  vec3 lumiere = mix(vec3(-.5, .72, .62), vec3((uDoigt.xy - p) / (max(uA.z, uB.z) * 1.5), .8), uLum);
  vec3 h = normalize(normalize(lumiere) + v);
  float spec = pow(max(dot(n, h), 0.), 170.) + pow(max(dot(n, h), 0.), 26.) * .16;
  float spec2 = pow(max(dot(n, normalize(normalize(vec3(.6, -.5, .55)) + v)), 0.), 90.) * .4;

  float a = mix(.42, .97, smoothstep(0., .8, fres)) + caustique * .14;
  a = clamp(max(a, uTeinte), 0., 1.);
  vec3 pre = c * a + vec3(1.) * (spec + spec2);
  float alpha = clamp(a + spec + spec2, 0., 1.);
  vec4 g = vec4(min(pre, vec3(alpha)), alpha);
  fragColor = mix(sol, g, couvre);
}
