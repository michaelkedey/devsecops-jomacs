# from flask import Flask, render_template

# app = Flask(__name__, static_url_path='/app/static')
# app.config['APPLICATION_ROOT'] = '/app'

# @app.route('/')
# def index():
#     return render_template('index.html')

# if __name__ == '__main__':
#     app.run(host='127.0.0.1', port=5000, debug=False)



from flask import Flask, render_template, request
import logging

app = Flask(__name__, static_url_path='/app/static')
app.config['APPLICATION_ROOT'] = '/app'

# Configure logging
logging.basicConfig(
    filename='logs/access.log',
    level=logging.INFO,
    format='%(asctime)s %(levelname)s: %(message)s [in %(pathname)s:%(lineno)d]'
)

@app.route('/')
def index():
    ip = request.remote_addr
    user_agent = request.headers.get('User-Agent')
    logging.info(f"Visitor IP: {ip}, User Agent: {user_agent}")
    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=False)
