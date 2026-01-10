import re

def format_search_input(search_input: str):
    input_items = search_input.strip().split(' ')
    
    # [[usernames], [emails]]
    search_items = [[],[]]

    for item in input_items:
        if re.search("\w+@\w+\.\w{2,}", item):
            search_items[1].append(item)

        else:
            search_items[0].append(item)

    return search_items
