
export const schemaTable = {
    'load': load,
    'error': error,
    'ipInfo': ipInfo,
    'mapyCz': mapyCz,
    'httpHeaders': httpHeaders,
    'disify': disify,
    'maigret': maigret,
    'xposedornot': xposedornot,
    'nameInfo': nameInfo
};

export function load() {
    return `
        <div class="position-absolute top-50 start-50 translate-middle">
            <div class="loader">
            </div>
        </div>
    `;
}

export function error() {
    return `
        <div class="position-absolute top-50 start-50 translate-middle">
            <img class="w-100" src="/static/media/warning-icon.png">
            <p class="text-center fs-5 fw-semibold">Failed to load</p>
        </div>
    `;
}

export function ipInfo(data) {
    const [latitude, longtitude] = data.loc.split(",");

    return `
        <ul class="list-group list-group-flush">
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Ip adress:</p>
                <p class="d-inline m-0 float-end">${data.ip}</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Timezone:</p>
                <p class="d-inline m-0 float-end">${data.timezone}</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Country:</p>
                <p class="d-inline m-0 float-end">${data.country}</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Region:</p>
                <p class="d-inline m-0 float-end">${data.region}</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">City:</p>
                <p class="d-inline m-0 float-end">${data.city}</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Postal code:</p>
                <p class="d-inline m-0 float-end">${data.postal}</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Location:</p>
                <p class="d-inline m-0 float-end">${latitude}&#176; ${longtitude}&#176;</p>
            </li>
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
            <li class="list-group-item">
                <p class="d-inline fw-semibold">User Agent:</p>
                <p class="d-inline m-0 float-end">${data.user_agent}</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Operating system:</p>
                <p class="d-inline m-0 float-end">${data.os}</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Language:</p>
                <p class="d-inline m-0 float-end">${data.language}</p>
            </li>
        </ul>
    `;
}

export function disify(data) {
    let validExists = false;
    let outputData = "";

    for(let email in data) {
        outputData += `
            <li class="list-group-item">
                <p class="p-0 fw-bold">${email}</p>
                <ul class="list-group">
                    <li class="list-group-item">
                        <p class="d-inline fw-semibold">Domain:</p>
                        <p class="d-inline m-0 float-end">${data[email]['domain']}</p>
                    </li>
                    <li class="list-group-item">
                        <p class="d-inline fw-semibold">Is valid?:</p>
                        <p class="d-inline m-0 float-end">${data[email]['valid']}</p>
                    </li>
                    <li class="list-group-item">
                        <p class="d-inline fw-semibold">Is disposable?:</p>
                        <p class="d-inline m-0 float-end">${data[email]['disposable']}</p>
                    </li>
                </ul>
            </li>
        `;

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
        <div class="position-absolute top-50 start-50 translate-middle">
            <img class="w-100" src="/static/media/email-icon.png">
            <p class="text-center fs-5 fw-semibold">No valid emails</p>
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
                    <p class="p-0 d-inline fw-semibold">${data[username][site]['site']}</p>
                    <a class="float-end me-2 text-dark" href="${data[username][site]['url']}"><i class="bi bi-link-45deg"></i></a>
                </li>
            `;
        }

        outputData += `
            <li class="list-group-item">
                <p class="fw-bold">${username}</p>
                <ul class="list-group">
                    ${sitesData}
                </ul>
            </li>
        `;
    }

    return `
        <ul class="list-group list-group-flush">
            ${outputData}
        </ul>
    `;
}

export function xposedornot(data) {
    let breachExists = false
    let outputData = "";

    console.log(data)

    for(let email in data) {
        let breaches = "";

        if(data[email]['Error'] == "Not found") {
            breachExists = true;
            
            continue;
        }

        for(let breach in data[email]['breaches']) {
            const breachName = data[email]['breaches'][breach];

            breaches += `
                <li class="list-group-item">
                    <p class="p-0 d-inline fw-semibold">${breachName}</p>
                    <a class="float-end me-2" target="_blank" href="https://www.google.com/search?q=${breachName} breach">Link</a>    
                </li>
            `;
        }

        outputData += `
            <li class="list-group-item">
                <p class="fw-semibold">${email}</p>
                <ul class="list-group">
                    ${breaches}
                </ul>
            </li>
        `;
    }

    if(breachExists) {
        return xposedornotError();
    }

    return `
        <ul class="list-group list-group-flush">
            ${outputData}
        </ul>
    `;
}

function xposedornotError() {
    return `
        <div class="position-absolute top-50 start-50 translate-middle">
            <img class="w-100" src="/static/media/email-icon.png">
            <p class="text-center fs-5 fw-semibold">No breaches</p>
        </div>
    `;
}

export function nameInfo(data) {
    return `
        <ul class="list-group list-group-flush">
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Name:</p>
                <p class="float-end m-0">${data.name}</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Gender:</p>
                <p class="float-end m-0">${data.gender} (${data.gender_probability}% sure)</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Age:</p>
                <p class="float-end m-0">${data.age}</p>
            </li>
            <li class="list-group-item">
                <p class="d-inline fw-semibold">Country:</p>
                <p class="float-end m-0">${data.country} (${data.country_probability}% sure)</p>
            </li>
        </ul>
    `;
}