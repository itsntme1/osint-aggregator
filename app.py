
from flask import Flask, render_template, request, redirect, session
from functions import *
from secret_keys import *

app = Flask(__name__)
app.secret_key = session_key

@app.route("/", methods = ["GET", "POST"])
def landing():

    if request.method == "POST":
        session['search_items'] = format_search_input(request.form.get("search_input"))

        return redirect("/search")

    return render_template("landing.html")

@app.route("/search")
def search():
#    ip_info = f.query_ip_info(request.remote_addr)

    return render_template("search.html", search_items=session["search_items"])

@app.route("/api/ip_info")
def ip_info():
    # data = query_ip_info(request.remote_addr, ip_info_key)
    data = query_ip_info("90.177.145.18", ip_info_key)

    session['coordinates'] = data['loc'].split(',')

    return data

@app.route("/api/mapy_cz")
def mapy_cz():

    if not session['coordinates']:
        data = query_ip_info("90.177.145.18", ip_info_key)

        session['coordinates'] = data['loc'].split(',')

    data = {
        'longtitude': session['coordinates'][1],
        'latitude': session['coordinates'][0],
        'token': mapy_cz_key
    }

    print(data)

    return data


if __name__ == "__main__":
    app.run(debug=True)