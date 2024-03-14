from flask import Flask, render_template, request, flash, session, redirect, url_for,send_from_directory
import pymysql
import pandas as pd
import calendar
import random
import os
import pdfkit
from flask_mail import Mail, Message


mydb=pymysql.connect(user="root", password="", port=3306, db="time_table")

app=Flask(__name__)
app.config['SECRET_KEY']="This is a very very secret key."

app.config['MAIL_SERVER'] = 'smtp.gmail.com'  # Your email server
app.config['MAIL_PORT'] = 587  # Your mail server's port (e.g., 587 for SMTP)
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'mail@example.com'  # Your email address
app.config['MAIL_PASSWORD'] = 'password' # Your email password
mail = Mail(app)

def all_teachers():
    #TRUNCATE TABLE
    register=pd.read_sql_query('select * from register',mydb)
    class_subz=pd.read_sql_query('select * from class_subz',mydb)
    class_subz.columns=[v.lower() for v in class_subz.columns]
    print(register)
    #register management
    reg3=register.drop(['subject3','experience','password'],axis=1)
    reg2=register.drop(['subject2','experience','password'],axis=1)
    reg1=register.drop(['subject1','experience','password'],axis=1)
    print(reg1)
    print(reg2)
    print(reg3)
    reg1.columns=['name','email', 'subject', 'experience']
    reg2.columns=['name','email', 'subject', 'experience']
    reg3.columns=['name','email', 'subject', 'experience']
    

    reg3=pd.concat([reg1,reg2,reg3],axis=0).sort_values(by=['name','experience'], ascending=[True, False])
    print(reg3)
    print("123456789")
    print("All_teachers")

    reg4=reg3.merge(class_subz.drop(['sn'],axis=1), on='subject')
    reg4=reg4.sort_values(by=['year','semester','subject','experience'],ascending=[True, True, True, False])
    #Selecting only the higly experienced faculty for a subject
    reg5=reg4.drop_duplicates(['subject'], keep='first')
    print("===========================")
    print(reg5)
    for row in reg5.iterrows():
        
        val=(row[1][0],row[1][1],row[1][2],row[1][3],row[1][4],row[1][5])
        sql="INSERT INTO all_teachers(name, email, subject, experience, year, semester) values (%s, %s, %s, %s, %s, %s)"
        cur=mydb.cursor()
        cur.execute(sql,val)
        mydb.commit()
        cur.close()
    return reg5

def all_teachers_labs():
    #TRUNCATE TABLE
    sql="truncate table all_teachers_labs"
    cur = mydb.cursor()
    cur.execute(sql)
    mydb.commit()

    register=pd.read_sql_query('select * from register',mydb)
    class_lab=pd.read_sql_query('select * from class_lab', mydb)
    class_lab.columns=[v.lower() for v in class_lab.columns]

    #register management
    reg1=register.drop(['subject2','experience','password',],axis=1)
    reg2=register.drop(['subject1','experience','password'],axis=1)
    reg3=register.drop(['subject3','experience','password',],axis=1)
    
    reg1.columns=['name','email', 'subject', 'experience']
    reg2.columns=['name','email', 'subject', 'experience']
    reg3.columns=['name','email', 'subject', 'experience']

    reg3=pd.concat([reg1,reg2,reg3],axis=0).sort_values(by=['name','experience'], ascending=[True, False])

    reg4=reg3.merge(class_lab.drop(['sn'],axis=1), left_on='subject', right_on='lab')
    #Add seminar and project for final year students in the list at random
    #all faculties from final year and 2nd sem are
    sql="select * from all_teachers"
    final_yr_facz=pd.read_sql_query(sql, mydb)
    print(final_yr_facz)
    select_for_labs=final_yr_facz.sample(n=2).drop(['sn'],axis=1)
    select_for_labs['lab']=random.sample(list(class_lab.query("year==4 and semester==2").lab),k=2)

    reg4=pd.concat([reg4, select_for_labs], axis=0, ignore_index=True)
    reg4=reg4.sort_values(by=['year','semester','lab','experience'],ascending=[True, True, True, False])

    #Selecting only the higly experienced faculty for a subject
    reg5=reg4.drop_duplicates(['lab'], keep='first')
    reg5.drop(['subject'], axis=1, inplace=True)

    for row in reg5.iterrows():
        sql="INSERT INTO all_teachers_labs(name, email, experience, year, semester, lab) values (%s, %s, %s, %s, %s, %s)"
        val=(row[1][0],row[1][1],row[1][2],row[1][3],row[1][4],row[1][5])
        cur=mydb.cursor()
        cur.execute(sql,val)
        mydb.commit()
        cur.close()
    return reg5

