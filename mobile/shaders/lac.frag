#version 460 core
#include <flutter/runtime_effect.glsl>

// Splash « Le lac » : dix gouttes tombent dans un lac de sirop rose,
// la 10e est une goutte d'encre qui se diffuse et dessine le nom.
// Porté depuis brand/splash/lac/template.html (WebGL).

precision highp float;

uniform vec2 uSize;        // taille de l'écran en pixels
uniform float uT;          // temps en secondes, de 0 à 4.6
uniform float uAsp;        // largeur / hauteur de l'image du nom
uniform sampler2D uLogo;   // le nom, net
uniform sampler2D uBlur;   // le nom, flou

out vec4 fragColor;

const vec3 CREAM = vec3(.985, .945, .925);
const vec3 PEACH = vec3(1., .83, .76);
const vec3 ROSE = vec3(.95, .72, .75);
const vec3 INK = vec3(.749, .227, .384);   // #BF3A62
const vec3 INK2 = vec3(.588, .122, .255);  // #961F41
const float REVEAL = 2.25;                 // instant où la goutte d'encre touche le lac

// x, y (largeur d'écran = 1, centre = 0), instant d'impact (s), force
vec4 goutte(int i) {
  if (i == 0) return vec4(-.22, .42, .35, .8);
  if (i == 1) return vec4(.25, .18, .70, .7);
  if (i == 2) return vec4(-.10, -.36, .95, .75);
  if (i == 3) return vec4(.30, -.55, 1.15, .6);
  if (i == 4) return vec4(-.30, -.05, 1.32, .65);
  if (i == 5) return vec4(.12, .60, 1.46, .6);
  if (i == 6) return vec4(.33, .40, 1.58, .5);
  if (i == 7) return vec4(-.26, -.62, 1.68, .55);
  if (i == 8) return vec4(.05, -.18, 1.77, .5);
  return vec4(0., 0., REVEAL, 1.35);
}

float wave(vec2 p, vec4 d) {
  float dt = uT - d.z;
  if (dt <= 0.) return 0.;
  float r = length(p - d.xy), s = r - .26 * dt;
  float sig = .018 + .05 * dt;                              // le paquet d'ondes s'élargit en s'éloignant
  float env = exp(-s * s / (sig * sig));
  float bump = exp(-r * r / .0006) * exp(-9. * dt) * 1.4;   // creux puis rebond au point d'impact
  return d.w * (env * cos(s * 80.) * exp(-1.7 * dt) / (1. + 6. * r) - bump * cos(dt * 30.));
}

float H(vec2 p) {
  float h = 0.;
  for (int i = 0; i < 10; i++) h += wave(p, goutte(i));
  return h * .0022;
}

float hash(vec2 q) { return fract(sin(dot(q, vec2(127.1, 311.7))) * 43758.5453); }
float noise(vec2 q) {
  vec2 i = floor(q), f = fract(q);
  f = f * f * (3. - 2. * f);
  return mix(mix(hash(i), hash(i + vec2(1., 0.)), f.x), mix(hash(i + vec2(0., 1.)), hash(i + 1.), f.x), f.y);
}

void main() {
  // Flutter compte y depuis le haut, WebGL depuis le bas : on retourne y pour garder les mêmes calculs
  vec2 fc = FlutterFragCoord().xy;
  vec2 p = (vec2(fc.x, uSize.y - fc.y) - .5 * uSize) / uSize.x;

  float e = 1.5 / uSize.x;
  float h = H(p), hx = H(p + vec2(e, 0.)), hy = H(p + vec2(0., e)), hx2 = H(p - vec2(e, 0.)), hy2 = H(p - vec2(0., e));
  vec3 n = normalize(vec3(-(hx - hx2) / (2. * e), -(hy - hy2) / (2. * e), 1.));
  float lap = (hx + hx2 + hy + hy2 - 4. * h) / (e * e);

  // fond : sirop rose laiteux, lumière douce venue du haut
  float g = smoothstep(-.9, .9, p.y);
  vec3 col = mix(mix(ROSE, PEACH, smoothstep(-1., .2, p.y)), CREAM, g * .7);
  col *= 1. - .08 * length(p * vec2(1.2, .6));

  // la goutte d'encre se diffuse depuis le centre et dessine le nom, d'abord flou puis net
  float tt = uT - REVEAL;
  if (tt > 0.) {
    vec2 q = p + n.xy * .02;                                  // l'encre bouge avec l'eau
    float w = .64;
    vec2 uv = vec2(q.x / w + .5, .5 - q.y * uAsp / w);
    float inUV = step(0., uv.x) * step(uv.x, 1.) * step(0., uv.y) * step(uv.y, 1.);
    float k = smoothstep(.2, 1.9, tt);
    float a = mix(texture(uBlur, uv).a * 1.25, texture(uLogo, uv).a, k) * inUV;
    float R = .5 * (1. - exp(-1.6 * tt)) + .02;
    float fr = noise(q * 14. + tt) * .07;
    float spread = smoothstep(R + .04, R - .06, length(q) + fr);
    vec3 ink = mix(INK, INK2, clamp(uv.x, 0., 1.));
    col = mix(col, ink, clamp(a, 0., 1.) * spread * smoothstep(0., .5, tt));
    col = mix(col, ink, .08 * spread * exp(-2.2 * tt) * smoothstep(0., .15, tt));  // voile d'encre qui se dissout
  }

  // lumière : reflets, caustiques, voile de surface
  vec3 L = normalize(vec3(-.35, .55, 1.));
  float spec = pow(max(dot(reflect(-L, n), vec3(0., 0., 1.)), 0.), 90.);
  col += spec * .55;
  col += clamp(-lap * .02, 0., .2) * vec3(1., .96, .92);
  col -= clamp(lap * .012, 0., .06);
  col = mix(col, CREAM, clamp((1. - n.z) * 4., 0., .35));

  // gouttes en chute : une perle qui grossit et son ombre qui la rejoint ; la dernière est d'encre
  for (int i = 0; i < 10; i++) {
    vec4 d = goutte(i);
    float f = (uT - d.z) / .32 + 1.;
    if (f <= 0. || f >= 1.) continue;
    float rr = mix(.004, .014 + .006 * d.w, f * f);
    vec2 sh = d.xy + vec2(.04, -.06) * (1. - f);
    col *= 1. - .18 * f * smoothstep(rr * 1.6, 0., length(p - sh));
    vec2 q = (p - d.xy) / rr;
    float qq = dot(q, q);
    if (qq < 1.) {
      vec3 sn = vec3(q, sqrt(1. - qq));
      vec3 body = i == 9 ? mix(INK, INK2, .5) : mix(col * .82, CREAM, .25);
      vec3 drop = body + pow(max(dot(reflect(-L, sn), vec3(0., 0., 1.)), 0.), 40.) * .9;
      col = mix(col, drop, smoothstep(1., .8, qq));
    }
  }

  fragColor = vec4(col, 1.);
}
