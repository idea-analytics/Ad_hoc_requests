library(ideadata)
library(tidyverse)
library(glue)
library(stringr)

# Get student table

std_addresses <- get_table(.server_name ="RGVPDSD-DWPRD1", 
                           .database_name = "PROD1", 
                           .schema = "Schools", 
                           .table_name = "Students") %>%
  filter(AcademicYear=="2023-2024",
         EnrollmentStatus %in% c(0, 3),
         PhysicalStreet!= " ") %>%
  select(StudentNumber, StudentFullName, LastName, PhysicalStreet, PhysicalCity, PhysicalState, PhysicalZIP)%>%
  collect()%>%
  mutate(address = stringr::str_remove(PhysicalStreet, ",.-"))%>%
  distinct(LastName, PhysicalStreet)
write.csv(std_addresses, "Family addresses.csv")

