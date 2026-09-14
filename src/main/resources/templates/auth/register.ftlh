<#import "/spring.ftl" as spring/>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Регистрация в Синдикате | Cosa Nostra</title>

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

<@spring.bind "registerRequest"/>

<div class="speakeasy-card wide">
    <div class="logo-emblem">📜</div>

    <h1 class="brand-title">Присяга</h1>
    <p class="brand-subtitle">Вступление в Семью Cosa Nostra</p>

    <form action="/register" method="POST">
        <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

        <div class="form-row">
            <div class="form-group">
                <label for="username" class="form-label">Псевдоним *</label>
                <@spring.formInput "registerRequest.username" 'id="username" class="form-input" placeholder="Frank_Pentangeli" maxlength="150" required' />
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Пароль (4-10) *</label>
                <@spring.formPasswordInput "registerRequest.password" 'id="password" class="form-input" placeholder="••••••••" maxlength="10" required' />
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="familyName" class="form-label">Семья *</label>
                <@spring.formInput "registerRequest.familyName" 'id="familyName" class="form-input" placeholder="например, Corleone" required' />
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>

            <div class="form-group">
                <label for="photoUrl" class="form-label">Ссылка на фото (Photo URL)</label>
                <@spring.formInput "registerRequest.photoUrl" 'id="photoUrl" class="form-input" placeholder="https://domain.com/photo.jpg"' />
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>
        </div>

        <div class="form-group">
            <label for="bio" class="form-label">Досье / Биография *</label>
            <@spring.formTextarea "registerRequest.bio" 'id="bio" class="form-textarea" placeholder="Укажите послужной список, особые приметы и рекомендации..." maxlength="2500" required style="min-height: 90px; resize: vertical;"' />
            <span class="field-error"><@spring.showErrors "<br>"/></span>
        </div>

        <button type="submit" class="btn-submit" style="margin-top: 1rem;">Скрепить клятвой</button>
    </form>

    <div style="margin-top: 1.5rem; text-align: center; display: flex; flex-direction: column; gap: 0.6rem; font-size: 0.82rem;">
        <a href="/login">Уже состоите в Семье? Войти</a>
        <a href="/" style="color: var(--text-muted);">← Вернуться на главную</a>
    </div>
</div>

</body>
</html>