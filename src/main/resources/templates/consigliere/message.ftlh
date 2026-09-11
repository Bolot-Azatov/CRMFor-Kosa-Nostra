<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Секретное Письмо Дону | Консильери" activeTab="dossiers">

    <style>
        .letter-container {
            max-width: 650px;
            margin: 0 auto;
        }

        .letter-card {
            background: var(--bg-card);
            border: var(--border-gold);
            padding: 2.5rem;
            position: relative;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.85);
        }

        .letter-stamp {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            border: 2px solid var(--burgundy-light);
            color: #FF6666;
            padding: 0.2rem 0.6rem;
            font-family: 'Cinzel', serif;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            transform: rotate(-3deg);
        }

        .letter-title {
            font-family: 'Cinzel', serif;
            font-size: 1.8rem;
            color: var(--brass-gold);
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 0.4rem;
        }

        .form-group {
            margin-bottom: 1.3rem;
        }

        .form-label {
            display: block;
            font-family: 'Cinzel', serif;
            font-size: 0.8rem;
            color: var(--brass-gold);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.4rem;
        }

        .form-input, .form-textarea {
            width: 100%;
            padding: 0.85rem;
            background: #121212;
            border: var(--border-gold);
            color: var(--text-main);
            font-family: 'Courier Prime', monospace;
            font-size: 0.95rem;
            outline: none;
        }

        .form-input:focus, .form-textarea:focus {
            border-color: var(--brass-gold-hover);
            box-shadow: 0 0 10px rgba(197, 160, 89, 0.3);
        }

        .btn-submit {
            display: block;
            width: 100%;
            padding: 0.9rem;
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            color: #0A0A0A;
            font-family: 'Cinzel', serif;
            font-size: 0.95rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 2px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background: linear-gradient(180deg, var(--brass-gold-hover) 0%, var(--brass-gold) 100%);
            transform: translateY(-2px);
        }
    </style>

    <div class="letter-container">
        <div class="letter-card">
            <span class="letter-stamp">Строго лично</span>

            <h1 class="letter-title">Донесение Дону</h1>
            <p style="color: var(--text-muted); font-size: 0.8rem; text-transform: uppercase; margin-bottom: 1.8rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 0.8rem;">
                Зашифрованный канал связи Советника с Главой Семьи
            </p>

            <form action="/counselor/message" method="POST">
                <div class="form-group">
                    <label for="subject" class="form-label">Тема доклада *</label>
                    <input type="text" id="subject" name="subject" class="form-input" placeholder="Например: Аудит верфей Бруклина..." required />
                </div>

                <div class="form-group">
                    <label for="body" class="form-label">Текст послания *</label>
                    <textarea id="body" name="body" rows="6" class="form-textarea" placeholder="Дон, спешу доложить о подозрительных перемещениях людей Дженовезе..." required></textarea>
                </div>

                <button type="submit" class="btn-submit">Опечатать сургучом и отправить</button>
            </form>
        </div>
    </div>

</@layout.page_layout>