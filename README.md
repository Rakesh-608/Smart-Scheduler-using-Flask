
# Smart Scheduler

In this application, the automatically generated timetable reduces the complication of manually setting and managing a timetable.

What you need to run this code  
Python (3.10 - minimum)   
XAMPP





## Installation

- Create a virtual environment using (In windows OS)

```bash
    python -m venv <env> 
```
- Activate your virtual environment.
```bash
    cd <env>/Scripts
    cd activate
```
- Turn on your MySQL server in XAMPP.

```bash
  cd my-project

  pip install flask pymysql pandas pdfkit flask_mail
```

- Edit the main.py by replacing your email address and password (Otherwise use security key instead of revealing password)

```bash

  python main.py
```

- Open http://127.0.0.1:5000/ in the browser

    
# Usage


## Admin Login : 
If you want to assign couses to faculty and generate timetable, use credentials "admin@timetable.com", "admin" as username, password respectively in login page.

#### functionalities:
- Add subjects to particular academic years
- Add laboratories to particular academic years
- Manage and edit subjects
- Generate timetables
- Share the timetables


## Faculty Registration & Login: 
All the faculty need to registered with the email and give their essential data thar have asked for the process that include subject knowledge. After successful registration, faculty can check their respective schedules.

#### functionalities:
- Register (once per faculty)
- Login
- View their data 
- View assigned schedules 

## Student Registration:

Students should register and view their class timetable on login.




