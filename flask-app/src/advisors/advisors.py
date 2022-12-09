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

    # use cursor to query the database for a list of products
    cursor.execute('select FirstName, LastName, NUID from Advisor where LastName={last}'.format(last=last_name))

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
