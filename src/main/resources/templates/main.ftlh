<#macro page title="Cosa Nostra CRM" style="">
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${title}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #121212; color: #e0e0e0; min-height: 100vh; display: flex; flex-direction: column; }
            .card { background-color: #1e1e1e; border-color: #333; }
            footer { margin-top: auto; }
            ${style}
        </style>
    </head>
    <body>
    <header class="navbar navbar-dark bg-black border-bottom border-secondary mb-4 px-3">
        <div class="container-fluid">
            <a class="navbar-brand font-monospace fw-bold text-danger" href="/boss">🎭 COSA NOSTRA 1950s</a>
        </div>
    </header>

    <main class="container my-4">
        <#nested>
    </main>

    <footer class="text-center text-secondary py-3 border-top border-secondary bg-black">
        <small>&copy; 1950 Cosa Nostra CRM. All rights reserved.</small>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
</#macro>