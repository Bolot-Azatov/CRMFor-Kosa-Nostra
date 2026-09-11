<#import "/spring.ftl" as spring/>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Вход в кабинет | Cosa Nostra</title>

    <!-- Подключение нуарных шрифтов Cinzel и Courier Prime -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;800;900&family=Courier+Prime:wght@400;700&display=swap" rel="stylesheet">

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
            --border-gold: 1px solid rgba(197, 160, 89, 0.4);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background: radial-gradient(circle at center, #1E1E1E 0%, #0A0A0A 100%);
            color: var(--text-main);
            font-family: 'Courier Prime', monospace;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 1.5rem;
        }

        .speakeasy-card {
            background-color: rgba(26, 26, 26, 0.95);
            border: var(--border-gold);
            box-shadow: 0 0 40px rgba(0, 0, 0, 0.9), inset 0 0 20px rgba(61, 12, 2, 0.5);
            padding: 3rem 2.5rem;
            max-width: 440px;
            width: 100%;
            position: relative;
        }

        /* Декоративные уголки */
        .speakeasy-card::before, .speakeasy-card::after {
            content: '';
            position: absolute;
            width: 14px;
            height: 14px;
            border: 2px solid var(--brass-gold);
        }
        .speakeasy-card::before { top: 8px; left: 8px; border-right: none; border-bottom: none; }
        .speakeasy-card::after { bottom: 8px; right: 8px; border-left: none; border-top: none; }

        .logo-emblem {
            width: 64px;
            height: 64px;
            margin: 0 auto 1.2rem auto;
            border: 2px solid var(--brass-gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            background: var(--burgundy-dark);
            color: var(--brass-gold);
            box-shadow: 0 0 15px rgba(197, 160, 89, 0.25);
        }

        .brand-title {
            font-family: 'Cinzel', serif;
            font-size: 2rem;
            font-weight: 800;
            color: var(--brass-gold);
            letter-spacing: 3px;
            text-transform: uppercase;
            text-align: center;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.9);
            margin-bottom: 0.3rem;
        }

        .brand-subtitle {
            font-size: 0.78rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 2px;
            text-align: center;
            margin-bottom: 2rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.2);
            padding-bottom: 0.8rem;
        }

        /* Блок ошибок авторизации */
        .alert-box {
            background-color: var(--burgundy-dark);
            border: 1px solid var(--burgundy-light);
            border-left: 4px solid #FF4D4D;
            color: #FFD2D2;
            padding: 0.8rem 1rem;
            margin-bottom: 1.5rem;
            font-size: 0.85rem;
        }

        .alert-title {
            font-family: 'Cinzel', serif;
            color: var(--brass-gold);
            font-weight: bold;
            margin-bottom: 0.2rem;
        }

        /* Поля формы */
        .form-group {
            margin-bottom: 1.4rem;
        }

        .form-label {
            display: block;
            font-family: 'Cinzel', serif;
            font-size: 0.85rem;
            color: var(--brass-gold);
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
        }

        .form-input {
            width: 100%;
            padding: 0.85rem 1rem;
            background-color: #121212;
            border: var(--border-gold);
            color: var(--text-main);
            font-family: 'Courier Prime', monospace;
            font-size: 0.95rem;
            outline: none;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            border-color: var(--brass-gold-hover);
            box-shadow: 0 0 10px rgba(197, 160, 89, 0.3);
            background-color: #161616;
        }

        /* Кастомный чекбокс */
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.8rem;
            font-size: 0.82rem;
            color: var(--text-muted);
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .remember-me input[type="checkbox"] {
            accent-color: var(--brass-gold);
            width: 15px;
            height: 15px;
        }

        /* Кнопка отправки */
        .btn-submit {
            display: block;
            width: 100%;
            padding: 0.9rem;
            font-family: 'Cinzel', serif;
            font-size: 0.95rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: #0A0A0A;
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.6);
        }

        .btn-submit:hover {
            background: linear-gradient(180deg, var(--brass-gold-hover) 0%, var(--brass-gold) 100%);
            box-shadow: 0 0 20px rgba(197, 160, 89, 0.5);
            transform: translateY(-2px);
        }

        /* Дополнительные ссылки */
        .links-group {
            margin-top: 1.8rem;
            text-align: center;
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
            font-size: 0.82rem;
        }

        .link-item {
            color: var(--brass-gold);
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .link-item:hover {
            color: var(--brass-gold-hover);
            text-decoration: underline;
        }

        .link-muted {
            color: var(--text-muted);
        }

        .link-muted:hover {
            color: var(--text-main);
        }
    </style>
</head>
<body>

<div class="speakeasy-card">
    <div class="logo-emblem">🗝️</div>

    <h1 class="brand-title">Вход</h1>
    <p class="brand-subtitle">Предъявите пропуск Синдиката</p>

    <!-- Обработка ошибки Spring Security (если URL содержит ?error) -->
    <#if RequestParameters.error??>
        <div class="alert-box">
            <div class="alert-title">⛔ Отказано в доступе</div>
            <p>Неверный псевдоним или пароль.</p>
        </div>
    </#if>

    <!-- Кастомное сообщение об ошибке/выходе из сессии -->
    <#if RequestParameters.logout??>
        <div class="alert-box" style="border-left-color: var(--brass-gold);">
            <div class="alert-title">🔒 Сессия закрыта</div>
            <p>Вы успешно вышли из системы.</p>
        </div>
    </#if>

    <!-- Форма авторизации -->
    <form action="/login" method="POST">
        <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

        <div class="form-group">
            <label for="username" class="form-label">Псевдоним / Имя</label>
            <input type="text" id="username" name="username" class="form-input" placeholder="например, Don_Corleone" required autofocus />
        </div>

        <div class="form-group">
            <label for="password" class="form-label">Пароль</label>
            <input type="password" id="password" name="password" class="form-input" placeholder="••••••••" required />
        </div>

        <div class="form-options">
            <label class="remember-me">
                <input type="checkbox" name="remember-me" id="remember-me" />
                <span>Запомнить меня</span>
            </label>
        </div>

        <button type="submit" class="btn-submit">Подтвердить личность</button>

    </form>

    <div class="links-group">
        <a href="/register" class="link-item">Получить пропуск (Регистрация)</a>
        <a href="/" class="link-item link-muted">← Вернуться на главную</a>
    </div>
</div>

</body>
</html>