import re, requests

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