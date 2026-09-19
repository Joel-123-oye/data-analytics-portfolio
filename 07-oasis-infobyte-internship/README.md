# Oasis Infobyte Data Analytics Internship

8 of 9 assigned tasks completed across Level 1 and Level 2, applying Python-based analytics (Pandas, scikit-learn, NLP) in Google Colab. Task 9 (Fraud Detection) was not completed due to repeated Colab runtime issues with the large dataset.

## Task 1 — Data Cleaning (Titanic Dataset)
Cleaned missing values (Age), fixed zero-value errors (Fare, Sex), and capped 171 outliers in Fare rather than removing them, since high fares reflected genuine first-class pricing rather than data errors.

**Tools:** Python, Pandas

## Task 2 — EDA on Retail Sales Data (Superstore Dataset)
Analyzed monthly and quarterly sales trends from 2015–2018. Found a strong upward trend (from ~20-30K/month in 2015 to 60K+ by 2018) with clear seasonality — Q4 consistently the strongest quarter, Q1 the weakest. Identified the Canon imageCLASS 2200 as the top-selling product.

**Tools:** Python, Pandas, Matplotlib/Seaborn

## Task 3 — Customer Segmentation (Mall Customers Dataset)
Applied K-Means clustering (K=5, elbow method) on income and spending score. Identified 5 customer segments, with the largest group being "average income/spending" (~80 customers), plus smaller high-value segments. Delivered segment-specific marketing recommendations (VIP treatment for high-income/high-spending, loyalty nudges for the broad middle segment).

**Tools:** Python, scikit-learn (K-Means), Pandas

## Task 4 — Sentiment Analysis (IMDB 50K Movie Reviews)
Trained and compared Naive Bayes (85.14% accuracy) and Logistic Regression (88.66% accuracy) using TF-IDF features. Logistic Regression outperformed on precision and recall. Error analysis showed most misclassifications came from negation and ironic/context-dependent phrasing that TF-IDF can't capture.

**Tools:** Python, scikit-learn, TF-IDF, NLP

## Task 5 — House Price Prediction (Linear Regression)
Built a Linear Regression model (R² = 0.35) on an Indian housing dataset. SQUARE_FT and BHK_NO. were the strongest positive predictors; RESALE status had the strongest negative impact on price.

**Tools:** Python, scikit-learn (Linear Regression)

## Task 6 — Wine Quality Prediction
Compared Random Forest (73% accuracy — best), SVC (62%), and SGD (53%) on binned wine quality classes (low/medium/high). Random Forest handled the non-linear relationships best; alcohol content was the top predictive feature.

**Tools:** Python, scikit-learn (Random Forest, SVC, SGD)

## Task 7 — Google Play Store Analysis
Cleaned Installs/Price/Size fields and analyzed category saturation (FAMILY most saturated with ~1,900 apps), rating distribution (heavily right-skewed, most apps 4.0–4.5), pricing (93% free), and review sentiment (mostly positive, COMICS highest polarity). Found no strong correlation between app size and install count.

**Tools:** Python, Pandas, sentiment analysis

## Task 8 — Autocomplete & Autocorrect Analytics (Enron Email Dataset)
Built a trigram-based autocomplete model outperforming a simpler bigram approach, and a spellchecker-based autocorrect tool achieving perfect precision and recall (1.00) on 20 test misspellings.

**Tools:** Python, NLP (n-gram modeling, pyspellchecker)

---

## Files
Notebooks for each task are uploaded in this folder (`Task1_Data_Cleaning.ipynb` through `Task_8_Autocomplete_Autocorrect.ipynb`).
