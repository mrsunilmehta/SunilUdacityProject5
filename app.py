import logging
from flask import Flask           # import flask
from flask.logging import create_logger


app = Flask(__name__)             # create an app instance

LOG = create_logger(app)
LOG.setLevel(logging.INFO)

@app.route("/")                   # at the end point /
def hello():  
    LOG.info("Inside hello function " )                     # call method hello
    return "Sunil Mehta, this is your 5th project"         # which returns "Sunil Mehta, this is your 5th project"
if __name__ == "__main__":        # on running python app.py
    app.run()                    # run the flask app
