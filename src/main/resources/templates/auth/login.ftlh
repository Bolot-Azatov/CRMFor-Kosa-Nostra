<#import "/spring.ftl" as spring/>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Вход в кабинет | Cosa Nostra</title>

    <!-- Фавикон Синдиката -->
    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='6' fill='%233D0C02' stroke='%23C5A059' stroke-width='1.5'/%3E%3Ctext x='50%25' y='55%25' font-size='18' dominant-baseline='middle' text-anchor='middle'%3E%E2%9A%96%3C/text%3E%3C/svg%3E">

    <!-- Нуарные шрифты -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;800;900&family=Courier+Prime:wght@400;700&display=swap" rel="stylesheet">

    <!-- Единый мастер-стиль -->
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="landing-page">

<div class="speakeasy-card">
    <div class="logo-emblem">🗝️</div>

    <h1 class="brand-title">Вход</h1>
    <p class="brand-subtitle">Предъявите пропуск Синдиката</p>

    <#if RequestParameters.error??>
        <div class="alert-box">
            <div class="alert-title">⛔ Отказано в доступе</div>
            <p>Неверный псевдоним или пароль.</p>
        </div>
    </#if>

    <#if RequestParameters.logout??>
        <div class="alert-box" style="border-left-color: var(--brass-gold);">
            <div class="alert-title">🔒 Сессия закрыта</div>
            <p>Вы успешно вышли из системы.</p>
        </div>
    </#if>

    <form action="/login" method="POST">
        <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

        <div class="form-group" style="text-align: left;">
            <label for="username" class="form-label">Псевдоним / Имя</label>
            <input type="text" id="username" name="username" class="form-input" placeholder="например, Don_Corleone" required autofocus />
        </div>

        <div class="form-group" style="text-align: left;">
            <label for="password" class="form-label">Пароль</label>
            <input type="password" id="password" name="password" class="form-input" placeholder="••••••••" required />
        </div>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; font-size: 0.82rem; color: var(--text-muted);">
            <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                <input type="checkbox" name="remember-me" id="remember-me" style="accent-color: var(--brass-gold); width: 16px; height: 16px;" />
                <span>Запомнить меня</span>
            </label>
        </div>

        <button type="submit" class="btn-submit">Подтвердить личность</button>
    </form>

    <div style="margin-top: 1.8rem; display: flex; flex-direction: column; gap: 0.8rem; font-size: 0.82rem;">
        <a href="/register">Получить пропуск (Регистрация)</a>
        <a href="/" style="color: var(--text-muted);">← Вернуться на главную</a>
    </div>
</div>

</body>
</html>