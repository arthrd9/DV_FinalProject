#Call datasets with appropriate SQL
grad_earnings <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "select REF_DATE, GEO, SCHOOL, GENDER, STATS, VALUE from GRAD_EARNINGS "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_map4542', PASS='orcl_map4542', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

grad_debt <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "select REF_DATE, GEO, SCHOOL, SOURCE, STATS, VALUE from GRAD_DEBT "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_map4542', PASS='orcl_map4542', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

grad_loans <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "select REF_DATE, GEO, SCHOOL, SOURCE, STATS, VALUE from GRAD_LOANS "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_map4542', PASS='orcl_map4542', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

grad_employment <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "select REF_DATE, GEO, SCHOOL, GENDER, STATS, VALUE from GRAD_EMPLOYMENT "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_map4542', PASS='orcl_map4542', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

#Data wrangling and PLOTS
####################################################################################################

## Grad Earnings

#Avg DOCTORATE Grad Earnings in each Province, Year, by Gender Plot
grad_earnings %>% filter(SCHOOL %in% c("Doctorate"), STATS == "Median", GENDER != "Both sexes", VALUE != "null") %>% ggplot(aes(x=GEO, y=VALUE, color=GENDER)) + geom_point() + ggtitle('Average Doctorate Graduate Earnings') + scale_color_brewer(palette="Set1") + facet_wrap(~REF_DATE) + theme(axis.text.x=element_text(angle=90, size=10, vjust=0.4), plot.title = element_text(size=20, face="bold", vjust=2), axis.title.x = element_blank())

#Doctorate earnings table
doctorate_earnings <- grad_earnings %>% filter(SCHOOL %in% c("Doctorate"), STATS == "Median", GENDER != "Both sexes", VALUE != "null")

#Avg COLLEGE Grad Earnings in each Province, Year, by Gender Plot
grad_earnings %>% filter(SCHOOL %in% c("College"), STATS == "Median", GENDER != "Both sexes", VALUE != "null") %>% ggplot(aes(x=GEO, y=VALUE, color=GENDER)) + geom_point() + ggtitle('Average College Graduate Earnings') + scale_color_brewer(palette="Set1") + facet_wrap(~REF_DATE) + theme(axis.text.x=element_text(angle=90, size=10, vjust=0.4), plot.title = element_text(size=20, face="bold", vjust=2), axis.title.x = element_blank())

#College earnings table
college_earnings <- grad_earnings %>% filter(SCHOOL %in% c("College"), STATS == "Median", GENDER != "Both sexes", VALUE != "null")

####################################################################################################

##Avg 2010 Grad Debt Plot
grad_debt %>% filter(REF_DATE == 2010, SOURCE == "Graduates who owed money for their education to government student loan programs", STATS == "Average debt owed to the source at time of graduation dollars", VALUE != "null") %>% ggplot(aes(x=GEO, y=VALUE, color=SCHOOL)) + geom_point() + ggtitle('Average Debt Owed\n to Government Loans in 2010') + scale_color_brewer(palette="Set1") + theme(axis.text.x=element_text(angle=90, size=10, vjust=0.4), axis.title.y = element_blank(), axis.title.x = element_blank(), legend.title=element_blank(), plot.title = element_text(size=20, face="bold", vjust=2, lineheight=0.8))

#2010 debt table, descending by average debt
debt2010 <- grad_debt %>% filter(REF_DATE == 2010, SOURCE == "Graduates who owed money for their education to government student loan programs", STATS == "Average debt owed to the source at time of graduation dollars", VALUE != "null") %>% arrange(desc(VALUE))

####################################################################################################

##Doctorate Grad Employment Plot 
doctorate_employment_rates <- grad_employment %>% filter(SCHOOL %in% c("Doctorate"), STATS %in%  c("Unemployed rate", "Employed percent"), GENDER != "Both sexes", VALUE != "null") %>% arrange(desc(VALUE)) %>% tbl_df

grad_employment %>% filter(SCHOOL %in% c("Doctorate"), STATS %in%  c("Unemployed rate", "Employed percent"), GENDER != "Both sexes", VALUE != "null") %>% arrange(desc(VALUE)) %>% ggplot(aes(x = STATS, fill = STATS)) + geom_bar(stat= "bin") + ggtitle('Doctorate Employment Across Canada') + theme(axis.title.y = element_blank(), axis.text.x = element_blank(), axis.title.x = element_blank(), plot.title = element_text(size=20, face="bold", vjust=2, lineheight=0.8), legend.title=element_blank()) + facet_wrap(~REF_DATE)

##College Grad Employment Plot
college_employment_rates <- grad_employment %>% filter(SCHOOL %in% c("College"), STATS %in%  c("Unemployed rate", "Employed percent"), GENDER != "Both sexes", VALUE != "null") %>% arrange(desc(VALUE)) %>% tbl_df

grad_employment %>% filter(SCHOOL %in% c("College"), STATS %in%  c("Unemployed rate", "Employed percent"), GENDER != "Both sexes", VALUE != "null") %>% arrange(desc(VALUE)) %>% ggplot(aes(x = STATS, fill = STATS)) + geom_bar(stat= "bin") + ggtitle('College Employment Across Canada') + theme(axis.title.y = element_blank(), axis.text.x = element_blank(), axis.title.x = element_blank(), plot.title = element_text(size=20, face="bold", vjust=2, lineheight=0.8), legend.title=element_blank()) + facet_wrap(~REF_DATE)



