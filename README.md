# SchedulePlanner Project

This repo contains the different sources that are used in conjunction with AppSmith to create our SchedulePlanner application, to be used by both advisors and students at Northeastern University. SchedulePlanner allows advisors to better understand what their students need to be taking at Northeastern, while also explaining requirements for different majors to students. As students with non-traditional majors (combined and double majors), the problem of figuring out which classes to take and when to take them directly affects us.

## Database
The db folder contains a bootstrap sql file named db_bootstrap.sql which contains the sql for all the tables including mock values. Each table includes primary key(s) and foreign key(s).
Here are the following tables and attributes:

- **Department**: Deptame, CollegeName
- **Class**: CourseNumber, Department, CourseHours, Professor, Rating, PrerequisiteCourseNumber, PrerequisiteDepartment, CorequisiteCourseNumber, CorequisiteDepartment
- **Major**: MajorName
- **Plan**: MajorName, SemesterNumber, CourseNumber, DepartmentNumber
- **Advisor**: NUID, FirstName, MiddleName, LastName, BirthDate, StreetAddress, City, State, Country, ZipCode, HireYear
- **HighSchool**: CEEB, Name
- **Student**: NUID, FirstName, MiddleName, LastName, BirthDate, StreetAddress, City, State, Country, ZipCode, CoopCycle, GradYear, Minor, MajorName, HighschoolCEEB, AdvisorID
- **TransferCollege**: FederalCode, Name
- **TransferClass**: FederalCode, CourseNumber, CourseDepartment, Hours
- **HighSchoolClass**: Name, StudentID, HSDepartment, Hours, CEEB

## Flask App
The flask-app folder contains routes for two different personas - advisors and students, as well as for classes. Here, routes contain both get and post requests.

**Student Routes**:
- Get all students
- Get all students by major
- Get all students under an Advisor ID
- Get all students by their NUID
- Updating a student's minor
- Getting a courseplan related to a student's major

**Advisor Routes**:
- Get all advisors by their NUID
- Get all advisors by their last name
- Changing the courses associated with a major plan

**Class Routes**:
- Get the top 5 rated classes
- Get all the classes associated with a department


## Docker Compose
The 'docker-compose.yml' file is used to work as a medium by putting files within containers that the local machine can recognize and to run everything together in unison.

## Ngrok and AppSmith
Ngrok was utilied to host necessary local data and connect our REST Api in AppSmith. Due to the use of a free account, there are some limitations when it comes to the number of requests. Through the use of ngrok and appsmith, we were able to create a functional and operational application that utilizes a schedule database.

## Video Demo
[![Video](https://img.youtube.com/vi/yukyIz2Y1is/sddefault.jpg)](https://youtu.be/yukyIz2Y1is)
