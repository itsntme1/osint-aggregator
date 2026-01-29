
from flask import Flask, render_template, request, redirect, session
import subprocess, json, time
from functions import *
from secret_keys import *

app = Flask(__name__)
app.secret_key = session_key

@app.route("/", methods = ["GET", "POST"])
def landing():

    if request.method == "POST":
        session['emails'] = request.form.get("emails").split(' ')
        session['usernames'] = request.form.get("usernames").split(' ')

        return redirect("/search")

    return render_template("landing.html")

@app.route("/search")
def search():
#    ip_info = f.query_ip_info(request.remote_addr)

    return render_template("search.html")

@app.route("/api/ip_info")
def ip_info():
    # data = query_ip_info(request.remote_addr, ip_info_key)
    data = query_ip_info("90.177.145.18", ip_info_key)

    session['coordinates'] = data['loc'].split(',')

    return data

@app.route("/api/mapy_cz")
def mapy_cz():
    data_ip = query_ip_info("90.177.145.18", ip_info_key)

    session['coordinates'] = data_ip['loc'].split(',')

    data = {
        'longtitude': session['coordinates'][1],
        'latitude': session['coordinates'][0],
        'token': mapy_cz_key
    }

    return data

@app.route("/api/http_headers")
def http_headers():
    # Format data
    data = {
        'user_agent': request.headers.get('User-Agent'),
        'os': request.headers.get('Sec-Ch-Ua-Platform')[1:-1],
        'language': request.headers.get('Accept-Language')[:2]
    }

    return data

@app.route("/api/disify")
def email():
    data = {}

    for email in session['emails']:
        data_disify = query_disify(email)

        data[email] = {
            'domain': data_disify['domain'],
            'valid': data_disify['format'],
            'disposable': data_disify['disposable']
        }

    return data

@app.route("/api/maigret")
def maigret():
    maigret_data = {}
    data = {}

    for username in session['usernames']:
        data[username] = {}

        try:
            maigret_data = load_report(username)
        except:
            run_maigret(username)
            maigret_data = load_report(username)

        for site in maigret_data:
            data[username][site] = {
                'site': site,
                'url': maigret_data[site]['url_user']
            }

    return data

@app.route("/api/xposedornot")
def xposedornot():
    data = {}

    for email in session['emails']:
        xposedornot_data = query_xposedornot(email)

        data[email] = xposedornot_data

        time.sleep(1)

    return data

if __name__ == "__main__":
    app.run(debug=True)