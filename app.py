
# External modules
from flask import Flask, render_template, request, redirect, session, send_file
import typst, wget

# Built-in modules
import subprocess, json, time, math, os

# Internal modules
from functions import *
from secret_keys import *

app = Flask(__name__)
app.secret_key = session_key

@app.route("/", methods = ["GET", "POST"])
def landing():
    error = None

    if request.method == "POST":
        session['name'] = request.form.get("name")
        session['usernames'] = format_input(request.form.get("usernames"))
        session['emails'] = format_input(request.form.get("emails"))

        if session['name'] and session['usernames'] and session['emails']:
            return redirect("/search")
            
        error = "Missing input"

    return render_template("landing.html", error=error)

@app.route("/search")
def search():
    if not session['name'] or not session['usernames'] or not session['emails']:
        return redirect("/")

    return render_template("search.html")

@app.route("/api/ip_info")
def ip_info():
    # data = query_ip_info(request.remote_addr, ip_info_key)
    data = query_ip_info("90.177.145.18", ip_info_key)

    session['coordinates'] = data['loc'].split(',')
    session['ip_info'] = data

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

    session['http_headers'] = data

    return data

@app.route("/api/disify")
def email():
    data = {}

    for email in session['emails']:
        data_disify = query_disify(email)

        if not data_disify['format']:
            data[email] = {
                'domain': "none",
                'valid': False,
                'disposable': "unknown"
            }

            continue

        data[email] = {
            'domain': data_disify['domain'],
            'valid': data_disify['format'],
            'disposable': data_disify['disposable']
        }

    session['disify'] = data

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

    session['maigret'] = data

    return data

@app.route("/api/xposedornot")
def xposedornot():
    data = {}

    for email in session['emails']:
        xposedornot_data = query_xposedornot(email)

        data[email] = xposedornot_data

        time.sleep(1)

    session['xposedornot'] = data

    return data

@app.route("/api/name_info")
def name_info():
    gender_data = query_genderize(session['name'])
    age_data = query_agify(session['name'])
    country_data = query_nationalize(session['name'])

    data = {
        'name': session['name'],
        'gender': gender_data['gender'],
        'gender_probability': math.floor(gender_data['probability'] * 100),
        'age': age_data['age'],
        'country': country_data['country'][0]['country_id'],
        'country_probability': math.floor(country_data['country'][0]['probability'] * 100)
    }

    session['name_info'] = data

    return data

@app.route("/export")
def export():
    # Export session variables to json for typst to import
    export_to_json("name", session)
    export_to_json("usernames", session)
    export_to_json("emails", session)
    export_to_json("ip_info", session)
    export_to_json("coordinates", session)
    export_to_json("http_headers", session)
    export_to_json("disify", session)
    export_to_json("maigret", session)
    export_to_json("xposedornot", session)
    export_to_json("name_info", session)

    # Download the map
    # wget.download(
    #     url=f"https://api.mapy.com/v1/static/map?lon={session['coordinates'][1]}&lat={session['coordinates'][0]}&zoom=4&width=540&height=450&mapset=basic&markers=color:red;size:normal;{session['coordinates'][1]},{session['coordinates'][0]}&apikey={mapy_cz_key}",
    #     out="export/map.png"
    # )

    typst.compile("report.typ", output=f"{session['name']}_report.pdf")

    # Remove files
    os.remove("/export/*.json")

    return send_file(f"{session['name']}_report.pdf")

if __name__ == "__main__":
    app.run(debug=True)