from flask import Blueprint, request, jsonify, make_response
import json
from src import db


students = Blueprint('students', __name__)

# Get all the products from the database
@students.route('/students', methods=['GET'])
def get_students():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('select FirstName, LastName, NUID, MajorName from Student')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@students.route("/students/<major>",methods=['GET'])
def get_by_major(major):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of students
    cursor.execute('select * from Student where MajorName = "{maj}"'.format(maj=major))


    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


#@students.route('/students/get_majors',methods=['GET'])
#def get_majors():


@students.route('/students/<int:advisorID>', methods=['GET'])
def get_advisor_students(advisorID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Student where AdvisorID = {id}'.format(id=advisorID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


@students.route('/students/get_plan/<major>', methods=['GET'])
def get_plan(major):
    cursor = db.get_db().cursor()
    cursor.execute('select Department, CourseNumber, CourseHours, Professor, Rating, PrerequisiteCourseNumber, PrerequisiteDepartment from (select * from Plan p where p.MajorName = "{input_major}") sub NATURAL JOIN Class c'.format(input_major=major))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response



@students.route('/students/add_minor/',methods=['GET','POST'])
def add_minor():
    cursor = db.get_db().cursor()
    minor = request.form['minor']
    student_id = request.form['student_id']
    cursor.execute(
        f''' 
            UPDATE Students
            SET
                Minor = '{minor}'
            WHERE
                NUID = '{student_id}'
         ''')
    db.get_db().commit()
    return "Success"
