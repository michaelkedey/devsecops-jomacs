# from flask import Flask, render_template, request
# import logging

# app = Flask(__name__, static_url_path='/app/static')
# app.config['APPLICATION_ROOT'] = '/app'

# # Configure logging
# logging.basicConfig(
#     filename='logs/access.log',
#     level=logging.INFO,
#     format='%(asctime)s %(levelname)s: %(message)s [in %(pathname)s:%(lineno)d]'
# )

# @app.route('/')
# def index():
#     ip = request.remote_addr
#     user_agent = request.headers.get('User-Agent')
#     logging.info(f"Visitor IP: {ip}, User Agent: {user_agent}")
#     return render_template('index.html')

# if __name__ == '__main__':
#     app.run(host='127.0.0.1', port=5000, debug=False)


# from flask import Flask, render_template, request, jsonify
# import logging
# from pythonjsonlogger import jsonlogger
# import geoip2.database
# import os
# import sys
# import traceback

# app = Flask(__name__, static_url_path='/app/static')
# app.config['APPLICATION_ROOT'] = '/app'

# # Create logs directory if not exists
# os.makedirs('logs', exist_ok=True)

# # Access log handler (INFO level logs)
# access_log_handler = logging.FileHandler('logs/access.log')
# access_formatter = jsonlogger.JsonFormatter('%(asctime)s %(levelname)s %(message)s %(pathname)s %(lineno)d')
# access_log_handler.setFormatter(access_formatter)
# access_log_handler.setLevel(logging.INFO)

# # Error log handler (ERROR/CRITICAL level logs)
# error_log_handler = logging.FileHandler('logs/error.log')
# error_formatter = jsonlogger.JsonFormatter('%(asctime)s %(levelname)s %(message)s %(pathname)s %(lineno)d')
# error_log_handler.setFormatter(error_formatter)
# error_log_handler.setLevel(logging.ERROR)

# # Setting up logger
# logger = logging.getLogger()
# logger.setLevel(logging.INFO)
# logger.addHandler(access_log_handler)
# logger.addHandler(error_log_handler)

# # Load MaxMind DB
# GEOIP_DB_PATH = 'GeoLite2-City.mmdb'  # Update path if needed
# geo_reader = geoip2.database.Reader(GEOIP_DB_PATH)

# # Function to handle uncaught exceptions
# def handle_uncaught_exception(exc_type, exc_value, exc_traceback):
#     if issubclass(exc_type, KeyboardInterrupt):
#         sys.__excepthook__(exc_type, exc_value, exc_traceback)
#         return
#     logger.critical("Fatal Error", extra={
#         'event': 'uncaught_exception',
#         'error': str(exc_value),
#         'traceback': ''.join(traceback.format_tb(exc_traceback))
#     })

# sys.excepthook = handle_uncaught_exception

# # Handle any unhandled exceptions in Flask
# @app.errorhandler(Exception)
# def handle_exception(e):
#     # Log the exception in error log
#     logger.error("Unhandled Exception", extra={
#         'event': 'unhandled_exception',
#         'error': str(e),
#         'traceback': traceback.format_exc(),
#         'ip': request.headers.get('X-Forwarded-For', request.remote_addr),
#         'path': request.path,
#         'method': request.method,
#         'user_agent': request.headers.get('User-Agent')
#     })
#     # Optionally, return a 500 error response to client
#     return jsonify(error="Internal Server Error"), 500

# @app.route('/')
# def index():
#     ip = request.headers.get('X-Forwarded-For', request.remote_addr)
#     user_agent = request.headers.get('User-Agent')

#     # Get geo info
#     try:
#         geo_info = geo_reader.city(ip)
#         city = geo_info.city.name
#         country = geo_info.country.name
#     except Exception as e:
#         city = 'Unknown'
#         country = 'Unknown'
#         logger.error("GeoIP lookup failed", extra={
#             'event': 'geoip_error',
#             'ip': ip,
#             'error': str(e)
#         })

#     # Log page visit information to access log
#     logger.info("page_visit", extra={
#         'event': 'page_visit',
#         'ip': ip,
#         'city': city,
#         'country': country,
#         'user_agent': user_agent,
#         'path': request.path
#     })

