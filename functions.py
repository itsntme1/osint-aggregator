import re, requests, subprocess

def format_search_input(search_input: str):
    input_items = search_input.strip().split(' ')
    
    search_items = {
        'usernames': [],
        'emails': []
    }

    for item in input_items:
        if re.search(r"\w+@\w+\.\w{2,}", item):
            search_items["emails"].append(item)

        else:
            search_items["usernames"].append(item)

    return search_items

def run_sherlock(usernames: list):
    #TODO make it asynchoronously run a process for each username
    #TODO stop it from creating files

    data = {}

    arguments = ["sherlock"]
    arguments.extend(["asd", "adasf"])

    sherlock_data = subprocess.check_output(arguments, text=True)

    # Match all lines starting with '[+]'
    lines = re.findall(r'\[\+\].+', sherlock_data)

    for line in lines:
        # Remove '[+] ' from the line
        line = line [4:]

        # Seperate a line into site and url
        site, url = line.split(": ")

        data[site] = url

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

def query_ip_info(ip, token: str):
    return query_api(f"https://ipinfo.io/{ip}", {"Authorization": f"Bearer {token}"}).json()

def query_disify(email: str):
    return query_api(f"https://disify.com/api/email/{email}").json()