def find_available_lab_sessions(free_periods, lab_slots):
    avail=[]
    for i in range(len(free_periods)):
        try:
            avail.append([free_periods[i],free_periods[i+1],free_periods[i+2]])
        except:
            pass
    return [l for l in lab_slots if l in avail]


def time_table(reg_sub, reg_lab):
    #Truncate time_table table
   
    sql="TRUNCATE TABLE time_table"
    cur=mydb.cursor()
    cur.execute(sql)
    mydb.commit()
    cur.close()
    
    for day in calendar.day_name[0:6]:
        for period in range(1,8):
            for yr in range(1,5):
                for sem in range(1,3):
                    # All subjects and faculties assigned to the class
                    class_df=reg_sub.query("(year==@yr) and (semester==@sem)")
                    #Deciding period for each subject(row) in class_df
                    for i in range(5):
                        class_df=class_df.sample(frac=1)
                        for row in class_df.iterrows():
                            #Select all (already) assigned periods to that faculty on that day
                            sql="select period from time_table where faculty=%s and day=%s"
                            val=(row[1]['name'],day)
                            cur=mydb.cursor()
                            cur.execute(sql,val)
                            all_periods=cur.fetchall()
                            all_periods=[int(i[0]) for i in all_periods]
                            mydb.commit()
                            #Assign a period which does not exist in all_periods
                            #Periods in which the faculty is free
                            faculty_free_periods=list(set(all_periods)^set(range(1,8)))

                            #Periods in which the class is free
                            sql="select period from time_table where day=%s and year=%s and semester=%s"
                            val=(day, yr, sem)
                            cur=mydb.cursor()
                            cur.execute(sql,val)
                            all_periods=cur.fetchall()
                            all_periods=[int(i[0]) for i in all_periods]
                            mydb.commit()

                            class_free_periods=list(set(all_periods)^set(range(1,8)))

                            #Free periods for both, the teacher and the class are
                            combined_free_periods=list(set(faculty_free_periods).intersection(class_free_periods))
                            combined_free_periods.sort()

                            if combined_free_periods==[]:
                                if class_free_periods==[]:
                                    pass
                                else:
                                    
                                    #No one is available.
                                    #Let us provide a gap to the students when all faculties are fully scheduled.
                                    sql="INSERT INTO time_table(day, period, faculty, subject, year, semester) VALUES (%s,%s,%s,%s,%s,%s)"
                                    val = (day, class_free_periods[0], 'Gap period', 'Gap period', yr, sem)
                                    cur = mydb.cursor()
                                    cur.execute(sql, val)
                                    mydb.commit()
                                    cur.close()
                            else:
                                #Subject assignment
                                #select one of them
                                
                                select_period=random.sample(combined_free_periods, k=1)[0]
                                #Insert all details in time_table table
                                sql="INSERT INTO time_table(day, period, faculty, subject, year, semester) VALUES (%s, %s, %s, %s, %s, %s)"
                                val=(day, select_period, row[1]['name'], row[1]['subject'], yr, sem)
                                cur=mydb.cursor()
                                cur.execute(sql,val)
                                mydb.commit()
                                cur.close()
    return None

@app.before_first_request
def initialize():
    session.pop('loggedin',None)
    session.pop('isadmin',None)
    session.pop('name',None)
    session.pop('email',None)
    session['loggedin']=False
    session['isadmin']=False


@app.route('/')
@app.route('/home')
def home():
    return render_template('index.html', login=session['loggedin'], isadmin=session['isadmin'])

