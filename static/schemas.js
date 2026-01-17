
export const schemaTable = {
    'load': load,
    'error': error,
    'ipInfo': ipInfo,
    'mapyCz': mapyCz
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
            <img class="w-100" src="/static/warning-icon.png">
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
    const source = `https://api.mapy.com/v1/static/map?lon=${data.longtitude}&lat=${data.latitude}&zoom=4&width=360&height=300&mapset=basic&markers=color:red;size:normal;${data.longtitude},${data.latitude}&apikey=${data.token}`;

    console.log(source)

    return `
        <img src=${source} width="100%" height="100%">
    `;
}