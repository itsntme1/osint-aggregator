
#import sherlock
from flask import Flask, render_template, request, redirect, session
import functions as f
from secret_keys import session_key

app = Flask(__name__)
app.secret_key = session_key

@app.route("/", methods = ["GET", "POST"])
def landing():

    if request.method == "POST":
        session["search_items"] = f.format_search_input(request.form.get("search_input"))

        return redirect("/search")

    return render_template("landing.html")

@app.route("/search")
def search():
    search_items = session["search_items"]
    print(search_items)
    return render_template("search.html", search_items=search_items)



if __name__ == "__main__":
    app.run(debug=True)