@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method=='POST':
        email=request.form['email']
        password=request.form['password']
        print(email)
        print(password)
        if email=='admin@timetable.com':
            if password=="admin":
                flash(r"Admin Logged In Successfully.","success")
                session['isadmin']=True
                session['loggedin']=True
                return render_template('login.html', login=session['loggedin'], isadmin=session['isadmin'])
            else:
                flash(r"Incorrect Password","warning")
        else:
            register=pd.read_sql_query('select * from register', mydb)
            all_faculties=register['email'].values
            if email in all_faculties:
                sql="select password from register where email='%s'"%(email)
                cur=mydb.cursor()
                cur.execute(sql)
                pwd=cur.fetchall()[0][0]
                if password==pwd:
                    flash(r"Login Successful","success")
                    session['loggedin']=True
                    session['isadmin']=False
                    session['email']=email
                    sql = "select name from register where email='%s'" % (email)
                    cur = mydb.cursor()
                    cur.execute(sql)
                    name = cur.fetchall()[0][0]
                    session['name']=name
                    return render_template('login.html', login=session['loggedin'], isadmin=session['isadmin'])
                else:
                    flash(r"Password did not match","warning")
            else:
                flash(r"Email Not Registered.","info")
    return render_template('login.html', login=session['loggedin'], isadmin=session['isadmin'])

@app.route("/studentregister",  methods=['POST', 'GET'])
def studentregister():
    cur=mydb.cursor()
    if request.method == "POST":
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        year = request.form['year']
        sem = request.form['sem']
        contact = request.form['mobile']
        address = request.form['address']
        print(name, email,year,sem, password, contact, address)
        print(name, email, password, address)
        sql = "insert into students (name, email,year,sem, password, contact, address)values(%s,%s,%s,%s,%s,%s,%s)"
        val = (name, email,year,sem, password, contact, address)
        cur=mydb.cursor()
        cur.execute(sql, val)
        data = mydb.commit()
        print(data)
        print("******")
        return render_template('studentregister.html', msg="data added successfully")
    return render_template("studentregister.html")


@app.route("/studentlogin", methods=["POST", "GET"])
def studentlogin():
    if request.method == "POST":
        email = request.form['email']
        password = request.form['password']
        sql = "select * from students where email='%s' and password='%s'"%(email, password)
        cur=mydb.cursor()
        cur.execute(sql)
        mydb.commit()
        data = cur.fetchall()
        print(data)
        
        if len(data) > 0:
            session['stuemail'] = email
            print(session['stuemail'])
            return render_template('studenthome.html', msg="Login successfull")
        else:
            return render_template('student.html', msg="Login failed")
    return render_template('student.html')


@app.route("/Viewtimetable")
def Viewtimetable():
    sql = "select * from students where email='%s'"%(session['stuemail'])
    cur=mydb.cursor()
    cur.execute(sql)
    data = cur.fetchall()
    mydb.commit()
    print(data)
    year = data[0][3]
    semester = data[0][4]
    # sql = "select * from time_table where year='%s' and semester='%s'"%(year,semester)
    # cur.execute(sql)
    # mydata =cur.fetchall() 
    df = pd.read_sql_query(f"select * from time_table where year='%s' and semester='%s'"%(year,semester), mydb)
   
    my_time_table = pd.DataFrame(
        columns=['Days', 'Period 1', 'Period 2', 'Period 3', 'Period 4', 'Period 5', 'Period 6', 'Period 7'],
        index=[*range(0, 5)])

    j = 0
    for day in calendar.day_name[0:6]:
        day_wise_df = df.loc[df.day == day].sort_values('period')
        val = [day]
        for row in day_wise_df.iterrows():
            period = row[1]['period']
            for i in range(len(val), period):
                val.append('Free Period')
            val.append(row[1]['subject'])
        for i in range(len(val), 8):
            val.append('Free Period')
        my_time_table.loc[j] = val
        j = j + 1

    my_time_table.insert(5, 'Break', ['Lunch'] * 6)
    cols = my_time_table.columns.values
    rows = my_time_table.values.tolist()
    
    return render_template("Viewtimetable.html", cols=cols, rows=rows, login=session['loggedin'], isadmin=session['isadmin'])

