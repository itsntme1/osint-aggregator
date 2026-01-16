
async function loadData(element, format) {
    try {
        const endpoint = element.closest("[data-endpoint]").dataset.endpoint
        console.log(endpoint)

        const response = await fetch(endpoint);
        const data = await response.json();

        element.innerHTML = await format(data);
    }
    catch {
        element.innerHTML = `<img src="/static/warning-icon.png"><br>Failed to load`;
    }
}
function reloadData(element, format) {
    element = element.closest("[name]").querySelector(".[data-display]");

    loadData(element, endpoint, format);
}

function initialLoadData() {
    document.querySelectorAll("[data-display]").forEach(element => {
        loadData(element, d => d.ip);
    });
}

function assignReloadData() {
    document.querySelectorAll("[data-reload]").forEach(element => {
        element.addEventListener("click", () => {
            reloadData(element, d => d.ip);
        });
    });
}

window.addEventListener("DOMContentLoaded", initialLoadData);
window.addEventListener("DOMContentLoaded", assignReloadData);
