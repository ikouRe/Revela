CREATE TABLE product (
                         barcode          VARCHAR(14) PRIMARY KEY,
                         name             TEXT,
                         brand            TEXT,
                         image_url        TEXT,
                         ingredients_text TEXT,
                         source           VARCHAR(20) NOT NULL DEFAULT 'OBF',
                         fetched_at       TIMESTAMPTZ NOT NULL
);

CREATE TABLE product_ingredient (
                                    product_barcode VARCHAR(14) REFERENCES product(barcode) ON DELETE CASCADE,
                                    position        INT  NOT NULL,
                                    raw_name        TEXT NOT NULL,
                                    PRIMARY KEY (product_barcode, position)
);