@app.route('/register', methods=['POST', 'GET'])
def register():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        conf_password = request.form['conf_password']
        if email=="admin@timetable.com":
            flash(r'Reserved Email ID. Please try another one','warning')
            return render_template('register.html')
        if password==conf_password:
            register = pd.read_sql_query('select * from register', mydb)
            all_faculties=register['email'].values #already registered emails
            if email in all_faculties:
                flash(r"Email already exists.", "danger")
                return render_template('register.html')
            sub1 = request.form['sub1'] if request.form['sub1'] else "pending"
            sub2 = request.form['sub2'] if request.form['sub2'] else "pending"
            sub3 = request.form['sub3'] if request.form['sub3'] else "pending"

            
            exp1=int(request.form['exp'].split('.')[0])
            sql="INSERT INTO REGISTER(name, email, password, subject1, subject2, subject3, experience) values (%s, %s, %s, %s, %s, %s, %s)"
            val=(name, email, password, sub1, sub2, sub3, exp1)
            cur=mydb.cursor()
            cur.execute(sql, val)
            mydb.commit()
            flash(r"Registration Successful", "success")
        else:
            flash(r"Password does not match. Please try again!","info")
    return render_template('register.html', login=session['loggedin'], isadmin=session['isadmin'])

@app.route('/view_faculties')
def view_faculties():
    register = pd.read_sql_query('select * from register', mydb)
    register.drop(['password'], axis=1, inplace=True)
    cols=register.columns.values
    return render_template('view_faculties.html', cols=[col.capitalize() for col in cols], rows=register.values.tolist(), login=session['loggedin'], isadmin=session['isadmin'])

@app.route('/add_subjects', methods=['GET','POST'])
def add_subjects():
    if request.method=='POST':
        year=int(request.form['year'])
        sem=int(request.form['semester'])
        sub=request.form['subject']
        sql="INSERT INTO class_subz(Year, Semester, Subject) values (%s, %s, %s)"
        val=(year, sem, sub)
        cur=mydb.cursor()
        cur.execute(sql, val)
        mydb.commit()
        cur.close()
        # r=all_teachers()
    register = pd.read_sql_query('select subject1, subject2,subject3 from register', mydb)
    all_subjects=list(set(register.subject1.tolist()+register.subject2.tolist()+register.subject3.tolist()))
    all_subjects.sort()
    return render_template('add_subjects.html', subz=all_subjects, login=session['loggedin'], isadmin=session['isadmin'])

@app.route('/add_labs', methods=['GET','POST'])
def add_labs():
    if request.method=='POST':
        year=int(request.form['year'])
        sem=int(request.form['semester'])
        lab=request.form['lab']
        sql="INSERT INTO class_lab(Year, Semester, Lab) values (%s, %s, %s)"
        val=(year, sem, lab)
        cur=mydb.cursor()
        cur.execute(sql, val)
        mydb.commit()
        cur.close()
    register = pd.read_sql_query('select subject1, subject2,subject3 from register', mydb)
    all_subjects=list(set(register.subject1.tolist()+register.subject2.tolist()+register.subject3.tolist()))
    all_subjects.sort()
    return render_template('add_labs.html', subz=all_subjects, login=session['loggedin'], isadmin=session['isadmin'])

@app.route('/manage_subjects', methods=['POST','GET'])
def manage_subjects():
    if request.method=='POST':
        year=int(request.form['year'])
        sem=int(request.form['semester'])
        sql="SELECT * FROM class_subz WHERE Year='%s' AND Semester='%s'" %(year, sem)
        class_subjects = pd.read_sql_query(sql, mydb)
        class_subjects.drop(['SN'], axis=1, inplace=True)
        return render_template('manage_subjects.html', cols=class_subjects.columns.values, rows=class_subjects.values.tolist(), login=session['loggedin'], isadmin=session['isadmin'])
    return render_template('manage_subjects.html', login=session['loggedin'], isadmin=session['isadmin'])

@app.route('/edit/<year>/<sem>/<sub>')
def edit(year, sem, sub):
    session['year']=year
    session['sem']=sem
    session['sub']=sub
    # sql = "SELECT * FROM class_subz WHERE Year='%s' AND Semester='%s'" % (year, sem)
    sql='select subject1, subject2 from register'
    register = pd.read_sql_query(sql, mydb)
    all_subjects=list(set(register.subject1.tolist()+register.subject2.tolist()))
    all_subjects.sort()
    return render_template('edit_subjects.html', year=year, sem=sem, subz=all_subjects, sub=sub, login=session['loggedin'], isadmin=session['isadmin'])

