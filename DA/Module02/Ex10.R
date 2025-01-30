#create data frame
df <- data.frame(team=c('A', 'A', 'B', 'B', 'B', 'B', 'C', 'C'),
                 points=c(25, 12, 15, 14, 19, 23, 25, 29))

#view data frame
df

#perform label encoding on team variable
df$team <- as.numeric(factor(df$team))

#view updated data frame
df

install.packages("CatEncoders")
library(CatEncoders)
#create data frame
df <- data.frame(team=c('A', 'A', 'B', 'B', 'B', 'B', 'C', 'C'),
                 points=c(25, 12, 15, 14, 19, 23, 25, 29))
#define original categorical labels
labs = LabelEncoder.fit(df$team)
#convert labels to numeric values
df$team = transform(labs, df$team)
#view updated data frame
df

#display original team labels
inverse.transform(labs, df$team)
