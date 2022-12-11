from flask import Blueprint, request, jsonify, make_response
import json
from src import db


classes = Blueprint('classes', __name__)

# get the top 5 rated classes from the database
@classes.route('/top5classes')
def get_best_class():
    cursor = db.get_db().cursor()
    query = '''
        SELECT CourseNumber,Department,CourseHours,Professor,Rating
        FROM Class
        GROUP BY Department, CourseNumber
        ORDER BY Rating DESC
        LIMIT 5;
    '''
    cursor.execute(query)
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


@classes.route('/get_classes/<dept_name>')
def get_all_class(dept_name):
    cursor = db.get_db().cursor()
    query = f'''
        SELECT CourseNumber,Department,CourseHours
        FROM Class
        GROUP BY Department, CourseNumber
        WHERE Department = '{dept_name}'
    '''
    cursor.execute(query)
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