---
title       : Global Socioeconomic Evaluation
subtitle    : Application in Shiny
author      : Bamini Balaji
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [htmlwidgets]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Overview

This presentation is part of the Developing Data Products Coursera course project submission.

The goal of this project was to create a shiny application to visualize worldwide socioeconomic indicators over time. 

Data was sourced from the [Kaggle dataset](https://www.kaggle.com/sdorius/countryses) 

The shiny application can be found [here](https://bbamini.shinyapps.io/socioeconomic/)

The Github repository containing the code for the shiny app can be found [here](https://github.com/bbamini/Data-Products-Project)

--- .class #id 

## Kaggle Data Set

Three socioeconomic indicators were evaluated:

- GDP per capita
- Socioeconomic status score
- Years of education a typical adult underwent

Here are the years that were considered in this evaluation

```
##  [1] 1880 1890 1900 1910 1920 1930 1940 1950 1960 1970 1980 1990 2000 2010
```

Here are the number of countries that were evaluated:

```
## [1] 74
```

---

## Table Visualization

The Best and Worst tab in the app displays the 10 countries with the lowest values and 10 countries with the highest values for the economic indicator in a given year. 

Here is the output for the 5 countries with highest GDP per capita in 2010 

```
FALSE           country      ses    gdppc yrseduc
FALSE 700        Norway 97.29729 62268.01 12.2965
FALSE 868   Switzerland 83.10811 55541.67  9.8763
FALSE 994 United States 96.95946 49372.62 13.0971
FALSE 420       Ireland 92.56757 45661.47 11.6400
FALSE 616   Netherlands 89.52702 45524.66 11.0226
```



---

## Map Visualization

Here is the output for the global distribution of GDP per capita in 2010 


```r
g <- list(showframe = FALSE, showcoastlines = TRUE, projection = list(type = 'Mercator'))
p <- plot_geo(yr_interest) %>% add_trace(z = ~gdppc, color = ~gdppc, text = yr_interest$country, locations = yr_interest$country, locationmode = "country names") %>% colorbar(title = "GDP Per Capita", limits = c(500, 50000)) %>% layout(geo = g)
htmlwidgets::saveWidget(as.widget(p), file = "demo.html")
```
<iframe src="demo.html" style="position:absolute;height:70%;width:70%"></iframe>
