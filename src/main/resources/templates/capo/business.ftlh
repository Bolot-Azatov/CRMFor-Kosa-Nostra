<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Контроль Рэкета | Капореджиме" activeTab="racket">

    <style>
        .capo-container {
            max-width: 950px;
            margin: 0 auto;
        }

        .section-title {
            font-family: 'Cinzel', serif;
            font-size: 2rem;
            color: var(--brass-gold);
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 0.4rem;
        }

        .section-sub {
            color: var(--text-muted);
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 2rem;
        }

        .capo-grid {
            display: grid;
            grid-template-columns: 1fr 1.2fr;
            gap: 2rem;
        }

        @media (max-width: 768px) {
            .capo-grid {
                grid-template-columns: 1fr;
            }
        }

        .biz-card {
            background: var(--bg-card);
            border: var(--border-gold);
            padding: 2rem;
            position: relative;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.8);
        }

        .biz-label {
            font-family: 'Cinzel', serif;
            font-size: 0.75rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .biz-value {
            font-size: 1.3rem;
            color: var(--brass-gold);
            font-weight: bold;
            margin-bottom: 1.2rem;
            word-break: break-word;
        }

        /* Интерактивный калькулятор долей */
        .calculator-preview {
            background: #121212;
            border: 1px dashed rgba(197, 160, 89, 0.3);
            padding: 1rem;
            margin: 1.2rem 0;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            text-align: center;
        }

        .calc-box-title {
            font-size: 0.72rem;
            text-transform: uppercase;
            color: var(--text-muted);
        }

        .calc-box-value {
            font-family: 'Cinzel', serif;
            font-size: 1.2rem;
            font-weight: bold;
            margin-top: 0.3rem;
        }

        .form-input, .form-textarea {
            width: 100%;
            padding: 0.8rem;
            background: #121212;
            border: var(--border-gold);
            color: var(--text-main);
            font-family: 'Courier Prime', monospace;
            font-size: 0.95rem;
            outline: none;
            margin-bottom: 1rem;
        }

        .form-input:focus, .form-textarea:focus {
            border-color: var(--brass-gold-hover);
            box-shadow: 0 0 10px rgba(197, 160, 89, 0.25);
        }

        .btn-submit {
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
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background: linear-gradient(180deg, var(--brass-gold-hover) 0%, var(--brass-gold) 100%);
            transform: translateY(-2px);
        }
    </style>

    <div class="capo-container">
        <h1 class="section-title">Кабинет Капореджиме</h1>
        <p class="section-sub">Управление доверенной территорией и сдача еженедельной дани</p>

        <div class="capo-grid">
            <!-- Левая колонка: Карточка Бизнеса -->
            <div class="biz-card">
                <h2 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 1.3rem; margin-bottom: 1.5rem; text-transform: uppercase;">
                    🏛 Закрепленный Бизнес
                </h2>

                <#if business??>
                    <div class="biz-label">Название предприятия:</div>
                    <div class="biz-value">${business.name}</div>

                    <div class="biz-label">Тип рэкета / Отрасль:</div>
                    <div class="biz-value" style="color: var(--text-main);">${business.type}</div>

                    <div class="biz-label">Средненедельный доход:</div>
                    <div class="biz-value">$${business.weeklyRevenue?string[",##0.00"]}</div>

                    <div style="font-size: 0.8rem; color: var(--text-muted); line-height: 1.5; border-top: 1px solid rgba(197,160,89,0.2); padding-top: 1rem;">
                        * По правилам Синдиката, ровно 80% от внесенной дани направляется в общак Семьи, а 20% остается на содержание ваших бойцов.
                    </div>
                <#else>
                    <p style="color: #FF7777;">За вами не закреплено ни одно предприятие. Обратитесь к Дону.</p>
                </#if>
            </div>

            <!-- Правая колонка: Форма сдачи дани -->
            <div class="biz-card">
                <h2 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 1.3rem; margin-bottom: 1.5rem; text-transform: uppercase;">
                    💰 Внести дань в общак
                </h2>

                <form action="/capo/tribute" method="POST" id="tributeForm">

                    <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

                    <label class="biz-label" for="amount">Сумма взноса ($) *</label>
                    <input type="number" step="0.01" min="100.00" name="amount" id="amount" class="form-input" placeholder="Например: 5000" required autofocus />

                    <!-- Интерактивный предпросмотр (JS) -->
                    <div class="calculator-preview">
                        <div>
                            <div class="calc-box-title">В казну (80%):</div>
                            <div class="calc-box-value" id="treasuryShare" style="color: #81C784;">$0.00</div>
                        </div>
                        <div>
                            <div class="calc-box-title">Капо (20%):</div>
                            <div class="calc-box-value" id="capoShare" style="color: var(--brass-gold);">$0.00</div>
                        </div>
                    </div>

                    <label class="biz-label" for="description">Комментарий к переводу</label>
                    <textarea name="description" id="description" rows="3" class="form-textarea" placeholder="Укажите период или статьи расхода..."></textarea>

                    <button type="submit" class="btn-submit">Передать конверт Дона</button>
                </form>
            </div>
        </div>
    </div>

    <!-- JS-обработка событий из темы урока -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const amountInput = document.getElementById('amount');
            const treasuryShareEl = document.getElementById('treasuryShare');
            const capoShareEl = document.getElementById('capoShare');

            // Обработка асинхронного пользовательского ввода через событие 'input'
            amountInput.addEventListener('input', function(event) {
                // event.target — элемент, куда вводится текст
                const rawValue = parseFloat(event.target.value);

                if (isNaN(rawValue) || rawValue <= 0) {
                    treasuryShareEl.innerText = '$0.00';
                    capoShareEl.innerText = '$0.00';
                    return;
                }

                const familyPart = (rawValue * 0.80).toFixed(2);
                const capoPart = (rawValue * 0.20).toFixed(2);

                treasuryShareEl.innerText = '$' + Number(familyPart).toLocaleString();
                capoShareEl.innerText = '$' + Number(capoPart).toLocaleString();
            });
        });
    </script>

</@layout.page_layout>