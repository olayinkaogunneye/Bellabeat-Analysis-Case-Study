---
  Google Data Analysis Case Study

Olayinka Ogunneye

---
  
  ## Business Task
  
  For the Google Data Analytics Certification, this is the final project.
For this case study, I have been entrusted with helping Bellabeat, a maker
of wearable fitness equipment, enhance the marketing tactics for their goods 
by examining consumer behaviour with rival fitness trackers like FitBit.

## Ask Phase:

* First, we must ask ourselves: Who are our principal stakeholders? 
  We have the following stakeholders in this situation:
  
  * Bellabeat's co-founder and chief creative officer, Urka Sren,
  Mathematician and co-founder of Bellabeat Sando Mur is also part of the 
  Bellabeat management group.

* The data analysts who make up the Bellabeat analytics team for marketing 
  collect, analyse, and report data that is used to help formulate the company's 
marketing strategy.

## Business Objectives:

How are customers using other fitness trackers, in their daily life?
  What particular features seem to be the most heavily used?
  What features do Bellabeat products already have that consumers want, 
and how do we focus marketing on those aspects?
  
  ## Prepare Phase:
  
  Sršen advised me to use publicly accessible data that looks at smart device 
owners' everyday habits. She points me towards the next data set:

  FitBit fitness tracker data (CC0: Public Domain; made available through Mobius):
  This Kaggle data collection uses personal fitness trackers from thirty Fitbit 
  customers. The personal tracker data of thirty eligible Fitbit users, including 
  minute-level output for heart rate, sleep, and physical activity monitoring, 
  were willingly submitted. It has information on steps taken each day, heart rate 
  and daily activities that may be investigated to find out more about users' 
habits. On Kaggle, 18 csv files containing FitBit fitness tracker data are 
freely available.

We identify the data being used and its constraints during the Prepare step.

Data was gathered in 2016 seven years ago. Since then, users’ routines for 
everyday activity, eating, exercising, and sleeping may have changed. 
Data might not be current or pertinent.

A sample size of 30 FitBit users does not accurately represent the fitness 
market as a whole.

We cannot guarantee the integrity or correctness of the data because it is 
acquired through a survey.

Is Data ROCCC?
  ROCCC, which stands for Reliable, Original, Comprehensive, Current, and 
Cited, is a reliable source of data.

Reliable — LOW — 30 responders makes it unreliable.
Original — LOW — Third party provider (Amazon Mechanical Turk).
Comprehensive — MED — Parameters are in line with the majority of Bellabeat 
devices’ parameters.
Current — LOW — 7-year-old data may no longer be relevant.
Cited — LOW — Data obtained from an unidentified third party Overall, 
the dataset is regarded as having low quality data, and it is not advised 
to base business suggestions on it.

## Process Phase:

I will be using tidyverse package as well as the skimr, here, and janitor 
packages for help with this project.

We’re also using the sqldf package, which will allow us to emulate SQL syntax 
when looking at data

Load Packages

library(tidyverse)
library(sqldf)
library(ggplot2)
library(skimr)
library(janitor)
library(dplyr)
library(lubridate)

Load the CSV files

In this case study, the data frames I'll be using to create objects for are

  daily_activity

  daily_calories

  daily_sleep

  weight_log info

  hourly_intensities
  
  
daily_activity <- read.csv("C:\\Users\\olayi\\Desktop\\Data\\R\\Bellabeat Project\\Fitabase Data 4.12.16-5.12.16\\dailyActivity_merged.csv")
  
daily_calories <- read.csv("C:\\Users\\olayi\\Desktop\\Data\\R\\Bellabeat Project\\Fitabase Data 4.12.16-5.12.16\\dailyCalories_merged.csv")

daily_sleep <- read.csv( "C:\\Users\\olayi\\Desktop\\Data\\R\\Bellabeat Project\\Fitabase Data 4.12.16-5.12.16\\sleepDay_merged.csv") 

