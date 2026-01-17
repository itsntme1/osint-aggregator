
import { schemaTable } from './schemas.js';

async function loadData(element) {
    try {
        const endpoint = element.closest("[data-endpoint]").dataset.endpoint;
        const schema = element.closest("[data-schema]").dataset.schema;
        
        const response = await fetch(endpoint);
        const data = await response.json();
        
        element.innerHTML = await schemaTable[schema](data);
    }
    catch {
        element.innerHTML = schemaTable['error']();
    }
}

function reloadData(element) {
    element = element.closest("[data-title]").querySelector("[data-display]");

    element.innerHTML = schemaTable['load']();

    loadData(element);
}

function initialLoadData() {
    document.querySelectorAll("[data-display]").forEach(element => {
        loadData(element);
    });
}

function assignReloadData() {
    document.querySelectorAll("[data-reload]").forEach(element => {
        element.addEventListener("click", () => {
            reloadData(element);
        });
    });
}

document.addEventListener("DOMContentLoaded", initialLoadData);
document.addEventListener("DOMContentLoaded", assignReloadData);