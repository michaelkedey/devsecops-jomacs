# from flask import Flask, render_template

# # Initialize the Flask application
# app = Flask(__name__)

# @app.route('/')
# def home():
#     return render_template('index.html')

# if __name__ == '__main__':
#     app.run(debug=False)


from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/app')  # Add the /app route to handle requests to /app
def app_page():
    return render_template('index.html')  # Or you can return a different template/content for /app

if __name__ == '__main__':
    app.run(debug=False)
