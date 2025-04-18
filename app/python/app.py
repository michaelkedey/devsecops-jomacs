# from flask import Flask

# # Initialize the Flask application
# app = Flask(__name__)

# @app.route('/')
# @app.route('/app')  # This line makes /app also map to the home() function
# def home():
#     return render_template('index.html')

# if __name__ == '__main__':
#     app.run(debug=False)

from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
