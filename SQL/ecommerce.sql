-- ============================================================
-- Analisi dei Dati di Vendita di un E-commerce
-- ============================================================

-- ============================================================
-- 1. PREPARAZIONE DEI DATI
-- ============================================================

CREATE TABLE prodotto (
    id     INT PRIMARY KEY,
    nome   VARCHAR(100)   NOT NULL,
    prezzo DECIMAL(10, 2) NOT NULL
);

CREATE TABLE cliente (
    id    INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE ordini (
    id_prodotto INT,
    id_cliente  INT,
    data        DATE,
    FOREIGN KEY (id_prodotto) REFERENCES prodotto(id),
    FOREIGN KEY (id_cliente)  REFERENCES cliente(id)
);

INSERT INTO prodotto (id, nome, prezzo) VALUES
(1,  'Smartphone',           699.99),
(2,  'Laptop',              1099.99),
(3,  'Auricolari Bluetooth',  49.99),
(4,  'Monitor 4K',           299.99),
(5,  'Mouse Wireless',        19.99),
(6,  'Tastiera Meccanica',    89.99),
(7,  'Tablet',               499.99),
(8,  'Smartwatch',           199.99),
(9,  'Fotocamera DSLR',      799.99),
(10, 'Stampante',            129.99);

INSERT INTO cliente (id, email) VALUES
(1, 'mario.rossi@example.com'),
(2, 'luigi.verdi@example.com'),
(3, 'anna.bianchi@example.com'),
(4, 'carla.neri@example.com'),
(5, 'giulia.ferri@example.com');

INSERT INTO ordini (id_prodotto, id_cliente, data) VALUES
(1,  1, '2025-01-01'),
(2,  1, '2025-01-02'),
(3,  2, '2025-01-03'),
(4,  3, '2025-01-04'),
(5,  4, '2025-01-05'),
(6,  5, '2025-01-06'),
(7,  1, '2025-01-07'),
(8,  2, '2025-01-08'),
(9,  3, '2025-01-09'),
(10, 4, '2025-01-10'),
(1,  5, '2025-01-11'),
(2,  1, '2025-01-12'),
(3,  2, '2025-01-13'),
(4,  3, '2025-01-14'),
(5,  4, '2025-01-15'),
(6,  5, '2025-01-16'),
(7,  1, '2025-01-17'),
(8,  2, '2025-01-18'),
(9,  3, '2025-01-19'),
(10, 4, '2025-01-20');

SELECT
    c.id          AS id_cliente,
    c.email       AS email_cliente,
    p.nome        AS nome_prodotto,
    p.prezzo      AS prezzo_prodotto,
    o.data        AS data_ordine
FROM ordini o
JOIN cliente  c ON o.id_cliente  = c.id
JOIN prodotto p ON o.id_prodotto = p.id
ORDER BY o.data;

-- ============================================================
-- 2. ANALISI DEI CLIENTI
-- ============================================================

SELECT
    c.id                     AS id_cliente,
    c.email                  AS email_cliente,
    SUM(p.prezzo)            AS spesa_totale,
    COUNT(*)                 AS numero_acquisti
FROM ordini o
JOIN cliente  c ON o.id_cliente  = c.id
JOIN prodotto p ON o.id_prodotto = p.id
GROUP BY c.id
ORDER BY spesa_totale DESC;

-- ============================================================
-- FASE 3: ANALISI DEI PRODOTTI
-- ============================================================

SELECT
    p.id                     AS id_prodotto,
    p.nome                   AS nome_prodotto,
    p.prezzo                 AS prezzo_unitario,
    COUNT(*)                 AS quantita_venduta,
    SUM(p.prezzo)            AS fatturato_totale
FROM ordini o
JOIN prodotto p ON o.id_prodotto = p.id
GROUP BY p.id
ORDER BY fatturato_totale DESC;

-- ============================================================
-- FASE 4: ANALISI TEMPORALE
-- ============================================================

-- Subquery per aggregare prima il fatturato per giorno, per poi 
-- calcolare la media per giorno della settimana

SELECT
    DAYNAME(data)            AS giorno_settimana,
    ROUND(AVG(totale_giorno), 2) AS fatturato_medio
FROM (
    SELECT
        o.data,
        SUM(p.prezzo) AS totale_giorno
    FROM ordini o
    JOIN prodotto p ON o.id_prodotto = p.id
    GROUP BY o.data
) AS fatturato_giorno
GROUP BY DAYNAME(data)
ORDER BY fatturato_medio DESC;

-- ============================================================
-- FASE 5: ANALISI DEGLI ORDINI
-- ============================================================

SELECT
    o.data                   AS data_ordine,
    c.email                  AS email_cliente,
    COUNT(o.id_prodotto)     AS prodotti_per_ordine
FROM ordini o
JOIN cliente c ON o.id_cliente = c.id
GROUP BY o.data, o.id_cliente
ORDER BY o.data;

-- Subquery necessaria, AVG non può essere applicato direttamente a COUNT nella stessa query. 
SELECT
    ROUND(AVG(prodotti_per_ordine), 2) AS media_prodotti_per_ordine
FROM (
    SELECT
        o.data,
        o.id_cliente,
        COUNT(o.id_prodotto) AS prodotti_per_ordine
    FROM ordini o
    GROUP BY o.data, o.id_cliente
) AS ordini_aggregati;
