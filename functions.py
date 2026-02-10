import re, requests, subprocess, asyncio, json

def format_input(input: string):
    if input != "":
        input = input.split(' ')

        return input

def query_api(endpoint: str, headers=None, timeout: int=5):
    try:
        response = requests.get(endpoint, headers=headers, timeout=timeout)

        if response.status_code != 200:
            print(f"Endpoint: {endpoint}")
            print(f"Headers: {headers}")
            print(f'Response: {response.text}')
            print(f"Status code: {response.status_code}")

    except Exception as error:
        print(f"query_api: {error}")
    try:
        return response.json()
    except:
        return response

def query_icanhazip():
    return query_api("https://icanhazip.com")

def query_ip_info(ip: str, token: str):
    return query_api(f"https://ipinfo.io/{ip}", {"Authorization": f"Bearer {token}"})

def query_disify(email: str):
    return query_api(f"https://disify.com/api/email/{email}")

def query_xposedornot(email: str):
    return query_api(f"https://api.xposedornot.com/v1/check-email/{email}")

def query_genderize(name: str):
    return query_api(f"https://api.genderize.io?name={name}")

def query_agify(name: str):
    return query_api(f"https://api.agify.io?name={name}")

def query_nationalize(name: str):
    return query_api(f"https://api.nationalize.io?name={name}")

def run_maigret(username: str):
    arguments = ["maigret", "--no-recursion", "--json", "simple"]
    arguments.extend([username])

    subprocess.run(arguments)

def load_report(username: str):
    with open(f"reports/report_{username}_simple.json", "r") as file:
        data = json.load(file)

    return data

def export_to_json(variable, name, session, user_hash):
    with open(f"export/{user_hash}_{name}.json", "w") as file:
        json.dump(variable, file)

def load_from_json(name, session, user_hash):
    with open(f"export/{user_hash}_{name}.json", "r") as file:
        return json.load(file)