#     return render_template('index.html')

# if __name__ == '__main__':
#     app.run(host='127.0.0.1', port=5000, debug=False)


# from flask import Flask, render_template, request, jsonify
# import logging
# from pythonjsonlogger import jsonlogger
# import geoip2.database
# import os
# import sys
# import traceback

# app = Flask(__name__, static_url_path='/app/static')
# app.config['APPLICATION_ROOT'] = '/app'

# # Create logs directory if not exists
# os.makedirs('logs', exist_ok=True)

# # Access log handler (INFO level logs)
# access_log_handler = logging.FileHandler('logs/access.log')
# access_formatter = jsonlogger.JsonFormatter('%(asctime)s %(levelname)s %(message)s %(pathname)s %(lineno)d')
# access_log_handler.setFormatter(access_formatter)
# access_log_handler.setLevel(logging.INFO)

# # Error log handler (ERROR/CRITICAL level logs)
# error_log_handler = logging.FileHandler('logs/error.log')
# error_formatter = jsonlogger.JsonFormatter('%(asctime)s %(levelname)s %(message)s %(pathname)s %(lineno)d')
# error_log_handler.setFormatter(error_formatter)
# error_log_handler.setLevel(logging.ERROR)

# # Setting up logger
# logger = logging.getLogger()
# logger.setLevel(logging.INFO)
# logger.addHandler(access_log_handler)
# logger.addHandler(error_log_handler)

# # Load MaxMind DB
# GEOIP_DB_PATH = 'GeoLite2-City.mmdb'  # Update path if needed
# geo_reader = geoip2.database.Reader(GEOIP_DB_PATH)

# # Function to handle uncaught exceptions
# def handle_uncaught_exception(exc_type, exc_value, exc_traceback):
#     if issubclass(exc_type, KeyboardInterrupt):
#         sys.__excepthook__(exc_type, exc_value, exc_traceback)
#         return
#     logger.critical("Fatal Error", extra={
#         'event': 'uncaught_exception',
#         'error': str(exc_value),
#         'traceback': ''.join(traceback.format_tb(exc_traceback))
#     })

# sys.excepthook = handle_uncaught_exception

# # Handle any unhandled exceptions in Flask
# @app.errorhandler(Exception)
# def handle_exception(e):
#     # Log the exception in error log
#     logger.error("Unhandled Exception", extra={
#         'event': 'unhandled_exception',
#         'error': str(e),
#         'traceback': traceback.format_exc(),
#         'ip': request.headers.get('X-Forwarded-For', request.remote_addr),
#         'path': request.path,
#         'method': request.method,
#         'user_agent': request.headers.get('User-Agent')
#     })
#     # Optionally, return a 500 error response to client
#     return jsonify(error="Internal Server Error"), 500

# @app.route('/')
# def index():
#     # First check the X-Forwarded-For header, if available
#     ip = request.headers.get('X-Forwarded-For')
    
#     # Fallback to remote_addr if X-Forwarded-For is not set
#     if ip is None:
#         ip = request.remote_addr
    
#     # Handling cases where multiple IPs are included in X-Forwarded-For
#     ip_list = ip.split(',')
#     city, country = "Unknown", "Unknown"
    
#     # Skip GeoIP lookup if the IP is 127.0.0.1 (localhost)
#     if ip_list[0].strip() == '127.0.0.1':
#         city, country = 'Localhost', 'Localhost'
#     else:
#         # Try GeoIP lookup for each IP (use the first valid one)
#         for ip in ip_list:
#             ip = ip.strip()  # Remove any extra spaces
#             if ip:
#                 try:
#                     geo_info = geo_reader.city(ip)
#                     city = geo_info.city.name
#                     country = geo_info.country.name
#                     break  # Exit once a valid city is found
#                 except Exception as e:
#                     logger.error("GeoIP lookup failed", extra={
#                         'event': 'geoip_error',
#                         'ip': ip,
#                         'error': str(e)
#                     })

#     # Log page visit information to access log
#     logger.info("page_visit", extra={
#         'event': 'page_visit',
#         'ip': ip,
#         'city': city,
#         'country': country,
#         'user_agent': request.headers.get('User-Agent'),
#         'path': request.path
#     })

