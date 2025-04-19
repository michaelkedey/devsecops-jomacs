# from flask import Flask, render_template

# app = Flask(__name__)

# @app.route('/')
# def index():
#     return render_template('index.html')

# if __name__ == '__main__':
#     app.run(debug=False)

from flask import Flask, render_template

app = Flask(__name__)

# Handle ALB's path prefix
@app.route('/')
@app.route('/app/')
@app.route('/app/index')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=False)

