## LOAD PACKAGES ##
library(dplyr)

## READ IN DATA ##
#all season
data <- read.table('./data/rcourse_lesson3_data.txt', sep = "\t", 
                   header = TRUE)

#posey
data_posey <- read.table('./data/rcourse_lesson3_data_posey.txt', 
                         sep = "\t", header = TRUE)

## CLEAN DATA ##
#add columns to make dataset specific to Giants
data_clean <- data %>% 
  mutate(home_visitor = ifelse(home_team == "SFN", "home", "visitor")) %>%
  mutate(allstar_break = ifelse(date < 20100713, "before", "after")) %>%
  mutate(win = ifelse(home_team == 'SFN' & home_score > visitor_score, 1,
                      ifelse(visitor_team == 'SFN' & home_score < visitor_score,1,0)))

#combine full season data with player (Buster Posey)
data_posey_clean <- data_posey %>% inner_join(data_clean) %>%
  mutate(walked = ifelse(walks >0,'yes','no'))
