from flask import Flask, render_template

# Initialize the Flask application
app = Flask(__name__)

@app.route('/app')
def home():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=False)
