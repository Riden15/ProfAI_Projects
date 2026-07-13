# Analisi dei Dati di Vendita di un E-commerce

L'azienda XYZ E-commerce gestisce un sito web che offre una vasta gamma di prodotti ai suoi clienti.
Per ottimizzare le strategie di marketing e migliorare la gestione delle vendite, è necessario analizzare i dati storici relativi a prodotti, clienti e ordini.

## Obiettivi del Progetto

Questo progetto mira a estrarre informazioni utili dai dati di vendita del sito e-commerce per supportare il processo decisionale aziendale. 
Gli obiettivi principali sono:

1. Identificare i clienti che hanno speso di più sul sito.
2. Determinare i prodotti che hanno generato il maggiore fatturato.
3. Analizzare i giorni della settimana con il fatturato medio più alto.
4. Calcolare il numero medio di prodotti per ordine.

## Dataset Utilizzato

Il progetto utilizzerà i dati provenienti dalle seguenti tabelle SQL:

- prodotto: Contiene informazioni sui prodotti, come l'ID, il nome e il prezzo.
- cliente: Contiene i dettagli dei clienti, come l'ID e l'email.
- ordini: Registra le transazioni, associando i prodotti ai clienti e alla data dell'ordine.
  
Lo script per creare queste tabelle è presente a questo link: https://raw.githubusercontent.com/Profession-AI/progetti-sql/refs/heads/main/Analisi%20delle%20vendite%20di%20un%20sito%20di%20e-commerce/ecommerce.sql

## Fasi del Progetto

### 1. Preparazione dei Dati

- Collegare il database SQL e importare i dati delle tabelle prodotto, cliente e ordini.
- Eseguire query per unire le tabelle e creare un dataset integrato che contenga:
  - Informazioni sui clienti.
  - Nome e prezzo dei prodotti.
  - Data degli ordini.

### 2. Analisi dei Clienti

- Calcolare la spesa totale per ogni cliente sommando i prezzi dei prodotti acquistati.
- Ordinare i clienti in base alla spesa totale e identificare i top spender.

### 3. Analisi dei Prodotti

- Determinare il fatturato totale generato da ciascun prodotto.
- Ordinare i prodotti in base al fatturato totale per identificare i best-seller.

### 4. Analisi Temporale

- Aggregare i dati delle vendite per giorno della settimana.
- Calcolare il fatturato medio giornaliero e individuare i giorni con la media più alta.

### 5. Analisi degli Ordini

- Calcolare il numero di prodotti per ciascun ordine.
- Determinare la media e la distribuzione del numero di prodotti per ordine.

## Conclusioni

Questo progetto fornirà una visione chiara delle prestazioni del sito e-commerce, permettendo di prendere decisioni strategiche basate sui dati. 
La comprensione del comportamento dei clienti e delle dinamiche di vendita consentirà di aumentare le entrate e migliorare l'efficienza operativa.

## Modalità di Consegna

- File SQL