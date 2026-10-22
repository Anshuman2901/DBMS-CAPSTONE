// Small shared helper used by every page.
// API_BASE must match the port your backend is running on (see backend/.env).
const API_BASE = 'http://localhost:5000/api';

function getToken() { return localStorage.getItem('token'); }
function getRole() { return localStorage.getItem('role'); }
function getName() { return localStorage.getItem('name'); }

function requireLogin(expectedRole) {
    const token = getToken();
    const role = getRole();
    if (!token) { window.location.href = (expectedRole === 'Admin' ? '../index.html' : '../index.html'); return; }
    if (expectedRole && role !== expectedRole) { window.location.href = '../index.html'; }
}

function logout() {
    localStorage.clear();
    window.location.href = (window.location.pathname.includes('/student/') || window.location.pathname.includes('/admin/')) ? '../index.html' : 'index.html';
}

async function apiRequest(path, method = 'GET', body = null) {
    const headers = { 'Content-Type': 'application/json' };
    const token = getToken();
    if (token) headers['Authorization'] = 'Bearer ' + token;
    const res = await fetch(API_BASE + path, {
        method,
        headers,
        body: body ? JSON.stringify(body) : null
    });
    const data = await res.json().catch(() => ({}));
    if (!res.ok) throw new Error(data.message || 'Request failed');
    return data;
}

function fmtDate(d) {
    if (!d) return '-';
    return new Date(d).toLocaleDateString('en-IN');
}

// Escape HTML to prevent XSS
function esc(str) {
    if (str === null || str === undefined) return '';
    const div = document.createElement('div');
    div.textContent = String(str);
    return div.innerHTML;
}

// Toast notification
function showToast(message, type = 'success') {
    const existing = document.querySelector('.toast');
    if (existing) existing.remove();
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.textContent = message;
    document.body.appendChild(toast);
    setTimeout(() => toast.remove(), 3500);
}

// Add loading state to a container
function showLoading(elementId) {
    const el = document.getElementById(elementId);
    if (el) el.innerHTML = '<div class="loading">Loading</div>';
}

// Client-side search/filter for tables
function addTableSearch(inputId, tableBodyId) {
    const input = document.getElementById(inputId);
    if (!input) return;
    input.addEventListener('input', () => {
        const filter = input.value.toLowerCase();
        const rows = document.getElementById(tableBodyId).querySelectorAll('tr');
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(filter) ? '' : 'none';
        });
    });
}
