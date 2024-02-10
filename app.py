from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required

# Configure application
app = Flask(__name__)

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///swift.db")

@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response

@app.route("/", methods=["GET", "POST"])
@login_required
def index():
    """Show user applications"""
    user_id = session["user_id"]
    if request.method == "POST":
        # Add application
        company = request.form.get("company")
        position = request.form.get("position")
        ctc = request.form.get("ctc")
        last_updated = request.form.get("last_updated")

        if not (company or position or ctc):
            return apology("must provide al fields", 400)

        db.execute("INSERT INTO applications (user, company, position, ctc, status, last_updated) VALUES(?,?,?,?,?,?)",
                   user_id, company, position, ctc, "Applied", (last_updated,))

        flash("Successfully added application!")
        return redirect("/")

    else:
        # get applications
        rows = db.execute(
            "SELECT id, company, position, ctc, status, last_updated from applications WHERE user = :user_id", user_id=user_id)
        return render_template("index.html", rows=rows)


@app.route('/row/<int:row_id>', methods=['DELETE', 'PUT', 'GET'])
@login_required
def update_row(row_id):
    if request.method == 'PUT':
        data = request.get_json()
        status = data['status']

        db.execute('UPDATE applications SET status = ? WHERE id = ?', status, row_id)
        return 'Success'

    elif request.method == 'GET':
        row = db.execute("SELECT * FROM applications WHERE id = ?", row_id)
        return row[0]

    else:
        db.execute("DELETE FROM applications WHERE id = ?", row_id)
        return 'Success'


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""
    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 400)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 400)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))
        if len(rows) != 0:
            return apology("user already exists!", 400)

        if request.form.get("password") != request.form.get("confirmation"):
            return apology("Passwords do not match!", 400)

        hash = generate_password_hash(request.form.get("password"))
        db.execute("INSERT INTO users (username, hash) VALUES (?, ?)", request.form.get("username"), hash)

        return redirect("/login")
    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("register.html")

