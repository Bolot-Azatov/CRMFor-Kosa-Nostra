<#import "/spring.ftl" as spring/>

<#macro page_layout title="Cosa Nostra CRM" activeTab="">
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0">
        <title>${title}</title>

        <!-- Тематический фавикон: золотые весы на темно-бордовой сургучной печати -->
        <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='6' fill='%233D0C02' stroke='%23C5A059' stroke-width='1.5'/%3E%3Ctext x='50%25' y='55%25' font-size='18' dominant-baseline='middle' text-anchor='middle'%3E%E2%9A%96%3C/text%3E%3C/svg%3E">

        <!-- Шрифты Cinzel и Courier Prime -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;800;900&family=Courier+Prime:wght@400;700&display=swap" rel="stylesheet">

        <!-- Единый мастер-стиль -->
        <link rel="stylesheet" href="/css/style.css">

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
    </head>
    <body>

    <header class="speakeasy-navbar">
        <div class="navbar-top">
            <a href="/" class="brand-logo">Cosa Nostra</a>

            <div class="user-status">
                <#if known>
                    <a href="/profile" class="user-profile-link" title="Личное досье">
                        <div class="avatar-frame">${roleBadge!"MBR"}</div>
                        <div>
                            <div style="color: var(--brass-gold); font-family: var(--font-heading); font-weight: bold; font-size: 0.85rem;">
                                ${username!"Неизвестный"}
                            </div>
                            <div style="color: var(--text-muted); font-size: 0.68rem; text-transform: uppercase;">
                                ${roleTitle!"Участник"}
                            </div>
                        </div>
                    </a>

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
        </div>

        <nav class="navbar-menu">
            <ul class="nav-links">
                <li>
                    <a href="/" class="nav-link <#if activeTab == 'home'>active</#if>">Главная</a>
                </li>
                <li>
                    <a href="/articles" class="nav-link <#if activeTab == 'articles'>active</#if>">Сводки</a>
                </li>

                <#if known>
                    <li>
                        <a href="/hierarchy" class="nav-link <#if activeTab == 'family'>active</#if>">Иерархия 5 Семей</a>
                    </li>

                    <#if isCapo>
                        <li>
                            <a href="/capo/business" class="nav-link <#if activeTab == 'racket' || activeTab == 'business'>active</#if>">Мой Рэкет</a>
                        </li>
                        <li>
                            <a href="/capo/tribute" class="nav-link <#if activeTab == 'tribute'>active</#if>">Сдать Дань</a>
                        </li>
                    </#if>

                    <#if isConsigliere>
                        <li>
                            <a href="/consigliere/ledger" class="nav-link <#if activeTab == 'ledger'>active</#if>">Книга Доходов</a>
                        </li>
                        <li>
                            <a href="/consigliere/messages" class="nav-link <#if activeTab == 'message'>active</#if>">Почта</a>
                        </li>
                    </#if>

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
    </header>

    <main class="main-container">

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