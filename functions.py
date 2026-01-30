import re, requests, subprocess, asyncio, json

def format_input(input: string):
    if input != "":
        input = input.split(' ')

        return input

def query_api(endpoint: str, headers=None, timeout: int=1):
    response = None

    try:
        response = requests.get(endpoint, headers=headers, timeout=timeout)

        if response.status_code != 200:
            print(f"Status code: {response.status_code}")
            response = None

            return

    except Exception as error:
        print(f"query_api: {error}")
    
    return response

def query_ip_info(ip: str, token: str):
    return query_api(f"https://ipinfo.io/{ip}", {"Authorization": f"Bearer {token}"}).json()

def query_disify(email: str):
    return query_api(f"https://disify.com/api/email/{email}").json()

def query_xposedornot(email: str):
    return query_api(f"https://api.xposedornot.com/v1/check-email/{email}").json()

def query_genderize(name: str):
    return query_api(f"https://api.genderize.io?name={name}").json()

def query_agify(name: str):
    return query_api(f"https://api.agify.io?name={name}").json()

def query_nationalize(name: str):
    return query_api(f"https://api.nationalize.io?name={name}").json()

def run_maigret(username: str):
    arguments = ["maigret", "--no-recursion", "--json", "simple"]
    arguments.extend([username])

    subprocess.run(arguments)

def load_report(username: str):
    with open(f"reports/report_{username}_simple.json", "r") as file:
        data = json.load(file)

    return data