weight_log <- read.csv("C:\\Users\\olayi\\Desktop\\Data\\R\\Bellabeat Project\\Fitabase Data 4.12.16-5.12.16\\weightLogInfo_merged.csv")

hourly_intensities <- read.csv("C:\\Users\\olayi\\Desktop\\Data\\R\\Bellabeat Project\\Fitabase Data 4.12.16-5.12.16\\hourlyIntensities_merged.csv")

## Explore Tables

#### daily_activity

head(daily_activity)
colnames(daily_activity)
glimpse(daily_activity)

#### daily_calories

head(daily_calories)
colnames(daily_calories)
glimpse(daily_calories)

#### daily_sleep

head(daily_sleep)
colnames(daily_sleep)
glimpse(daily_sleep)

#### weight_log

head(weight_log)
colnames(weight_log)
glimpse(weight_log)
summarize(weight_log)

#### hourly_intensities

head(hourly_intensities)
colnames(hourly_intensities)
glimpse(hourly_intensities)

## My inference

After running these commands, we discovered that:

* Number of columns and records
* Number of values, both null and non-null
* Kind of data for each column

As a result, we discover that the weight log information has 67 entries, the 
daily sleep data contains 413 records, and the daily activity data contains 
940 records. There are null values in the "Fat" variable in the weight log 
information; this can be fixed by removing the variable or by replacing the 
NA values with the most typical values; otherwise, cleaning the data is not 
required. I also discovered some issues with the timestamp information. I must 
convert it to date-time format and divide it into date and time before I can 
analyse it.


daily_activity

daily_activity$ActivityDate=as.POSIXct(daily_activity$ActivityDate, format="%m/%d/%Y", 
        tz=Sys.timezone())
daily_activity$date <- format(daily_activity$ActivityDate, format = "%m/%d/%y")

daily_calories

