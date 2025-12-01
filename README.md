# 🏠 Texas Real Estate Market Analysis

### Analisi Statistica Descrittiva per Texas Realty Insights

![R Language](https://img.shields.io/badge/Language-R-blue)
![Status](https://img.shields.io/badge/Status-Completed-success)

## 📋 Descrizione del Progetto

Questo progetto analizza le tendenze storiche del mercato immobiliare in Texas per supportare le decisioni strategiche di **Texas Realty Insights**. 
L'obiettivo è trasformare i dati grezzi in insight operativi riguardanti volumi di vendita, pricing e performance delle inserzioni.

## 📊 Il Dataset

Il dataset comprende serie storiche (2010-2015) relative a quattro città principali: **Beaumont, Bryan-College Station, Tyler e Wichita Falls**.

| Variabile | Descrizione |
| :--- | :--- |
| `sales` | Numero totale di vendite effettuate |
| `volume` | Valore totale delle vendite (Milioni $) |
| `median_price` | Prezzo mediano di vendita ($) |
| `listings` | Numero totale di annunci attivi |
| `months_inventory` | Tempo necessario per vendere l'inventario corrente |

---

## 💡 Risultati Chiave (Key Insights)

Dall'analisi statistica sono emerse le seguenti evidenze di business:

### 1. Efficacia degli Annunci e Performance
* **Top Performer:** La città di **Bryan-College Station** mostra la maggiore efficacia pubblicitaria (rapporto Vendite/Annunci più alto). Circa 10 annunci generano quasi 4 vendite.
* **Mercato Liquido:** **Wichita Falls**, nonostante abbia volumi totali di vendita inferiori, si distingue per essere il mercato più "liquido" (valori bassi di *Months Inventory*). Gli immobili restano sul mercato per meno tempo rispetto alle altre città, indicando un'alta velocità di rotazione.

### 2. Trend e Crescita
* **Città in Crescita:** **Tyler** e **Bryan-College Station** mostrano un trend positivo costante sia nel prezzo mediano che nei volumi di vendita anno su anno.
* **Stagnazione/Declino:** **Wichita Falls** presenta un trend decrescente nei volumi, confermandosi il mercato meno performante in termini di fatturato totale, sebbene veloce nelle chiusure. **Beaumont** mostra una stabilità senza trend di crescita significativi.

### 3. Stagionalità
* È stata identificata una forte **stagionalità estiva**: il periodo **Maggio-Agosto** registra sistematicamente il picco di vendite e di inserzioni attive in tutte le città analizzate.

### 4. Analisi dei Prezzi
* **Wichita Falls** è la città con il prezzo mediano più basso e con la maggiore variabilità (fluttuazioni) rispetto alla media, suggerendo un mercato più accessibile ma meno prevedibile.
* Le distribuzioni di `Sales` e `Volume` sono fortemente **asimmetriche positive** (molte osservazioni su valori bassi, poche su valori molto alti), mentre il `Median Price` segue una distribuzione più vicina alla normale.

### 5. Desion-making
* Concentrare il budget per gli annunci nel periodo pre-estivo, salvando risorse dei mesi meno produttivi 
* Wichita Falls risulta essere il mercato più liquido, quindi modificare annunci e renderli più ingaggianti a livello di prezzo.
* A/B test di diversi modelli di sponsorizzazione annunci per le città meno performanti


---

## 🛠️ Metodologia

L'analisi è stata condotta utilizzando **R** e le librerie `tidyverse`, strutturata nei seguenti step:

1.  **Data Cleaning:** Gestione delle date e creazione di fattori per l'analisi temporale.
2.  **Statistica Descrittiva:** Calcolo di media, SD, Skewness, Kurtosis e Indice di Gini per valutare la concentrazione del mercato.
3.  **Feature Engineering:** Creazione della metrica `ad_effectiveness` (Sales / Listings).
4.  **Time Series Analysis:** Utilizzo di **Medie Mobili a 12 mesi** per isolare il trend dalla componente stagionale.
5.  **Visualizzazione:** Boxplot per l'analisi della varianza e grafici a barre sovrapposti per lo studio della stagionalità.

---

## 💻 Tecnologie Utilizzate

* **R** (Core Language)
* **RStudio** (IDE)
* **Tidyverse** (`dplyr`, `ggplot2`, `tidyr`) per manipolazione dati e grafici.
* **RMarkdown** per la reportistica.

---

## 🔗 Report Completo

Il codice sorgente è disponibile in questa repository.
Per visualizzare il report interattivo completo con grafici e commenti, visita la pagina su RPubs:

👉 **https://rpubs.com/perofficial_/descriptive_analysis_matteo_peroni**

---

## 📂 Struttura della Repository

```text
├── data/               # Dataset originale
├── script/             # Codice R
├── images/             # Grafici salvati in .png/.jpg
├── report/             # File RMarkdown principale
└── README.md           # Questo file
