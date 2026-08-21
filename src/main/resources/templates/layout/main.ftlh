<#import "/spring.ftl" as spring/>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cosa Nostra | 1950</title>

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
            /* Темный радиальный градиент с эффектом виньетки */
            background: radial-gradient(circle at center, #1E1E1E 0%, #0A0A0A 100%);
            color: var(--text-main);
            font-family: 'Courier Prime', monospace;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 1.5rem;
        }

        /* Центральная карточка-приглашение */
        .speakeasy-card {
            background-color: rgba(26, 26, 26, 0.95);
            border: var(--border-gold);
            box-shadow: 0 0 40px rgba(0, 0, 0, 0.9), inset 0 0 20px rgba(61, 12, 2, 0.5);
            padding: 3.5rem 2.5rem;
            max-width: 440px;
            width: 100%;
            text-align: center;
            position: relative;
        }

        /* Декоративные латунные уголки */
        .speakeasy-card::before, .speakeasy-card::after {
            content: '';
            position: absolute;
            width: 14px;
            height: 14px;
            border: 2px solid var(--brass-gold);
        }
        .speakeasy-card::before { top: 8px; left: 8px; border-right: none; border-bottom: none; }
        .speakeasy-card::after { bottom: 8px; right: 8px; border-left: none; border-top: none; }

        /* Эмблема-логотип */
        .logo-emblem {
            width: 76px;
            height: 76px;
            margin: 0 auto 1.5rem auto;
            border: 2px solid var(--brass-gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.2rem;
            background: var(--burgundy-dark);
            color: var(--brass-gold);
            box-shadow: 0 0 20px rgba(197, 160, 89, 0.25);
        }

        .brand-title {
            font-family: 'Cinzel', serif;
            font-size: 2.6rem;
            font-weight: 900;
            color: var(--brass-gold);
            letter-spacing: 4px;
            text-transform: uppercase;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.9), 0 0 15px rgba(197, 160, 89, 0.3);
            margin-bottom: 0.3rem;
        }

        .brand-subtitle {
            font-size: 0.8rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 2.5rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.2);
            padding-bottom: 1rem;
        }

        /* Блок с кнопками по центру */
        .actions-group {
            display: flex;
            flex-direction: column;
            gap: 1.1rem;
        }

        .btn-speakeasy {
            display: block;
            width: 100%;
            padding: 0.9rem 1.5rem;
            font-family: 'Cinzel', serif;
            font-size: 0.95rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-decoration: none;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        /* Главная кнопка ВХОД (Золотой градиент) */
        .btn-primary {
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            color: #0A0A0A;
            border: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.6);
        }

        .btn-primary:hover {
            background: linear-gradient(180deg, var(--brass-gold-hover) 0%, var(--brass-gold) 100%);
            box-shadow: 0 0 20px rgba(197, 160, 89, 0.5);
            transform: translateY(-2px);
        }

        /* Вторичная кнопка РЕГИСТРАЦИЯ (Латунная рамка) */
        .btn-secondary {
            background: transparent;
            color: var(--brass-gold);
            border: var(--border-gold);
        }

        .btn-secondary:hover {
            background: rgba(197, 160, 89, 0.1);
            color: var(--brass-gold-hover);
            border-color: var(--brass-gold-hover);
            transform: translateY(-2px);
        }

        /* Третичная кнопка СТАТЬИ (Тёмно-бордовый стиль) */
        .btn-outline {
            background: transparent;
            color: var(--text-muted);
            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .btn-outline:hover {
            background: var(--burgundy-dark);
            color: var(--text-main);
            border-color: var(--burgundy-light);
            transform: translateY(-2px);
        }

        .footer-note {
            margin-top: 2.2rem;
            font-size: 0.72rem;
            color: #666;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
    </style>
</head>
<body>

<div class="speakeasy-card">
    <!-- Логотип Синдиката -->
    <div class="logo-emblem">⚖</div>

    <!-- Название -->
    <h1 class="brand-title">Cosa Nostra</h1>
    <p class="brand-subtitle">Нью-Йорк • 1950 • Синдикат</p>

    <!-- Кнопки навигации -->
    <div class="actions-group">
        <a href="/login" class="btn-speakeasy btn-primary">Войти</a>
        <a href="/register" class="btn-speakeasy btn-secondary">Зарегистрироваться</a>
        <a href="/articles" class="btn-speakeasy btn-outline">Статьи</a>
    </div>

    <div class="footer-note">
        Доступ только по приглашению
    </div>
</div>

</body>
</html>