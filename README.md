# JOB APPLICATION TRACKER
#### Video Demo:  https://www.youtube.com/watch?v=ez8O_8ErR-Y
#### Description:
This is a helpful tool for keeping track of your job applications. It lets you put all your applications in one spot and easily update or remove them using a user-friendly interface. The front part of the tool is made with HTML, CSS, and JavaScript, while the backend uses Flask to handle requests. The backend of the application is created using Python and flask with SQLite as the data layer. It also uses session to manage the user details and has authentication layer for extra protection, making it good for personal use.

The `app.py` contains the main applications code for handeling the requests to perform CRUD (Create, Read, Update, Delete) operations on the applications using a SQLite database. This file contains several routes including:

- The `/` route handles the homepage. If a user is logged in, it retrieves their job applications from the database and displays them on the index page. If a POST request is made, it adds a new application to the database.
- The `/row/int:row_id` route is used for updating and deleting individual job applications. If a PUT request is made, it updates the status of the specified application. If a GET request is made, it retrieves the application data. If a DELETE request is made, it removes the application from the database.
- The `/login` route handles user login. If a user submits a username and password, it checks the database for a matching user and password hash. If successful, the user is logged in.
- The `/logout` route logs the user out by clearing the session data.
- The `/register` route handles user registration. It checks if the submitted username already exists, ensures the password is entered correctly, and then stores the user's information in the database.

The frontend code represents a web page template written in HTML. It is used to create a job application tracker application. The template consists of different sections, marked by tags such as `{% block %}`, `{% extends %}`, and `{% endblock %}`. These tags help define and organize the content of the page.

The template includes a form where users can enter information about a job application, such as the company, position, salary, and date. When the form is submitted, it sends the entered data to the server for processing.

Below the form, there is a table that displays a list of job applications. Each row of the table represents an application entry and shows details like the company, position, salary, date, and application status. Users can update the status of an application by selecting an option from a dropdown menu or delete an application by clicking on a delete button.

The template also includes some JavaScript code that handles the functionality of deleting applications and updating their status. It uses the Fetch API to send requests to the server and perform the corresponding actions.

Finally, there are a few other HTML files included in the code (`layout.html`, `login.html`, `register.html`) that define the layout and content of different pages of the application, such as the login and registration pages.

Technologies use: Flask, HTML, CSS, JavaScript, SQLite3