@app.route('/update_subjects', methods=['GET','POST'])
def update_subjects():
    if request.method=='POST':
        year=session['year']
        sem=session['sem']
        sub=request.form['subject']
        sql = "UPDATE class_subz SET Subject=%s WHERE Year=%s AND Semester=%s AND Subject=%s "
        val=(sub, year, sem, session['sub'])
        cur = mydb.cursor()
        cur.execute(sql, val)
        mydb.commit()
        # r=all_teachers()
        session.pop('year', None)
        session.pop('sem', None)
        session.pop('sub', None)
    return redirect(url_for('manage_subjects'))

@app.route('/delete/<year>/<sem>/<sub>')
def delete(year, sem, sub):
    sql = "DELETE FROM class_subz WHERE Year=%s AND Semester=%s AND Subject='%s' " % (year, sem, sub)
    cur=mydb.cursor()
    cur.execute(sql)
    mydb.commit()
    cur.close()
    # r = all_teachers()
    return redirect(url_for('manage_subjects'))


@app.route('/generate_time_table', methods=['POST','GET'])
def generate_time_table():
    if request.method=='POST':
        teacher=request.form['teacher']
        sql = "select email from register where name='%s'"%(teacher)
        cur = mydb.cursor()
        cur.execute(sql)
        facultydetails = cur.fetchall()
        mydb.commit()
        facultyemail = facultydetails[0][0]
        print(facultyemail)
        
        df=pd.read_sql_query(f"select * from time_table", mydb)
        
        df=df.loc[df.faculty==teacher]
        my_time_table=pd.DataFrame(columns=['Days','Period 1','Period 2','Period 3','Period 4','Period 5','Period 6','Period 7'], index=[*range(0,5)])
        j=0
        for day in calendar.day_name[0:6]:
            day_wise_df=df.loc[df.day==day].sort_values('period')
            val = [day]
            for row in day_wise_df.iterrows():
                period=row[1]['period']
                for i in range(len(val),period):
                    val.append('Free Period')
                val.append(row[1]['subject']+' /// '+'Year='+str(row[1]['year'])+' & Semester='+str(row[1]['semester']))
            for i in range(len(val),8):
                val.append('Free Period')
            my_time_table.loc[j]=val
            j=j+1

        my_time_table.insert(6,'Break',['Lunch']*6)
        cols=my_time_table.columns.values
        rows=my_time_table.values.tolist()
        
        register = pd.read_sql_query('select * from register', mydb)
        all_teachers_list = list(set(register.name.tolist()))
        all_teachers_list.sort()
        sql = "select distinct email from register"
        cur = mydb.cursor()
        cur.execute(sql)
        facultyemails = cur.fetchall()
        mydb.commit()
        facultyemails = [j for i in facultyemails for j in i]
        print(facultyemails)
        for email in facultyemails:
            print(email)
            
            timetable_html = my_time_table.to_html()
            # Generate PDF
            pdfkit.from_string(timetable_html, f'{email}.pdf', configuration=pdfkit.configuration(wkhtmltopdf='C:/Program Files/wkhtmltopdf/bin/wkhtmltopdf.exe'))
        
            try:
                return send_from_directory(directory=os.getcwd(), filename='timetable.pdf', as_attachment=True)
            except:
                pass
                        
            receiver = email
            msg = Message('Timetable', sender='mail@example.com', recipients=[receiver])
            msg.body = 'Your timetable is attached.'
        
            # Attach the PDF file
            with app.open_resource(f'{email}.pdf') as pdf:
                msg.attach(f'{email}.pdf', 'application/pdf', pdf.read())
        
            # Send the message
            mail.send(msg)
        
        return render_template('time_table.html',teachers=all_teachers_list, cols=cols, rows=rows, login=session['loggedin'], isadmin=session['isadmin'])
    #generate and store time table
    reg_sub = all_teachers()
    reg_lab = all_teachers_labs()
    time_table(reg_sub, reg_lab)

    register=pd.read_sql_query('select * from register', mydb)
    all_teachers_list=list(set(register.name.tolist()))
    all_teachers_list.sort()
    
    
    
    return render_template('time_table.html',teachers=all_teachers_list, login=session['loggedin'], isadmin=session['isadmin'])

