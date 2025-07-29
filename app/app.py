from flask import Flask
from prometheus_client import Counter, generate_latest

#Create Flask app and generate metrics
app=Flask(__name__)
requests_counter = Counter('web_requests_total', 'Total number of requests')

@app.route("/")
def hello():
    requests_counter.inc()
    return "Hello World"

# Prometheus metrics endpoint
@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {'Content-Type': 'text/plain; charset=utf-8'}

if __name__ == "__main__":
    app.run(host="0.0.0.0",port=5050)