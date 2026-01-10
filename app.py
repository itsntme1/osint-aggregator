
#import sherlock
from flask import Flask, render_template, request, redirect

app = Flask(__name__)


@app.route("/", methods = ["GET", "POST"])
def landing():

    if request.method == "POST":
        return redirect("/search")

    return render_template("landing.html")

@app.route("/search")
def search():
    return render_template("search.html")



if __name__ == "__main__":
    app.run(debug=True)