from website import create_app
#from gevent.pywsgi import WSGIServer

app = create_app()

# http_server = WSGIServer(('', 8000), app)
# http_server.serve_forever()
if __name__ == "__main__":
    app.run(debug=True)