#     return render_template('index.html')





from flask import Flask, render_template, request, jsonify
import logging
from pythonjsonlogger import jsonlogger
import geoip2.database
import os
import sys
import traceback
from ipaddress import ip_address, IPv4Address, IPv6Address

app = Flask(__name__, static_url_path='/app/static')
app.config['APPLICATION_ROOT'] = '/app'

# Create logs directory if not exists
os.makedirs('logs', exist_ok=True)

# Configure logging handlers
access_log_handler = logging.FileHandler('logs/access.log')
error_log_handler = logging.FileHandler('logs/error.log')

# JSON formatters
json_formatter = jsonlogger.JsonFormatter(
    '%(asctime)s %(levelname)s %(message)s %(pathname)s %(lineno)d'
)
access_log_handler.setFormatter(json_formatter)
error_log_handler.setFormatter(json_formatter)

# Log levels
access_log_handler.setLevel(logging.INFO)
error_log_handler.setLevel(logging.ERROR)

# Root logger configuration
logger = logging.getLogger()
logger.setLevel(logging.INFO)
logger.addHandler(access_log_handler)
logger.addHandler(error_log_handler)

# GeoIP configuration
GEOIP_DB_PATH = 'GeoLite2-City.mmdb'
try:
    geo_reader = geoip2.database.Reader(GEOIP_DB_PATH)
except Exception as e:
    logger.critical("Failed to initialize GeoIP database", extra={
        'event': 'geoip_init_failure',
        'error': str(e)
    })
    raise

def is_valid_ip(ip_str):
    """Validate IPv4/IPv6 address format"""
    try:
        ip_address(ip_str.strip())
        return True
    except ValueError:
        return False

# Global exception handling
def handle_uncaught_exception(exc_type, exc_value, exc_traceback):
    if issubclass(exc_type, KeyboardInterrupt):
        sys.__excepthook__(exc_type, exc_value, exc_traceback)
        return
    logger.critical("Fatal Error", extra={
        'event': 'uncaught_exception',
        'error': str(exc_value),
        'traceback': ''.join(traceback.format_tb(exc_traceback))
    })

sys.excepthook = handle_uncaught_exception

@app.errorhandler(Exception)
def handle_exception(e):
    logger.error("Unhandled Exception", extra={
        'event': 'unhandled_exception',
        'error': str(e),
        'traceback': traceback.format_exc(),
        'ip': request.headers.get('X-Forwarded-For', request.remote_addr),
        'path': request.path,
        'method': request.method,
        'user_agent': request.headers.get('User-Agent')
    })
    return jsonify(error="Internal Server Error"), 500

@app.route('/')
def index():
    ip_header = request.headers.get('X-Forwarded-For', '')
    client_ip = request.remote_addr
    
    # Process IP candidates
    ip_candidates = [ip.strip() for ip in ip_header.split(',')] if ip_header else []
    ip_candidates.append(client_ip)  # Add fallback remote_addr
    
    city, country = "Unknown", "Unknown"
    valid_ip_found = False
    
    for ip_candidate in ip_candidates:
        if not ip_candidate or not is_valid_ip(ip_candidate):
            logger.warning("Invalid IP format", extra={
                'event': 'invalid_ip',
                'ip': ip_candidate
            })
            continue
        
        if ip_candidate == '127.0.0.1':
            city, country = 'Localhost', 'Localhost'
            valid_ip_found = True
            break
        
        try:
            geo_info = geo_reader.city(ip_candidate)
            city = geo_info.city.name or "Unknown"
            country = geo_info.country.name or "Unknown"
            valid_ip_found = True
            break
        except Exception as e:
            logger.error("GeoIP lookup failed", extra={
                'event': 'geoip_error',
                'ip': ip_candidate,
                'error': str(e)
            })
    
    # Log access with original IP information
    logger.info("page_visit", extra={
        'event': 'page_visit',
        'ip': ip_header or client_ip,
        'resolved_city': city,
        'resolved_country': country,
        'user_agent': request.headers.get('User-Agent'),
        'path': request.path
    })
    
    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=False)



