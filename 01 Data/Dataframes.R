#Call datasets with appropriate SQL
grad_earnings <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "select REF_DATE, GEO, SCHOOL, GENDER, STATS, VALUE from GRAD_EARNINGS "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_map4542', PASS='orcl_map4542', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

grad_debt <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "select REF_DATE, GEO, SCHOOL, SOURCE, STATS, VALUE from GRAD_DEBT "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_map4542', PASS='orcl_map4542', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

grad_loans <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "select REF_DATE, GEO, SCHOOL, SOURCE, STATS, VALUE from GRAD_LOANS "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_map4542', PASS='orcl_map4542', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

grad_employment <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "select REF_DATE, GEO, SCHOOL, GENDER, STATS, VALUE from GRAD_EMPLOYMENT "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_map4542', PASS='orcl_map4542', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

#Data wrangling and PLOTS
#Avg DOCTORATE Grad Earnings in each Province, Year, by Gender
grad_earnings %>% filter(SCHOOL %in% c("Doctorate"), STATS == "Median", GENDER != "Both sexes", VALUE != "null") %>% ggplot(aes(x=GEO, y=VALUE, color=GENDER)) + geom_point() + ggtitle('Average Doctorate Graduate Earnings') + scale_color_brewer(palette="Set1") + facet_wrap(~REF_DATE) + theme(axis.text.x=element_text(angle=90, size=10, vjust=0.4), plot.title = element_text(size=20, face="bold", vjust=2), axis.title.x = element_blank())

#Create new table
doctorate_earnings <- grad_earnings %>% filter(SCHOOL %in% c("Doctorate"), STATS == "Median", GENDER != "Both sexes", VALUE != "null")

##Avg COLLEGE Grad Earnings in each Province, Year, by Gender
grad_earnings %>% filter(SCHOOL %in% c("College"), STATS == "Median", GENDER != "Both sexes", VALUE != "null") %>% ggplot(aes(x=GEO, y=VALUE, color=GENDER)) + geom_point() + ggtitle('Average College Graduate Earnings') + scale_color_brewer(palette="Set1") + facet_wrap(~REF_DATE) + theme(axis.text.x=element_text(angle=90, size=10, vjust=0.4), plot.title = element_text(size=20, face="bold", vjust=2), axis.title.x = element_blank())

#Create new table
college_earnings <- grad_earnings %>% filter(SCHOOL %in% c("College"), STATS == "Median", GENDER != "Both sexes", VALUE != "null")

#To remove ticks and text on axis
#axis.ticks.y = element_blank(),axis.text.y = element_blank()

