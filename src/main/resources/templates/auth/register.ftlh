<#import "/spring.ftl" as spring/>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Регистрация в Синдикате | Cosa Nostra</title>

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
            --error-red: #FF5555;
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
            padding: 2.5rem 1.5rem;
        }

        .speakeasy-card {
            background-color: rgba(26, 26, 26, 0.95);
            border: var(--border-gold);
            box-shadow: 0 0 50px rgba(0, 0, 0, 0.95), inset 0 0 25px rgba(61, 12, 2, 0.5);
            padding: 3rem 2.5rem;
            max-width: 580px;
            width: 100%;
            position: relative;
        }

        /* Декоративные уголки */
        .speakeasy-card::before, .speakeasy-card::after {
            content: '';
            position: absolute;
            width: 16px;
            height: 16px;
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

        /* Сетка для двух колонок ввода */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.2rem;
        }

        @media (max-width: 480px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }

        .form-group {
            margin-bottom: 1.3rem;
        }

        .form-label {
            display: block;
            font-family: 'Cinzel', serif;
            font-size: 0.82rem;
            color: var(--brass-gold);
            letter-spacing: 1px;
            margin-bottom: 0.4rem;
            text-transform: uppercase;
        }

        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 0.8rem 0.9rem;
            background-color: #121212;
            border: var(--border-gold);
            color: var(--text-main);
            font-family: 'Courier Prime', monospace;
            font-size: 0.9rem;
            outline: none;
            transition: all 0.3s ease;
        }

        .form-select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23C5A059'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.7rem center;
            background-size: 1.2rem;
        }

        .form-textarea {
            resize: vertical;
            min-height: 90px;
        }

        .form-input:focus, .form-select:focus, .form-textarea:focus {
            border-color: var(--brass-gold-hover);
            box-shadow: 0 0 10px rgba(197, 160, 89, 0.3);
            background-color: #161616;
        }

        /* Ошибки валидации */
        .field-error {
            color: var(--error-red);
            font-size: 0.75rem;
            margin-top: 0.3rem;
            display: block;
        }

        /* Кнопка отправки */
        .btn-submit {
            display: block;
            width: 100%;
            padding: 0.95rem;
            margin-top: 1rem;
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

        .links-group {
            margin-top: 1.5rem;
            text-align: center;
            display: flex;
            flex-direction: column;
            gap: 0.6rem;
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

<!-- Привязка к DTO "registerRequest" для чтения ошибок Spring Validation -->
<@spring.bind "registerRequest"/>

<div class="speakeasy-card">
    <div class="logo-emblem">📜</div>

    <h1 class="brand-title">Присяга</h1>
    <p class="brand-subtitle">Вступление в Семью Cosa Nostra</p>

    <!-- Форма регистрации -->
    <form action="/register" method="POST">
        <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

        <div class="form-row">
            <!-- Username -->
            <div class="form-group">
                <label for="username" class="form-label">Псевдоним *</label>
                <@spring.formInput "registerRequest.username" 'id="username" class="form-input" placeholder="например, Frank_Pentangeli" maxlength="150" required' />
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label for="password" class="form-label">Пароль (4-10) *</label>
                <@spring.formPasswordInput "registerRequest.password" 'id="password" class="form-input" placeholder="••••••••" maxlength="10" required' />
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>
        </div>

        <div class="form-row">
            <!-- Family Name -->
            <div class="form-group">
                <label for="familyName" class="form-label">Семья *</label>
                <@spring.formInput "registerRequest.familyName" 'id="familyName" class="form-input" placeholder="например, Corleone" required' />
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>

            <!-- Role Select -->
            <div class="form-group">
                <label for="role" class="form-label">Статус в Семье *</label>
                <select id="role" name="role" class="form-select" required>
                    <option value="" disabled selected hidden>Выберите статус...</option>
                    <option value="SOLDIER" <#if (registerRequest.role!) == 'SOLDIER'>selected</#if>>Солдат (Soldier)</option>
                    <option value="CAPO" <#if (registerRequest.role!) == 'CAPO'>selected</#if>>Капореджиме (Capo)</option>
                    <option value="CONSIGLIERE" <#if (registerRequest.role!) == 'CONSIGLIERE'>selected</#if>>Консильери (Consigliere)</option>
                    <option value="ASSOCIATE" <#if (registerRequest.role!) == 'ASSOCIATE'>selected</#if>>Соучастник (Associate)</option>
                </select>
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>
        </div>

        <!-- Photo URL -->
        <div class="form-group">
            <label for="photoUrl" class="form-label">Ссылка на фото (Photo URL)</label>
            <@spring.formInput "registerRequest.photoUrl" 'id="photoUrl" class="form-input" placeholder="https://domain.com/photo.jpg"' />
            <span class="field-error"><@spring.showErrors "<br>"/></span>
        </div>

        <!-- Bio -->
        <div class="form-group">
            <label for="bio" class="form-label">Досье / Биография *</label>
            <@spring.formTextarea "registerRequest.bio" 'id="bio" class="form-textarea" placeholder="Укажите послужной список, особые приметы и рекомендации..." maxlength="2500" required' />
            <span class="field-error"><@spring.showErrors "<br>"/></span>
        </div>

        <button type="submit" class="btn-submit">Скрепить клятвой</button>

    </form>

    <div class="links-group">
        <a href="/login" class="link-item">Уже состоите в Семье? Войти</a>
        <a href="/" class="link-item link-muted">← Вернуться на главную</a>
    </div>
</div>

</body>
</html>