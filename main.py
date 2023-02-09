from sqlite3.dbapi2 import Date
from flask import Flask, redirect, request, render_template, make_response, url_for, jsonify
import sqlite3
from datetime import date, datetime  # datetime for recording usersubmissions
# secure filename function for image uploads
from werkzeug.utils import secure_filename
from werkzeug.datastructures import ImmutableMultiDict
import os

UPLOAD_FOLDER = '/static/img'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}


app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'static/img/')

directory = {}

DATABASE = 'database.db'


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/home')
@app.route('/', methods=['GET'])
def homepage():
    if request.method == 'GET':
        return render_template("home.html")


@app.route('/tour', methods=['GET'])
def returnTour():
    if request.method == 'GET':
        connection = sqlite3.connect(DATABASE)
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM approved;")
        data = cursor.fetchall()
        return render_template("tour.html", data=data)


@app.route('/search', methods=['GET'])
def search():
    if request.method == 'GET':
        search = "%" + request.args.get("search") + "%"
        connection = sqlite3.connect(DATABASE)
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM approved WHERE name LIKE ?", [search])
        data = cursor.fetchall()
        for i in data:
            print(i[1])
        return render_template("search.html", data=data)


@app.route('/contact', methods=['GET'])
def contactUs():
    if request.method == 'GET':
        return render_template("contact.html")

# Code adapted from CM6112 topic 7 example


@app.route('/login', methods=['GET', 'POST'])
def loginPage():
    if request.method == 'GET':
        return render_template("login.html")
    elif request.method == 'POST':
        uName = request.form.get('username', default="Error")
        pw = request.form.get('password', default="Error")
        if checkCredentials(uName, pw):
            return redirect(url_for('adminPage'))
        else:
            return render_template("login.html")


def checkCredentials(uName, pw):
    credentials = [["Richard", "Admin121"], ["admin", "admin"]]
    for cred in credentials:
        if uName == cred[0]:
            if pw == cred[1]:
                return(True)
            else:
                return(False)
    return(False)


@app.route("/contribution", methods=['GET', 'POST'])
def contribution():
    if request.method == 'GET':
        print("getting directory")
        return render_template('contribution.html')
    elif request.method == 'POST':
        try:
            date = datetime.today().strftime('%Y-%m-%d-%H:%M')
            connection = sqlite3.connect(DATABASE)
            cursor = connection.cursor()
            data = [(request.form['graveName'], request.form['graveInfo'],
                     request.form['graveLocation'], request.form['userName'], request.form['userEmail'], date)]
            connection.executemany("""INSERT INTO submitted
            ("graveName","graveInfo","graveLocation","userName","userEmail","dateSubmitted")
            VALUES (?,?,?,?,?,?)""", data)
            print("successfully submitted to db")
            connection.commit()
            code = 201
        except Exception as e:
            connection.rollback()
            code = 409
        finally:
            connection.close()
            return render_template('contribution.html'), code


@app.route('/admin', methods=['GET'])
def adminPage():
    if request.method == 'GET':
        connection = sqlite3.connect(DATABASE)
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM submitted;")
        data = cursor.fetchall()
        print(data)
        return render_template("admin.html", submitted=data)


@app.route('/admin/edit', methods=['GET'])
def editGrave():
    if request.method == 'GET':
        return render_template("approve.html")


# This api route (/submissions) is for all api calls relating to user submissions
@app.route("/api/submissions", methods=['DELETE', 'PUT', 'GET'])
def apiSubmission():
    if request.method == 'DELETE':  # delete grave function
        graveID = request.form["graveID"]
        print(graveID)
        connection = sqlite3.connect(DATABASE)
        cursor = connection.cursor()
        cursor.execute(
            "DELETE FROM submitted WHERE submitted.ID = " + graveID + ";")
        connection.commit()
        connection.close()
        connection = sqlite3.connect(DATABASE)
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM submitted;")
        data = cursor.fetchall()
        print(data)
        return render_template("admin.html", submitted=data)
    elif request.method == 'PUT':
        graveID = request.form["graveID"]
        print(graveID)
        return graveID
    elif request.method == 'POST':  # update grave function
        connection = sqlite3.connect(DATABASE)
        cursor = connection.cursor()
        cursor.executemany("""INSERT INTO approvedSubmitted (ID, graveName, graveInfo, graveLocation, userName, userEmail, dateSubmitted)
                              SELECT graveName, graveInfo, graveLocation, userName, userEmail, dateSubmitted
                              FROM submitted""")
        connection.commit()
        connection.close()
        return render_template("admin.html")
    elif request.method == 'GET':  # function to get a single submission
        id = request.args.get("id")
        connection = sqlite3.connect(DATABASE)
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM submitted WHERE submitted.ID = ?", id)
        data = cursor.fetchall()
        if data == []:
            return render_template("approve.html", title='404'), 404
        else:
            return jsonify(
                id=data[0][0],
                gravename=data[0][1],
                locationDescription=data[0][3],
                gravestory=data[0][2],
                username=data[0][4],
                useremail=data[0][5],
                date=data[0][6]
            )

# This api route (/approved) is for all api calls relating to APPROVED user submissions
@app.route("/api/approved", methods=['DELETE', 'PUT', 'GET', 'POST'])
def apiApproved():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'graveimage' not in request.files:
            print('No file part')
            return '''<h1>ERROR - No File Part</h1>'''
        f = request.files['graveimage']
        # If the user does not select a file, the browser submits an
        # empty file without a filename.
        if f.filename == '':
            imagePath = 'static/img/noImage.png' #no image found is set as image
        if f and allowed_file(f.filename): #succsesful upload
            filename = secure_filename(f.filename)
            print(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            imagePath = 'static/img/'+filename
        data = dict(request.form)
        graveName = data['graveName']
        graveStory = data['graveInfo']
        graveLat = data['gravelat']
        graveLong = data['gravelong']
        try:
            connection = sqlite3.connect(DATABASE)
            cursor = connection.cursor()
            data = graveName, graveLat, graveLong, graveStory, imagePath
            cursor.execute("""INSERT INTO "approved" ("name","lat","long","info","picPath") VALUES (?,?,?,?,?)""", data)
            print("successfully submitted to db")
            connection.commit()
            code = 201
        except Exception as e:
            connection.rollback()
            print("SQL error")
            code = 409
        finally:
            connection.close()
        return render_template("admin.html"), code


if __name__ == "__main__":
    try:    # following code is adapted from https://www.kite.com/python/answers/how-to-execute-an-external-sql-file-using-sqlite3-in-python
        connection = sqlite3.connect(DATABASE)
        cursor = connection.cursor()
        sql_file = open("graves.sql", encoding='utf-8')
        sql_as_string = sql_file.read()
        cursor.executescript(sql_as_string)
        connection.close()
        print("Succsessfully Initialised DB")
    except:
        print("Error- Couldn't Initialise SQLite DB")
        exit()

app.run(debug=True)
