

###############################################################
###############################################################
###############################################################
###############################################################
###############################################################
###############################################################
df <- read.csv("months.csv")
df <- df[1:4]
df <- df[-1,]
cnames <- c("accountid", "startdate", "enddate", "mnthsinvd")
colnames(df) <- cnames
df2 <- df[-which(df$enddate==0),]
df2$mnthsinvd <- as.numeric(df2$mnthsinvd)
mnmns <- mean(df2$mnthsinvd)
maxmn <- max(df2$mnthsinvd)
hist(df2$mnthsinvd, breaks = 100) ###change breaks for different plots 
length(which(df2$mnthsinvd<=5)) ##24616
length(which(df2$mnthsinvd<=2)) #24418
length(which(df2$mnthsinvd==1)) #20297
contact=read.csv("ContactsClean.csv")
#merge in the entire contacts clean, not just the 4 columns

cred <- read.csv("credit.csv")
k <- merge(df2, cred, by.x = "accountid", by.y = "AccountId", all.x = TRUE)
r <- sum(is.na(k$Last_Hard_Credit_Amount__c))


#has major donor column
#Has AccountId


####ACCOuNTS
accts <- read.csv("AccountsCleanUpdated.csv")
df3 <- merge(df2, accts, by.x="accountid", by.y = "AccountId")

bios <- read.csv("rcbios.csv")

left <-merge(df3, bios, by.x = "accountid", by.y = "AccountId")
library(dplyr)
data <- left %>% distinct ###########most of the data we want

data[data==TRUE] <- 1


noact <- unique(data$accountid)

####fulldata 
full <- merge(df, accts, by.x = "accountid", by.y = "AccountId")
full2 <-merge(full, bios, by.x = "accountid", by.y = "AccountId")

full3 <- full2 %>% distinct ###########most of the data we want
full3[full3==TRUE] <- 1
full3$NLA <- 0
full3$NLA[full3$mnthsinvd!=0] <- 1