daily_calories$ActivityHour=as.POSIXct(daily_calories$ActivityHour, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
daily_calories$time <- format(daily_calories$ActivityHour, format = "%H:%M:%S")
daily_calories$date <- format(daily_calories$ActivityHour, format = "%m/%d/%y")

hourly_intensities

hourly_intensities$ActivityHour=as.POSIXct(hourly_intensities$ActivityHour, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
hourly_intensities$time <- format(hourly_intensities$SleepDay, format = "%H:%M:%S")
hourly_intensities$date <- format(hourly_intensities$SleepDay, format = "%m/%d/%y")

daily sleep

daily_sleep$SleepDay=as.POSIXct(daily_sleep$SleepDay, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
daily_sleep$time <- format(daily_sleep$SleepDay, format = "%H:%M:%S")
daily_sleep$date <- format(daily_sleep$SleepDay, format = "%m/%d/%y")

weight_log

weight_log$Date=as.POSIXct(weight_log$Date, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
weight_log$time <- format(weight_log$Date, format = "%H:%M:%S")
weight_log$date <- format(weight_log$Date, format = "%m/%d/%y")

The Analysis

Exploring and summarizing data

n_distinct(daily_activity$Id)
n_distinct(daily_calories$Id)
n_distinct(daily_intensities$Id)
n_distinct(daily_sleep$Id)
n_distinct(weight_log$Id)

daily_activity %>%  
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes,
         VeryActiveMinutes) %>%
  summary()
  
  daily_sleep
  
  daily_sleep %>%  
  select(TotalSleepRecords,
  TotalMinutesAsleep,
  TotalTimeInBed) %>%
  summary()

daily_calories %>%
  select(Calories) %>%
  summary()
  
  weight_log %>%
  select(WeightKg, BMI) %>%
  summary()
  
  daily_activity %>%
  select(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes) %>%
  summary()
  
  Some fascinating findings from this summary:
  
  Daily_activity
  
  The average distance travelled is 5.490km, less than the needed eight kilometres, 
  and the average number of steps taken is 7638 fewer than the recommended ten 
  thousand steps.The average amount of inactive time is 991.2 minutes, or 16.52 
  hours, which is significantly greater than the suggested maximum of 7 hours.
  The average daily caloric intake of a user is 2,304 kCal.The daily goal of 
  30 minutes is not attained by the average of 21.16 minutes of vigorous activity.
  
  Daily_Sleep
  
  The average user sleeps for a total of 419 minutes, or around 7 hours.
  The typical night in bed lasts 458 minutes (or 7 hours 30 min),this suggests 
  that the average user is awake in bed for roughly 30 minutes.
  
Merging data

Before beginning to visualize the data, I need to merge two data sets. I’m going 
to merge (inner join) daily_activity and daily_sleep on columns Id and date 
(that I previously created after converting data to date time format).

merged_activity_data <- merge(daily_sleep, daily_activity, by=c('Id', 'date'))
head(merged_activity_data)
str(merged_activity_data)
glimpse(merged_activity_data)

Visualization

ggplot(data=daily_activity, aes(x=TotalSteps, y=Calories)) + 
  geom_point() + geom_smooth() + labs(title="Total Steps vs. Calories")

  There is an evident positive association between Total Steps and Calories; the 
  more active we are, the more calories we burn.


ggplot(data=daily_sleep, aes(x=TotalMinutesAsleep, y=TotalTimeInBed)) + 
  geom_point()+ labs(title="Total Minutes Asleep vs. Total Time in Bed")
  
  As can be seen, TotalMinutesAsleep and TotalTimeInBed have a strong positive 
  association; nevertheless, the centre and top of the scatter plot contain 
  numerous outliers.The outliers are those who spent a great deal of time in 
  bed yet did not sleep.There could be a lot of reasons for that.

Let's look at intensities data over time (hourly)

new_intensities <- hourly_intensities %>%
  group_by(time) %>%
  drop_na() %>%
  summarise(mean_total_int = mean(TotalIntensity))  

ggplot(data=new_intensities, aes(x=time, y=mean_total_int)) + geom_histogram(stat = "identity", fill='darkblue') +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title="Average Total Intensity vs. Time")

The busiest hours are between 5 p.m. and 7 p.m. - I assume people go to the gym 
or for a walk after work. This time in the Bellabeat app can be used to remind 
and motivate users to run 
or walk.

Let's look at the relationship between Total Minutes Asleep and Sedentry Minutes.

ggplot(data=merged_activity_data, aes(x=TotalMinutesAsleep, y=SedentaryMinutes)) + 
geom_point(color='darkblue') + geom_smooth() +
  labs(title="Minutes Asleep vs. Sedentary Minutes") 
  
  Here, the negative relationship between Sedentary Minutes and Sleep time is evident.

  As an example, if Bellabeat users desire to improve their sleep, the app can 
  suggest they spend less time sitting.

  Keep in mind that we need further evidence to support this conclusion, 
  as correlation between some variables does not imply causation.
  
Summarizing recommendations for the business

What are some trends in smart device usage?

  The average sitting time for users is 16 hours per day.
  The typical daily step count is 7638. This is less steps than the adult 
  recommendation of 10,000.
  A user’s average sleep duration is 419 minutes, or roughly 7 hours. 
  Additionally, an average night in bed lasts 458 minutes (or 7 hours 30 min). 
  The aforementioned two statements imply that the typical user spends about 
  30 minutes awake in bed.
  
  How could these trends help influence Bellabeat marketing strategy?
  
  The correlations between steps and calories burnt as well as extremely active 
  minutes and calories burned exhibit a positive link. So, this may be an 
  effective marketing strategy.
  
  Bellabeat marketing team may inspire clients by educating them on the benefits 
  of exercise, recommending various routines, and giving information on calorie 
  intake and burn rate via the Bellabeat application.
  
  
  