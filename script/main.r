# ---------------------------------------------------------
# TEXAS REAL ESTATE ANALYSIS - SCRIPT PRINCIPALE
# Autore: Matteo Peroni
# ---------------------------------------------------------

# 1. SETUP E CARICAMENTO LIBRERIE
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("moments", quietly = TRUE)) install.packages("moments")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("zoo", quietly = TRUE)) install.packages("zoo")
if (!requireNamespace("scales", quietly = TRUE)) install.packages("scales")

library(dplyr)
library(moments)
library(ggplot2)
library(scales)
library(zoo)

# 2. CARICAMENTO E PULIZIA DATI
url <- "https://drive.google.com/uc?export=download&id=1O4If8876MTwstkrZX0BqpQ_BxcsIMEko"
data <- read.csv(url)

# Feature Engineering base
data$month_num <- data$month
data$month_name <- factor(data$month, levels = 1:12, labels = month.name)
data$year_factor <- as.factor(data$year)
data$date_obj <- as.Date(paste(data$year, data$month_num, "01", sep="-"))

# 3. STATISTICHE DESCRITTIVE
quant_vars <- c("sales", "volume", "median_price", "listings", "months_inventory")
stats_summary <- data.frame()

for (var in quant_vars) {
  vec <- data[[var]]
  temp <- data.frame(
    Variabile = var,
    Media = mean(vec, na.rm = TRUE),
    SD = sd(vec, na.rm = TRUE),
    Skewness = skewness(vec, na.rm = TRUE),
    Kurtosis = kurtosis(vec, na.rm = TRUE)
  )
  stats_summary <- rbind(stats_summary, temp)
}
print("Statistiche Descrittive:")
print(stats_summary)

# Analisi Variabilità (CV)
cv_results <- stats_summary %>%
  mutate(CV = (SD / Media) * 100, Abs_Skewness = abs(Skewness)) %>%
  arrange(desc(CV))
print("Coefficiente di Variazione:")
print(cv_results)

# 4. CALCOLO INDICE DI GINI (Concentrazione Volume)
# Usiamo il range globale per rendere le città comparabili
num_classes <- 5
data$volume_class <- cut(data$volume, breaks = num_classes, include.lowest = TRUE)

gini_per_city <- data %>%
  group_by(city) %>%
  summarise(gini_index = 1 - sum(prop.table(table(volume_class))^2)) %>%
  arrange(desc(gini_index))
print("Indice di Gini per Città:")
print(gini_per_city)

# 5. METRICHE DI BUSINESS (Efficacia Annunci)
data <- data %>%
  mutate(
    avg_price_per_sale = ifelse(sales > 0, volume / sales, NA),
    ad_effectiveness = ifelse(listings > 0, sales / listings, NA)
  )

# Performance Aggregata per Città
city_aggregated_stats <- data %>%
  group_by(city) %>%
  summarise(
    total_sales = sum(sales, na.rm = TRUE),
    total_listings = sum(listings, na.rm = TRUE)
  ) %>%
  mutate(aggregated_ad_effectiveness = total_sales / total_listings) %>%
  arrange(desc(aggregated_ad_effectiveness))
print("Efficacia Aggregata (Sales/Listings):")
print(city_aggregated_stats)

# 6. VISUALIZZAZIONI CHIAVE (Esempi di plot salvati in oggetti)

# A. Trend Temporale con Media Mobile
plot_trend <- ggplot(data, aes(x = date_obj, y = median_price)) +
  geom_line(aes(color = city), alpha = 0.4, size = 0.6) +
  geom_line(aes(y = rollmean(median_price, k = 12, fill = NA, align = "right"), group = city), color = "purple", size = 1.2) +
  facet_wrap(~ city, scales = "free_y") +
  labs(title = "Trend Prezzo Mediano vs Media Mobile (12 mesi)") +
  theme_minimal()

# B. Analisi Inventario (Liquidità Mercato)
plot_inventory <- ggplot(data, aes(x = reorder(city, months_inventory, FUN = median), y = months_inventory, fill = city)) +
  geom_boxplot(alpha = 0.6) +
  geom_hline(yintercept = 6, linetype = "dashed", color = "red") +
  labs(title = "Distribuzione Mesi di Inventario (Liquidità)") +
  theme_minimal() + theme(legend.position = "none")

# Stampa grafici (se eseguiti in ambiente interattivo)
# print(plot_trend)
# print(plot_inventory)

message("Script eseguito correttamente.")
