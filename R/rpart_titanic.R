#rpart_titanic
dat <- read.csv("../../data/titanic3.1.csv")
dat$survived <- as.factor(dat$survived)
dat$sex <- as.factor(dat$sex)
dat$pclass <- as.factor(dat$pclass)
dat$sibsp <- as.factor(dat$sibsp)
dat$parch <- as.factor(dat$parch)
dat$embarked <- as.factor(dat$embarked)
library(rpart)
dt_mdl <- rpart(formula = survived ~ sex + pclass + age + sibsp + parch + embarked, 
                data    = dat, 
                method  = "class"
                )
library(partykit)
plot(as.party(dt_mdl), main="test")
