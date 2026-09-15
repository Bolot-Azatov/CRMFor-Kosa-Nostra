<#import "/spring.ftl" as spring/>
<!DOCTYPE html>
<html lang="${springMacroRequestContext.locale.language!'ru'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><@spring.message "auth.login.title"/> | Cosa Nostra</title>

    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='7' fill='%233D0C02' stroke='%23C5A059' stroke-width='1.5'/%3E%3Cg transform='translate(4, 4)' stroke='%23FFFFFF' stroke-width='2' fill='none' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M12 3v18'/%3E%3Cpath d='M7 21h10'/%3E%3Cpath d='M3 7h18'/%3E%3Cpath d='M2 15l3-8 3 8a3 3 0 0 1-6 0z' fill='%23FFFFFF' fill-opacity='0.3'/%3E%3Cpath d='M16 15l3-8 3 8a3 3 0 0 1-6 0z' fill='%23FFFFFF' fill-opacity='0.3'/%3E%3C/g%3E%3C/svg%3E">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;800;900&family=Courier+Prime:wght@400;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="landing-page">

<div class="speakeasy-card">
    <div style="display: flex; justify-content: flex-end; margin-bottom: 0.5rem;">
        <div class="lang-switch">
            <a href="?lang=ru" class="lang-btn <#if (springMacroRequestContext.locale.language == 'ru')!true>active</#if>">RU</a>
            <span class="lang-divider">/</span>
            <a href="?lang=en" class="lang-btn <#if (springMacroRequestContext.locale.language == 'en')!false>active</#if>">EN</a>
        </div>
    </div>

    <div class="logo-emblem">🗝️</div>

    <h1 class="brand-title"><@spring.message "auth.login.title"/></h1>
    <p class="brand-subtitle"><@spring.message "auth.login.subtitle"/></p>

    <#if RequestParameters.error??>
        <div class="alert-box">
            <div class="alert-title">⛔ <@spring.message "auth.login.access_denied"/></div>
            <p><@spring.message "auth.login.error"/></p>
        </div>
    </#if>

    <#if RequestParameters.logout??>
        <div class="alert-box" style="border-left-color: var(--brass-gold);">
            <div class="alert-title">🔒 <@spring.message "auth.login.session_closed"/></div>
            <p><@spring.message "auth.login.logout"/></p>
        </div>
    </#if>

    <form action="/login" method="POST" onsubmit="localStorage.removeItem('syndicate_playlist'); localStorage.removeItem('syndicate_track_idx'); localStorage.removeItem('syndicate_audio_time'); localStorage.setItem('syndicate_audio_muted', 'false');">
        <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

        <div class="form-group" style="text-align: left;">
            <label for="username" class="form-label"><@spring.message "auth.login.username"/></label>
            <input type="text" id="username" name="username" class="form-input" placeholder="Don_Corleone" required autofocus />
        </div>

        <div class="form-group" style="text-align: left;">
            <label for="password" class="form-label"><@spring.message "auth.login.password"/></label>
            <input type="password" id="password" name="password" class="form-input" placeholder="••••••••" required />
        </div>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; font-size: 0.82rem; color: var(--text-muted);">
            <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                <input type="checkbox" name="remember-me" id="remember-me" style="accent-color: var(--brass-gold); width: 16px; height: 16px;" />
                <span><@spring.message "auth.login.remember_me"/></span>
            </label>
        </div>

        <button type="submit" class="btn-submit"><@spring.message "auth.login.submit"/></button>
    </form>

    <div style="margin-top: 1.8rem; display: flex; flex-direction: column; gap: 0.8rem; font-size: 0.82rem;">
        <a href="/register"><@spring.message "auth.login.to_register"/></a>
        <a href="/" style="color: var(--text-muted);"><@spring.message "auth.login.to_home"/></a>
    </div>
</div>

</body>
</html>