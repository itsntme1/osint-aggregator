
# External modules
from flask import Flask, render_template, request, redirect, session, send_file
import typst, wget

# Built-in modules
import subprocess, json, time, math, os, random

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
        session['user_hash'] = hash(session['name'] + "".join(session['usernames']) + "".join(session['emails']))

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

    export_to_json(data['loc'].split(','), "coordinates", session, session['user_hash'])
    export_to_json(data, "ip_info", session, session['user_hash'])

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

    export_to_json(data, "http_headers", session, session['user_hash'])

    return data

@app.route("/api/disify")
def disify():
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

    export_to_json(data, "disify", session, session['user_hash'])

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

    export_to_json(data, "maigret", session, session['user_hash'])

    return data

@app.route("/api/xposedornot")
def xposedornot():
    data = {}

    for email in session['emails']:
        xposedornot_data = query_xposedornot(email)

        data[email] = xposedornot_data

        # This is here to avoid rate limits
        time.sleep(1)

    export_to_json(data, "xposedornot", session, session['user_hash'])

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

    export_to_json(data, "name_info", session, session['user_hash'])

    return data

@app.route("/export")
def export():
    # Download the map
    wget.download(
        url=f"https://api.mapy.com/v1/static/map?lon={session['coordinates'][1]}&lat={session['coordinates'][0]}&zoom=4&width=540&height=450&mapset=basic&markers=color:red;size:normal;{session['coordinates'][1]},{session['coordinates'][0]}&apikey={mapy_cz_key}",
        out=f"export/{session['user_hash']}_map.png"
    )

    # Load json data
    ip_info = load_from_json("ip_info", session, session['user_hash'])
    coordinates = load_from_json("coordinates", session, session['user_hash'])
    http_headers = load_from_json("http_headers", session, session['user_hash'])
    disify = load_from_json("disify", session, session['user_hash'])
    maigret = load_from_json("maigret", session, session['user_hash'])
    xposedornot = load_from_json("xposedornot", session, session['user_hash'])
    name_info = load_from_json("name_info", session, session['user_hash'])

    data = {
            'name': session['name'],
            'usernames': json.dumps(session['usernames']),
            'emails': json.dumps(session['emails']),
            'ip_info': json.dumps(ip_info),
            'coordinates': json.dumps(coordinates),
            'http_headers': json.dumps(http_headers),
            'disify': json.dumps(disify),
            'maigret': json.dumps(maigret),
            'xposedornot': json.dumps(xposedornot),
            'name_info': json.dumps(name_info)
        }
    typst.compile("report.typ",
        output=f"reports/{session['name']}_report.pdf",
        sys_inputs=data
    )

    # Remove files
    for file in os.listdir("export"):
        os.remove(f"export/{file}")

    return send_file(f"reports/{session['name']}_report.pdf", as_attachment=False)

if __name__ == "__main__":
    app.run(debug=True)