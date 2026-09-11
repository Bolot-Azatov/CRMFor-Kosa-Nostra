<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Сдача Выручки (Tribute) | Cosa Nostra" activeTab="racket">

    <style>
        .tribute-container {
            max-width: 680px;
            margin: 0 auto;
        }

        /* Карточка в стиле банковского чека / расписки 1950-х годов */
        .tribute-card {
            background: var(--bg-card);
            border: var(--border-gold);
            padding: 2.8rem 2.2rem;
            position: relative;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.9), inset 0 0 20px rgba(61, 12, 2, 0.4);
        }

        /* Декоративные латунные уголки */
        .tribute-card::before, .tribute-card::after {
            content: '';
            position: absolute;
            width: 14px;
            height: 14px;
            border: 2px solid var(--brass-gold);
        }
        .tribute-card::before { top: 8px; left: 8px; border-right: none; border-bottom: none; }
        .tribute-card::after { bottom: 8px; right: 8px; border-left: none; border-top: none; }

        /* Печать бухгалтерского ордера */
        .deposit-stamp {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            border: 2px dashed var(--brass-gold);
            color: var(--brass-gold);
            padding: 0.3rem 0.8rem;
            font-family: 'Cinzel', serif;
            font-size: 0.72rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            transform: rotate(3deg);
            opacity: 0.85;
        }

        .tribute-title {
            font-family: 'Cinzel', serif;
            font-size: 2rem;
            font-weight: 800;
            color: var(--brass-gold);
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 0.4rem;
        }

        .tribute-subtitle {
            color: var(--text-muted);
            font-size: 0.82rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 2rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.2);
            padding-bottom: 0.8rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
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
            padding: 0.85rem 1rem;
            background-color: #121212;
            border: var(--border-gold);
            color: var(--text-main);
            font-family: 'Courier Prime', monospace;
            font-size: 0.95rem;
            outline: none;
            transition: all 0.3s ease;
        }

        .form-input:focus, .form-textarea:focus {
            border-color: var(--brass-gold-hover);
            box-shadow: 0 0 10px rgba(197, 160, 89, 0.3);
            background-color: #161616;
        }

        /* Интерактивный калькулятор долей на JS */
        .ledger-preview {
            background: #121212;
            border: 1px dashed rgba(197, 160, 89, 0.35);
            padding: 1.2rem;
            margin: 1.5rem 0;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.2rem;
            text-align: center;
        }

        .preview-box-title {
            font-size: 0.72rem;
            text-transform: uppercase;
            color: var(--text-muted);
            letter-spacing: 1px;
        }

        .preview-box-value {
            font-family: 'Cinzel', serif;
            font-size: 1.4rem;
            font-weight: bold;
            margin-top: 0.4rem;
        }

        .notice-box {
            font-size: 0.8rem;
            color: var(--text-muted);
            line-height: 1.6;
            border-left: 2px solid var(--brass-gold);
            padding-left: 1rem;
            margin-bottom: 1.5rem;
        }

        .btn-submit {
            display: block;
            width: 100%;
            padding: 0.95rem;
            font-family: 'Cinzel', serif;
            font-size: 0.95rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: #0A0A0A;
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background: linear-gradient(180deg, var(--brass-gold-hover) 0%, var(--brass-gold) 100%);
            box-shadow: 0 0 15px rgba(197, 160, 89, 0.4);
            transform: translateY(-2px);
        }

        .back-link {
            display: inline-block;
            margin-top: 1.5rem;
            color: var(--brass-gold);
            text-decoration: none;
            font-family: 'Cinzel', serif;
            font-size: 0.82rem;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .back-link:hover {
            color: var(--brass-gold-hover);
            text-decoration: underline;
        }
    </style>

    <div class="tribute-container">

        <div class="tribute-card">
            <span class="deposit-stamp">Ордер №80/20</span>

            <h1 class="tribute-title">Взнос Дани</h1>
            <p class="tribute-subtitle">Регламентная сдача недельной выручки с рэкета в Казну Семьи</p>

            <div class="notice-box">
                <strong>Закон Семьи:</strong> Минимальный взнос составляет <strong>$100.00</strong>. Ровно <strong>80%</strong> от указанной суммы безвозвратно поступает в Общак Дона, а <strong>20%</strong> остаётся в фонде вашего режима.
            </div>

            <form action="/capo/tribute" method="POST" id="tributeForm">

                <!-- Поле суммы -->
                <div class="form-group">
                    <label for="amountInput" class="form-label">Сумма к сдаче ($) *</label>
                    <input
                            type="number"
                            step="0.01"
                            min="100.00"
                            id="amountInput"
                            name="amount"
                            class="form-input"
                            placeholder="1000.00"
                            required
                            autofocus
                    />
                </div>

                <!-- Блок расчёта долей (JS динамика) -->
                <div class="ledger-preview">
                    <div>
                        <div class="preview-box-title">В Казну Семьи (80%)</div>
                        <div class="preview-box-value" id="treasuryPreview" style="color: #81C784;">$0.00</div>
                    </div>
                    <div>
                        <div class="preview-box-title">Доля Капо (20%)</div>
                        <div class="preview-box-value" id="capoPreview" style="color: var(--brass-gold);">$0.00</div>
                    </div>
                </div>

                <!-- Комментарий / Назначение -->
                <div class="form-group">
                    <label for="description" class="form-label">Пояснительная записка / Источник</label>
                    <textarea
                            id="description"
                            name="description"
                            rows="3"
                            class="form-textarea"
                            placeholder="Например: Выручка от портовых доков за первую неделю сентября..."
                    ></textarea>
                </div>

                <button type="submit" class="btn-submit" id="submitBtn">Скрепить и передать в Казначейство</button>

            </form>

            <a href="/capo/business" class="back-link">← Вернуться к карточке бизнеса</a>
        </div>

    </div>

    <!-- Подключаем JavaScript для закрепления темы асинхронности и событий -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const amountInput = document.getElementById('amountInput');
            const treasuryPreview = document.getElementById('treasuryPreview');
            const capoPreview = document.getElementById('capoPreview');
            const tributeForm = document.getElementById('tributeForm');

            // 1. Событие 'input' — слушаем ввод каждого символа
            amountInput.addEventListener('input', function(event) {
                // event.target — поле ввода суммы
                const raw = parseFloat(event.target.value);

                if (isNaN(raw) || raw <= 0) {
                    treasuryPreview.innerText = '$0.00';
                    capoPreview.innerText = '$0.00';
                    return;
                }

                // Математика 80% / 20%
                const treasuryPart = (raw * 0.80).toFixed(2);
                const capoPart = (raw * 0.20).toFixed(2);

                // Форматирование с разделителями тысяч
                treasuryPreview.innerText = '$' + Number(treasuryPart).toLocaleString(undefined, {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                });
                capoPreview.innerText = '$' + Number(capoPart).toLocaleString(undefined, {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                });
            });

            // 2. Метод event.preventDefault() — подтверждение отправки
            tributeForm.addEventListener('submit', function(event) {
                const val = parseFloat(amountInput.value);
                if (val < 100) {
                    alert("Минимальный взнос по кодексу — $100.00!");
                    event.preventDefault(); // Отменяем отправку формы
                    return;
                }

                const confirmed = confirm("Вы собираетесь перечислить в общак Семьи $" + (val * 0.80).toFixed(2) + ". Подтверждаете?");
                if (!confirmed) {
                    event.preventDefault(); // Отменяем сабмит, если Капо нажал 'Отмена'
                }
            });
        });
    </script>

</@layout.page_layout>