@app.route('/view_profile')
def view_profile():
    sql="SELECT * FROM register WHERE email='%s' "%(session['email'])
    cur=mydb.cursor()
    cur.execute(sql)
    data=cur.fetchall()
    mydb.commit()
    cur.close()
    print(data)
    return render_template('view_profile.html',data=data[0], login=session['loggedin'], isadmin=session['isadmin'])

@app.route('/view_time_table')
def view_time_table():
    teacher = session['name']
    df = pd.read_sql_query(f"select * from time_table", mydb)
    df = df.loc[df.faculty == teacher]
    my_time_table = pd.DataFrame(
        columns=['Days', 'Period 1', 'Period 2', 'Period 3', 'Period 4', 'Period 5', 'Period 6', 'Period 7'],
        index=[*range(0, 5)])

    j = 0
    for day in calendar.day_name[0:5]:
        day_wise_df = df.loc[df.day == day].sort_values('period')
        val = [day]
        for row in day_wise_df.iterrows():
            period = row[1]['period']
            for i in range(len(val), period):
                val.append('Free Period')
            val.append(
                row[1]['subject'] + ' /// ' + 'Year=' + str(row[1]['year']) + ' & Semester=' + str(row[1]['semester']))
        for i in range(len(val), 8):
            val.append('Free Period')
        my_time_table.loc[j] = val
        j = j + 1

    my_time_table.insert(5, 'Break', ['Lunch'] * 5)
    cols = my_time_table.columns.values
    rows = my_time_table.values.tolist()

    return render_template('time_table.html', cols=cols, rows=rows, login=session['loggedin'], isadmin=session['isadmin'])


@app.route('/logout')
def logout():
    session.pop('loggedin',None)
    session.pop('isadmin',None)
    session.pop('name',None)
    session.pop('email',None)
    session['loggedin']=False
    session['isadmin']=False
    return redirect(url_for('home'))



# @app.route('/generate_time_table')
# def generate_time_table():
#     all_facz=all_teachers()
#     #Assigning faculty to classes
#     all_facz['assigned']=True
#     i='1' #year
#     j='1' #semester
#     my_class=all_facz.query("(year==@i) and (semester==@j)")
#     repeat_faculties=my_class.subject.value_counts()
#     if (repeat_faculties>1).any():
#         repeat_faculties=repeat_faculties.to_dict()
#         for k,v in repeat_faculties.items():
#             if v>1:
#                 the_commons=my_class.loc[my_class.subject==k].sort_values(by='experience', ascending=False)
#                 #Remove the ones who are already assigned to earlier classes
#                 for per in the_commons.iterrows():
#                     for p in range(0,i+1): #previous years
#                         for q in range(0,j): #previous semesters
#                             all_class_vals=pd.read_sql_query(f'select * from all_teachers where year={p} and semester={q}',mydb)
#                             if per[1]['name'] in all_class_vals.name & all_class_vals.loc[all_class_vals.name==per[1]['name'],:]['assign']=='False':
#
#
#                 assigned_person=the_commons.iloc[0,:] #Highly experienced
#             else:
#                 assigned_person=my_class.loc[my_class==k].values
#             sql="UPDATE all_teachers SET assign=%s WHERE name=%s AND year=%s AND semester=%s"
#             val=('True',assigned_person[0],assigned_person[4], assigned_person[5])
#             cur=mydb.cursor()
#             cur.execute(sql,val)
#             mydb.commit()
#             cur.close()
#
#
#
#     for row in my_class.iterrows():
#         if row


if __name__=='__main__':
    app.run(debug=True)

# for per in the_commons.iterrows():
#     print(per[1])
#     break

# from sqlalchemy import create_engine
# engine=create_engine("mysql+pymysql://root:root@localhost/teacher_time_table")
#
# reg3.to_sql('all_teachers', en
# gine, if_exists='replace', index=False)