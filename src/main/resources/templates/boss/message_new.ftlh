<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Депеша Дона | Почта" activeTab="dossiers">

    <style>
        .card-box {
            max-width: 650px;
            margin: 0 auto;
            background: var(--bg-card);
            border: var(--border-gold);
            padding: 2.5rem;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.8);
        }

        .title {
            font-family: 'Cinzel', serif;
            font-size: 1.8rem;
            color: var(--brass-gold);
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

        .btn-gold {
            width: 100%;
            padding: 0.9rem;
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            color: #0A0A0A;
            font-family: 'Cinzel', serif;
            font-size: 0.95rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            border: none;
            cursor: pointer;
        }
    </style>

    <div class="card-box">
        <h1 class="title">Приказ / Депеша Дона</h1>
        <p style="color: var(--text-muted); font-size: 0.8rem; text-transform: uppercase; margin-bottom: 1.5rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 0.8rem;">
            Отправка распоряжений своим Капо, Консильери или Боссам других семей
        </p>

        <form action="/boss/messages" method="POST">
            <div class="form-group">
                <label class="form-label" for="recipientId">ID Получателя *</label>
                <input type="number" id="recipientId" name="recipientId" class="form-input" placeholder="Идентификатор адресата" required />
            </div>

            <div class="form-group">
                <label class="form-label" for="subject">Тема распоряжения *</label>
                <input type="text" id="subject" name="subject" class="form-input" placeholder="Срочный сбор в Гарлеме" required />
            </div>

            <div class="form-group">
                <label class="form-label" for="body">Текст приказа *</label>
                <textarea id="body" name="body" rows="5" class="form-textarea" placeholder="Изложите суть распоряжения..." required></textarea>
            </div>

            <button type="submit" class="btn-gold">Скрепить печатью и отправить</button>
        </form>
    </div>

</@layout.page_layout>