from flask import Blueprint, request, jsonify, make_response
from src import db


advisors = Blueprint('advisors', __name__)

# Get all the products from the database
@advisors.route('/advisors/<int:advisorid>', methods=['GET'])
def get_id(advisorid):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('select FirstName, LastName, NUID from Advisor where NUID={id}'.format(id=advisorid))

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

@advisors.route('/advisors/<last_name>', methods=['GET'])
def get_name(last_name):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of advisors
    cursor.execute('select FirstName, LastName, NUID from Advisor where LastName="{last}"'.format(last=last_name))

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

# adding a class to a major plan
@advisors.route('/advisors/change_plan/', methods=['GET','POST'])
def change_plan():
        cursor = db.get_db().cursor()
        major_name = str(request.form['major'])
        sem_number = int(request.form['sem_number'])
        dep = str(request.form['dep'])
        course_num = int(request.form['course_number'])
        cursor.execute('INSERT INTO Plan(MajorName, SemesterNumber, CourseNumber, DepartmentName) VALUES ("{major_name}", "{sem_number}", "{course_num}", "{dep}")'.format(major_name=major_name,sem_number=sem_number,course_num=course_num,dep=dep))
        db.get_db().commit()
        return "Success"





