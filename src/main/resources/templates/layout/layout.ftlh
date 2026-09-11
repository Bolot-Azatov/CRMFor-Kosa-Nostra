<#import "/spring.ftl" as spring/>

<#macro page_layout title="Cosa Nostra CRM" activeTab="">
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${title}</title>

        <!-- Шрифт Cinzel для премиальных золотых заголовков и Courier Prime для эффекта печатной машинки -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;800;900&family=Courier+Prime:wght@400;700&display=swap" rel="stylesheet">

        <#global known = SPRING_SECURITY_CONTEXT??>
        <#if known>
            <#assign user = SPRING_SECURITY_CONTEXT.authentication.principal>
            <#assign username = user.username!>
            <#assign authorities = SPRING_SECURITY_CONTEXT.authentication.authorities!>
            <#global isBoss = false>
            <#global isConsigliere = false>
            <#global isCapo = false>
            <#global isSoldier = false>
            <#list authorities as auth>
                <#if auth.authority == "BOSS"><#global isBoss = true></#if>
                <#if auth.authority == "CONSIGLIERE"><#global isConsigliere = true></#if>
                <#if auth.authority == "CAPO"><#global isCapo = true></#if>
                <#if auth.authority == "SOLDIER"><#global isSoldier = true></#if>
            </#list>
        <#else>
            <#global isBoss = false>
            <#global isConsigliere = false>
            <#global isCapo = false>
            <#global isSoldier = false>
        </#if>

        <style>
            :root {
                --bg-charcoal: #121212;
                --bg-card: #1A1A1A;
                --burgundy-dark: #3D0C02;
                --burgundy-light: #6B1310;
                --brass-gold: #C5A059;
                --brass-gold-hover: #E5C17C;
                --text-main: #E5E5E5;
                --text-muted: #9E9E9E;
                --border-gold: 1px solid rgba(197, 160, 89, 0.3);
                --border-burgundy: 1px solid rgba(107, 19, 16, 0.6);
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                background-color: var(--bg-charcoal);
                color: var(--text-main);
                font-family: 'Courier Prime', monospace;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            /* --- Navbar Styles --- */
            .speakeasy-navbar {
                background: linear-gradient(180deg, #1A1A1A 0%, #121212 100%);
                border-bottom: 2px solid var(--brass-gold);
                padding: 0 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                height: 70px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.8);
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            .brand-logo {
                font-family: 'Cinzel', serif;
                font-size: 1.4rem;
                font-weight: 900;
                color: var(--brass-gold);
                text-decoration: none;
                letter-spacing: 2px;
                text-transform: uppercase;
                display: flex;
                align-items: center;
                gap: 10px;
                text-shadow: 0 0 10px rgba(197, 160, 89, 0.2);
            }

            .brand-logo::before {
                content: '⚖';
                font-size: 1.2rem;
            }

            .nav-links {
                display: flex;
                list-style: none;
                gap: 1.5rem;
                height: 100%;
            }

            .nav-item {
                display: flex;
                align-items: center;
            }

            .nav-link {
                font-family: 'Cinzel', serif;
                font-size: 0.9rem;
                color: var(--text-muted);
                text-decoration: none;
                text-transform: uppercase;
                letter-spacing: 1px;
                padding: 0.5rem 0.8rem;
                transition: all 0.3s ease;
                position: relative;
            }

            .nav-link:hover, .nav-link.active {
                color: var(--brass-gold);
                text-shadow: 0 0 8px rgba(197, 160, 89, 0.4);
            }

            .nav-link.active::after {
                content: '';
                position: absolute;
                bottom: -22px;
                left: 0;
                width: 100%;
                height: 3px;
                background-color: var(--brass-gold);
                box-shadow: 0 0 10px var(--brass-gold);
            }

            .user-status {
                display: flex;
                align-items: center;
                gap: 14px;
                font-size: 0.85rem;
                border-left: var(--border-gold);
                padding-left: 1.5rem;
            }

            .avatar-frame {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                border: 1px solid var(--brass-gold);
                background: var(--burgundy-dark);
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Cinzel', serif;
                color: var(--brass-gold);
                font-weight: bold;
                filter: contrast(120%);
            }

            /* --- Logout Button Styles --- */
            .logout-form {
                margin: 0;
                padding: 0;
                display: flex;
                align-items: center;
            }

            .logout-btn {
                background: transparent;
                border: var(--border-burgundy);
                color: var(--text-muted);
                font-family: 'Cinzel', serif;
                font-size: 0.75rem;
                padding: 0.4rem 0.7rem;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                display: flex;
                align-items: center;
                gap: 4px;
            }

            .logout-btn:hover {
                background-color: var(--burgundy-dark);
                color: #FF8A80;
                border-color: #FF5252;
                box-shadow: 0 0 10px rgba(107, 19, 16, 0.8);
            }

            /* --- Main Content Container --- */
            .main-container {
                flex: 1;
                max-width: 1200px;
                width: 100%;
                margin: 2rem auto;
                padding: 0 1.5rem;
            }

            /* --- Speakeasy Validation & Alert Banners --- */
            .alert-box {
                background-color: var(--burgundy-dark);
                border: var(--border-gold);
                border-left: 5px solid var(--burgundy-light);
                color: #FFD2D2;
                padding: 1rem 1.2rem;
                margin-bottom: 1.5rem;
                border-radius: 2px;
                box-shadow: 0 4px 15px rgba(61, 12, 2, 0.5);
                font-size: 0.9rem;
            }

            .alert-title {
                font-family: 'Cinzel', serif;
                color: var(--brass-gold);
                font-weight: bold;
                margin-bottom: 0.5rem;
                text-transform: uppercase;
                letter-spacing: 1px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .alert-box ul {
                list-style-type: square;
                margin-left: 1.5rem;
            }

            .alert-box li {
                margin-bottom: 0.2rem;
            }

            .alert-success {
                background-color: #0E241B;
                border-left-color: #1B5E20;
                color: #D4EDDA;
            }
        </style>
    </head>
    <body>

    <!-- Навбар / Header -->
    <header class="speakeasy-navbar">
        <a href="/" class="brand-logo">Cosa Nostra</a>

        <nav>
            <ul class="nav-links">
                <li class="nav-item">
                    <a href="/family" class="nav-link <#if activeTab == 'capos'>active</#if>">Семья</a>
                </li>
                <li class="nav-item">
                    <a href="/racket" class="nav-link <#if activeTab == 'racket'>active</#if>">Доходы & Рэкет</a>
                </li>
                <li class="nav-item">
                    <a href="/territories" class="nav-link <#if activeTab == 'territories'>active</#if>">Территории</a>
                </li>
                <li class="nav-item">
                    <a href="/dossiers" class="nav-link <#if activeTab == 'dossiers'>active</#if>">Досье</a>
                </li>
            </ul>
        </nav>

        <div class="user-status">
            <div class="avatar-frame">DON</div>
            <div>
                <div style="color: var(--brass-gold); font-family: 'Cinzel', serif;">Дон Болот</div>
                <div style="color: var(--text-muted); font-size: 0.75rem;">Capo di Tutti Capi</div>
            </div>

            <!-- Форма и кнопка выхода (POST для Spring Security) -->
            <form action="/logout" method="post" class="logout-form">

                <button type="submit" class="logout-btn" title="Покинуть сходку">
                    🚪 Выйти
                </button>
            </form>
        </div>
    </header>

    <!-- Основной контент страницы -->
    <main class="main-container">

        <!-- Глобальная обработка ошибок валидации через Spring Binding Result -->
        <#if spring.status?? && spring.status.errorMessages?has_content>
            <div class="alert-box">
                <div class="alert-title">⚠️ Ошибки при заполнении протокола:</div>
                <ul>
                    <#list spring.status.errorMessages as error>
                        <li>${error}</li>
                    </#list>
                </ul>
            </div>
        </#if>

        <!-- Ручные флэш-уведомления из контроллера (Model attributes) -->
        <#if errorMessage??>
            <div class="alert-box">
                <div class="alert-title">⛔ Нарушение омерты:</div>
                <p>${errorMessage}</p>
            </div>
        </#if>

        <#if successMessage??>
            <div class="alert-box alert-success">
                <div class="alert-title" style="color: #81C784;">🗡️ Дело закрыто:</div>
                <p>${successMessage}</p>
            </div>
        </#if>

        <!-- Сюда вставляется содержимое конкретной страницы -->
        <#nested/>

    </main>

    </body>
    </html>
</#macro>