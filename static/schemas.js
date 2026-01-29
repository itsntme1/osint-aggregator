
export const schemaTable = {
    'load': load,
    'error': error,
    'ipInfo': ipInfo,
    'mapyCz': mapyCz,
    'httpHeaders': httpHeaders,
    'disify': disify,
    'maigret': maigret
};

export function load() {
    return `
        <div class="centered">
            <div class="loader">
            </div>
        </div>
    `;
}

export function error() {
    return `
        <div class="centered">
            <img class="w-100" src="/static/media/warning-icon.png">
            <p class="text-center fs-5">Failed to load</p>
        </div>
    `;
}

export function ipInfo(data) {
    return `
        <ul class="list-group list-group-flush">
            <li class="list-group-item">Ip adress: ${data.ip}</li>
            <li class="list-group-item">Timezone: ${data.timezone}</li>
            <li class="list-group-item">Country: ${data.country}</li>
            <li class="list-group-item">Region: ${data.region}</li>
            <li class="list-group-item">City: ${data.city}</li>
            <li class="list-group-item">Postal code: ${data.postal}</li>
            <li class="list-group-item">Location: ${data.loc}</li>
        </ul>
    `;
}

export function mapyCz(data) {
    const source = `https://api.mapy.com/v1/static/map?lon=${data.longtitude}&lat=${data.latitude}&zoom=4&width=540&height=450&mapset=basic&markers=color:red;size:normal;${data.longtitude},${data.latitude}&apikey=${data.token}`;

    return `
        <img src=${source} width="100%" height="100%" class="rounded-bottom">
    `;
}

export function httpHeaders(data) {
    return `
        <ul class="list-group list-group-flush">
            <li class="list-group-item">User Agent: ${data.user_agent}</li>
            <li class="list-group-item">Operating system: ${data.os}</li>
            <li class="list-group-item">Language: ${data.language}</li>
        </ul>
    `;
}

export function disify(data) {
    let validExists = false;
    let outputData = "";

    for(let email in data) {
        console.log(data[email]);

        outputData += `
            <li class="list-group-item">
                <p class="p-0 fw-bold">${email}</p>
                <ul class="list-group">
                    <li class="list-group-item">Domain: ${data[email]['domain']}</li> 
                    <li class="list-group-item">Is valid: ${data[email]['valid']}</li>
                    <li class="list-group-item">Is disposable: ${data[email]['disposable']}</li>
                </ul>
            </li>
        \n`;

        if(data[email]['valid']) {
            validExists = true;
        }
    }

    if(!validExists) {
        return disifyError();
    }

    return `
        <ul class="list-group list-group-flush">
            ${outputData}
        </ul>
    `;
}

function disifyError() {
    return `
        <div class="centered">
            <img class="w-100" src="/static/media/email-icon.png">
            <p class="text-center fs-5">No valid emails</p>
        </div>
    `;
}

export function maigret(data) {
    let outputData = "";
    let sitesData = "";

    for(let username in data) {
        
        for(let site in data[username]) {
            sitesData += `
                <li class="list-group-item">
                    <p class="p-0 d-inline">${data[username][site]['site']}</p>
                    <a class="float-end me-2" href="${data[username][site]['url']}">Link</a>
                </li>
            \n`;
        }

        outputData += `
            <li class="list-group-item">
                <p class="p-0 fw-bold">${username}</p>
                <ul class="list-group">
                    ${sitesData}
                </ul>
            </li>
        \n`;
    }
    console.log(data.itisntme1.Roblox.site)

    return `
        <ul class="list-group list-group-flush">
            ${outputData}
        </ul>
    `;
}