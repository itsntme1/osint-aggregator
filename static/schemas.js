
export const schemaTable = {
    'load': load,
    'error': error,
    'ipInfo': ipInfo
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
        <div>
            <p>Ip adress: ${data.ip}</p>
            <p>Timezone: ${data.timezone}</p>
            <p>Country: ${data.country}</p>
            <p>Region: ${data.region}</p>
            <p>City: ${data.city}</p>
            <p>Postal code: ${data.postal}</p>
            <p>Location: ${data.loc}</p>
        </div>
    `;
}
