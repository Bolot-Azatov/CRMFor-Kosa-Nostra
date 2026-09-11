<#import "/spring.ftl" as spring/>

<#macro page_layout title="Cosa Nostra CRM" activeTab="">
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${title}</title>

        <!-- Шрифт Cinzel для золотых заголовков и Courier Prime для эффекта печатной машинки -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;800;900&family=Courier+Prime:wght@400;700&display=swap" rel="stylesheet">

        <!-- Определение контекста пользователя и ролей Spring Security -->
        <#global known = SPRING_SECURITY_CONTEXT??>
        <#global isBoss = false>
        <#global isConsigliere = false>
        <#global isCapo = false>
        <#global isSoldier = false>

        <#if known>
            <#assign principal = SPRING_SECURITY_CONTEXT.authentication.principal>
            <#assign username = principal.username!>
            <#assign authorities = SPRING_SECURITY_CONTEXT.authentication.authorities!>

            <#list authorities as auth>
                <#if auth.authority == "ROLE_BOSS" || auth.authority == "BOSS">
                    <#global isBoss = true>
                </#if>
                <#if auth.authority == "ROLE_CONSIGLIERE" || auth.authority == "CONSIGLIERE" || auth.authority == "ROLE_COUNSELOR">
                    <#global isConsigliere = true>
                </#if>
                <#if auth.authority == "ROLE_CAPO" || auth.authority == "CAPO">
                    <#global isCapo = true>
                </#if>
                <#if auth.authority == "ROLE_SOLDIER" || auth.authority == "SOLDIER">
                    <#global isSoldier = true>
                </#if>
            </#list>

            <!-- Назначение бэйджа и ранга -->
            <#if isBoss>
                <#assign roleBadge = "DON">
                <#assign roleTitle = "Capo di Tutti Capi">
            <#elseif isConsigliere>
                <#assign roleBadge = "CONS">
                <#assign roleTitle = "Consigliere">
            <#elseif isCapo>
                <#assign roleBadge = "CAPO">
                <#assign roleTitle = "Caporegime">
            <#elseif isSoldier>
                <#assign roleBadge = "SOLD">
                <#assign roleTitle = "Soldier">
            <#else>
                <#assign roleBadge = "MBR">
                <#assign roleTitle = "Associate">
            </#if>
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

            /* --- Navbar --- */
            .speakeasy-navbar {
                background: linear-gradient(180deg, #1A1A1A 0%, #121212 100%);
                border-bottom: 2px solid var(--brass-gold);
                padding: 0 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                min-height: 70px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.8);
                position: sticky;
                top: 0;
                z-index: 1000;
                flex-wrap: wrap;
                gap: 1rem;
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
                gap: 1rem;
                align-items: center;
                flex-wrap: wrap;
            }

            .nav-link {
                font-family: 'Cinzel', serif;
                font-size: 0.82rem;
                color: var(--text-muted);
                text-decoration: none;
                text-transform: uppercase;
                letter-spacing: 1px;
                padding: 0.4rem 0.6rem;
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
                bottom: -6px;
                left: 0;
                width: 100%;
                height: 2px;
                background-color: var(--brass-gold);
                box-shadow: 0 0 8px var(--brass-gold);
            }

            .user-status {
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 0.85rem;
                border-left: var(--border-gold);
                padding-left: 1.5rem;
            }

            .user-profile-link {
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 10px;
                transition: opacity 0.2s;
            }

            .user-profile-link:hover {
                opacity: 0.85;
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
                font-size: 0.85rem;
                font-weight: bold;
            }

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

            .btn-auth-link {
                font-family: 'Cinzel', serif;
                font-size: 0.8rem;
                color: var(--brass-gold);
                text-decoration: none;
                border: var(--border-gold);
                padding: 0.4rem 0.8rem;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.2s ease;
            }

            .btn-auth-link:hover {
                background: rgba(197, 160, 89, 0.1);
                color: var(--brass-gold-hover);
            }

            /* --- Main Content --- */
            .main-container {
                flex: 1;
                max-width: 1200px;
                width: 100%;
                margin: 2rem auto;
                padding: 0 1.5rem;
            }

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

    <!-- Навбар с динамическими правами -->
    <header class="speakeasy-navbar">
        <a href="/" class="brand-logo">Cosa Nostra</a>

        <!-- Фрагмент навбара в src/main/resources/templates/layout/layout.ftlh -->
        <nav>
            <ul class="nav-links">
                <li>
                    <a href="/" class="nav-link <#if activeTab == 'home'>active</#if>">Главная</a>
                </li>
                <li>
                    <a href="/articles" class="nav-link <#if activeTab == 'articles'>active</#if>">Сводки</a>
                </li>

                <#if known>
                    <!-- Единая иерархия 5 семей -->
                    <li>
                        <a href="/hierarchy" class="nav-link <#if activeTab == 'family'>active</#if>">Иерархия 5 Семей</a>
                    </li>

                    <!-- Капо -->
                    <#if isCapo>
                        <li>
                            <a href="/capo/business" class="nav-link <#if activeTab == 'racket' || activeTab == 'business'>active</#if>">Мой Рэкет</a>
                        </li>
                        <li>
                            <a href="/capo/tribute" class="nav-link <#if activeTab == 'tribute'>active</#if>">Сдать Дань</a>
                        </li>
                    </#if>

                    <!-- Консильери -->
                    <#if isConsigliere>
                        <li>
                            <a href="/consigliere/ledger" class="nav-link <#if activeTab == 'ledger'>active</#if>">Книга Доходов</a>
                        </li>
                        <li>
                            <a href="/consigliere/messages" class="nav-link <#if activeTab == 'message'>active</#if>">Почта</a>
                        </li>
                    </#if>

                    <!-- Дон (Босс) -->
                    <#if isBoss>
                        <li>
                            <a href="/boss/dashboard" class="nav-link <#if activeTab == 'dashboard'>active</#if>">Штаб Дона</a>
                        </li>
                        <li>
                            <a href="/boss/members" class="nav-link <#if activeTab == 'capos'>active</#if>">Кадры</a>
                        </li>
                        <li>
                            <a href="/boss/businesses" class="nav-link <#if activeTab == 'businesses'>active</#if>">Бизнесы</a>
                        </li>
                        <li>
                            <a href="/boss/treasury" class="nav-link <#if activeTab == 'boss_ledger'>active</#if>">Казна</a>
                        </li>
                        <li>
                            <a href="/boss/diplomacy" class="nav-link <#if activeTab == 'diplomacy'>active</#if>">Дипломатия</a>
                        </li>
                        <li>
                            <a href="/boss/messages" class="nav-link <#if activeTab == 'messages'>active</#if>">Депеши</a>
                        </li>
                    </#if>
                </#if>
            </ul>
        </nav>

        <!-- Блок статуса пользователя справа -->
        <div class="user-status">
            <#if known>
                <a href="/profile" class="user-profile-link" title="Перейти в личное досье">
                    <div class="avatar-frame">${roleBadge!"MBR"}</div>
                    <div>
                        <div style="color: var(--brass-gold); font-family: 'Cinzel', serif; font-weight: bold;">
                            ${username!"Неизвестный"}
                        </div>
                        <div style="color: var(--text-muted); font-size: 0.72rem; text-transform: uppercase;">
                            ${roleTitle!"Участник"}
                        </div>
                    </div>
                </a>

                <!-- Выход из системы с обязательным CSRF-токеном -->
                <form action="/logout" method="post" class="logout-form">
                    <#if _csrf??>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </#if>
                    <button type="submit" class="logout-btn" title="Покинуть сходку">
                        🚪 Выйти
                    </button>
                </form>
            <#else>
                <a href="/login" class="btn-auth-link">Вход</a>
                <a href="/register" class="btn-auth-link" style="border-color: rgba(197, 160, 89, 0.6); background: rgba(197, 160, 89, 0.1);">Присяга</a>
            </#if>
        </div>
    </header>

    <main class="main-container">

        <!-- Ошибки валидации Spring -->
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

        <!-- Flash-уведомления контроллеров -->
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

        <#nested/>

    </main>

    </body>
    </html>
</#macro>