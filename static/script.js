
async function loadData(element, endpoint, format) {
    try {
        const response = await fetch(endpoint);
        const data = await response.json();

        element.innerHTML = await format(data);
    }
    catch {
        element.innerHTML = `<img src="/static/warning-icon.png"><br>Failed to load`;
    }
}
function reloadData(element, endpoint, format) {
    element = element.closest(".data-div").querySelector(".data-display");

    loadData(element, endpoint, format);
}

function assignLoadData() {
    document.querySelectorAll(".data-display").forEach(element => {
        loadData(element, "/api/ip_info", d => d.ip);
    });
}

function assignReloadData() {
    document.querySelectorAll(".data-reload").forEach(element => {
        element.addEventListener("click", () => {
            reloadData(element, "/api/ip_info", d => d.ip);
        });
    });
}

window.addEventListener("DOMContentLoaded", assignLoadData);
window.addEventListener("DOMContentLoaded", assignReloadData);
