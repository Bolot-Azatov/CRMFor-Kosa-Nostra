<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Кабинет Дона | Cosa Nostra" activeTab="capos">

    <style>
        .boss-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.25);
        }

        .boss-title {
            font-family: 'Cinzel', serif;
            font-size: 2.2rem;
            color: var(--brass-gold);
            text-transform: uppercase;
            letter-spacing: 3px;
        }

        .treasury-badge {
            background: var(--burgundy-dark);
            border: 2px solid var(--brass-gold);
            padding: 0.8rem 1.6rem;
            text-align: right;
            box-shadow: 0 0 15px rgba(197, 160, 89, 0.2);
        }

        .treasury-title {
            font-family: 'Cinzel', serif;
            font-size: 0.72rem;
            color: var(--text-muted);
            text-transform: uppercase;
        }

        .treasury-sum {
            font-family: 'Cinzel', serif;
            font-size: 1.6rem;
            color: var(--brass-gold);
            font-weight: bold;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 2rem;
            margin-bottom: 2.5rem;
        }

        @media (max-width: 850px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

        .action-card {
            background: var(--bg-card);
            border: var(--border-gold);
            padding: 1.8rem;
            position: relative;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
        }

        .card-heading {
            font-family: 'Cinzel', serif;
            color: var(--brass-gold);
            font-size: 1.15rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 1.2rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.2);
        }

        .form-label {
            font-family: 'Cinzel', serif;
            font-size: 0.75rem;
            color: var(--text-muted);
            text-transform: uppercase;
            display: block;
            margin-bottom: 0.3rem;
        }

        .form-input, .form-select {
            width: 100%;
            padding: 0.75rem;
            background: #121212;
            border: var(--border-gold);
            color: var(--text-main);
            font-family: 'Courier Prime', monospace;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            outline: none;
        }

        .form-input:focus, .form-select:focus {
            border-color: var(--brass-gold-hover);
        }

        .btn-gold {
            width: 100%;
            padding: 0.85rem;
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            color: #0A0A0A;
            font-family: 'Cinzel', serif;
            font-size: 0.85rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-gold:hover {
            background: linear-gradient(180deg, var(--brass-gold-hover) 0%, var(--brass-gold) 100%);
            transform: translateY(-2px);
        }

        .btn-danger {
            background: linear-gradient(180deg, #6B1310 0%, #3D0C02 100%);
            color: #FFD2D2;
            border: 1px solid #FF5555;
        }

        .btn-danger:hover {
            background: #8B1A16;
            color: #FFFFFF;
        }

        .nav-tabs-bar {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .nav-tab-link {
            padding: 0.6rem 1.2rem;
            background: var(--bg-card);
            border: var(--border-gold);
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
            font-size: 0.8rem;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.2s;
        }

        .nav-tab-link:hover {
            background: var(--burgundy-dark);
            color: var(--brass-gold-hover);
        }
    </style>

    <div class="boss-header">
        <div>
            <h1 class="boss-title">Кабинет Дона</h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">
                Семья ${(family.name)!'Cosa Nostra'} • Верховное командование
            </p>
        </div>
        <div class="treasury-badge">
            <div class="treasury-title">Казначейство (Общак)</div>
            <div class="treasury-sum">$${(family.treasuryBalance?string[",##0.00"])!'0.00'}</div>
        </div>
    </div>

    <div class="nav-tabs-bar">
        <a href="/boss/businesses" class="nav-tab-link">🏛 Бизнесы Семьи</a>
        <a href="/boss/ledger" class="nav-tab-link">📜 Журнал Доходов</a>
    </div>

    <div class="dashboard-grid">

        <!-- 1. Инвестиции из Общака -->
        <div class="action-card">
            <h2 class="card-heading">💰 Инвестиция из Казны</h2>
            <form action="/boss/treasury/invest" method="POST">
                <label class="form-label" for="amount">Сумма инвестиции ($) *</label>
                <input type="number" step="0.01" min="0.01" name="amount" id="amount" class="form-input" placeholder="Например: 10000" required />

                <label class="form-label" for="description">Цель финансирования *</label>
                <input type="text" name="description" id="description" class="form-input" placeholder="Подкуп сенатора / Оружие" required />

                <button type="submit" class="btn-gold">Выделить средства</button>
            </form>
        </div>

        <!-- 2. Кадровый учет (Назначение ролей) -->
        <div class="action-card">
            <h2 class="card-heading">🎖 Назначение ранга</h2>
            <form action="/boss/members/assign-role" method="POST">
                <label class="form-label" for="userId">ID Участника семьи *</label>
                <input type="number" name="userId" id="userId" class="form-input" placeholder="Идентификатор бойца" required />

                <label class="form-label" for="newRole">Присвоить звание *</label>
                <select name="newRole" id="newRole" class="form-select" required>
                    <option value="SOLDIER">Солдат (Soldier)</option>
                    <option value="CAPO">Капореджиме (Capo)</option>
                    <option value="CONSIGLIERE">Консильери (Советник)</option>
                </select>

                <button type="submit" class="btn-gold">Утвердить приказ</button>
            </form>
        </div>

        <!-- 3. Внешняя Политика: Объявление войны -->
        <div class="action-card">
            <h2 class="card-heading" style="color: #FF7777;">🗡 Объявить войну</h2>
            <form action="/boss/diplomacy/declare-war" method="POST" id="warForm">
                <label class="form-label" for="warTarget">ID Враждебной Семьи *</label>
                <input type="number" name="targetFamilyId" id="warTarget" class="form-input" placeholder="Например: 2 (Genovese)" required />

                <button type="submit" class="btn-gold btn-danger">Начать войну за территорию</button>
            </form>
        </div>

        <!-- 4. Дипломатия: Предложение мира -->
        <div class="action-card">
            <h2 class="card-heading">🕊 Перемирие</h2>
            <form action="/boss/diplomacy/propose-peace" method="POST">
                <label class="form-label" for="peaceTarget">ID Семьи для договора *</label>
                <input type="number" name="targetFamilyId" id="peaceTarget" class="form-input" placeholder="Например: 4 (Bonanno)" required />

                <button type="submit" class="btn-gold">Направить посланца с миром</button>
            </form>
        </div>

    </div>

    <!-- JS-перехват отправки формы (preventDefault из раздатки) для подтверждения опасного действия -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const warForm = document.getElementById('warForm');

            warForm.addEventListener('submit', function(event) {
                const confirmed = confirm("Вы уверены, Дон? Объявление войны приведет к неизбежным потерям солдат и прибыли.");
                if (!confirmed) {
                    // Отменяем отправку формы в браузер
                    event.preventDefault();
                }
            });
        });
    </script>

</@layout.page_layout>