<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Синдикат 1950 | Главная" activeTab="">

    <style>
        .hero-banner {
            text-align: center;
            padding: 3rem 1rem 2rem 1rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.25);
            margin-bottom: 2.5rem;
        }

        .hero-title {
            font-family: 'Cinzel', serif;
            font-size: 3rem;
            font-weight: 900;
            color: var(--brass-gold);
            letter-spacing: 4px;
            text-transform: uppercase;
            text-shadow: 0 2px 12px rgba(0, 0, 0, 0.9);
            margin-bottom: 0.5rem;
        }

        .hero-subtitle {
            font-size: 1rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 2px;
            max-width: 650px;
            margin: 0 auto;
        }

        .columns-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 3rem;
        }

        @media (max-width: 768px) {
            .columns-grid {
                grid-template-columns: 1fr;
            }
        }

        .speakeasy-panel {
            background-color: var(--bg-card);
            border: var(--border-gold);
            padding: 2rem;
            position: relative;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.7);
        }

        .speakeasy-panel::before, .speakeasy-panel::after {
            content: '';
            position: absolute;
            width: 12px;
            height: 12px;
            border: 2px solid var(--brass-gold);
        }
        .speakeasy-panel::before { top: 6px; left: 6px; border-right: none; border-bottom: none; }
        .speakeasy-panel::after { bottom: 6px; right: 6px; border-left: none; border-top: none; }

        .panel-title {
            font-family: 'Cinzel', serif;
            color: var(--brass-gold);
            font-size: 1.4rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            border-bottom: 1px solid rgba(197, 160, 89, 0.2);
            padding-bottom: 0.8rem;
            margin-bottom: 1.2rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .text-paragraph {
            line-height: 1.7;
            font-size: 0.92rem;
            color: var(--text-main);
            margin-bottom: 1.2rem;
        }

        .omerta-list {
            list-style: none;
            padding: 0;
        }

        .omerta-item {
            padding: 0.8rem 0;
            border-bottom: 1px dashed rgba(197, 160, 89, 0.2);
            font-size: 0.88rem;
            display: flex;
            gap: 12px;
        }

        .omerta-item span {
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
            font-weight: bold;
        }

        .btn-gold {
            display: inline-block;
            padding: 0.8rem 1.6rem;
            font-family: 'Cinzel', serif;
            font-size: 0.9rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            color: #0A0A0A;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-gold:hover {
            background: linear-gradient(180deg, var(--brass-gold-hover) 0%, var(--brass-gold) 100%);
            box-shadow: 0 0 15px rgba(197, 160, 89, 0.4);
            transform: translateY(-2px);
        }
    </style>

    <div class="hero-banner">
        <h1 class="hero-title">Пять Семей Нью-Йорка</h1>
        <p class="hero-subtitle">Комиссия 1931 года • Закон Омерты • Тайная империя Синдиката</p>
    </div>

    <div class="columns-grid">
        <!-- Левая колонка: История -->
        <div class="speakeasy-panel">
            <h2 class="panel-title">⚖ Создание Комиссии (1931)</h2>
            <p class="text-paragraph">
                После кровопролитной Кастелламмарской войны Чарльз «Лаки» Лучано упразднил титул <em>Capo di tutti i capi</em> («Босса всех боссов»), создав коллегиальный орган — <strong>Комиссию</strong>. Нью-Йорк был поделён между Пятью Семьями: Гамбино, Дженовезе, Луккезе, Бонанно и Коломбо.
            </p>
            <p class="text-paragraph">
                Настоящая система CRM представляет собой цифровой эквивалент бухгалтерских книг и дипломатических каналов 1950-х годов: от учета дани с бруклинских доков до негласных мирных договоров между кланами.
            </p>
            <div style="margin-top: 1.8rem;">
                <a href="/articles" class="btn-gold">Архив сводок и статей →</a>
            </div>
        </div>

        <!-- Правая колонка: Омерта -->
        <div class="speakeasy-panel">
            <h2 class="panel-title">📜 Кодекс Омерты</h2>
            <ul class="omerta-list">
                <li class="omerta-item">
                    <span>I.</span>
                    <div>Никто не может представиться нашему другу сам. Нас должен познакомить третий.</div>
                </li>
                <li class="omerta-item">
                    <span>II.</span>
                    <div>Никогда не смотрите на жен друзей. Уважение семьи превыше соблазнов.</div>
                </li>
                <li class="omerta-item">
                    <span>III.</span>
                    <div>Капо и Дон всегда получают 80% от дохода в установленный срок.</div>
                </li>
                <li class="omerta-item">
                    <span>IV.</span>
                    <div>Слово чести — единственный нерушимый контракт. Предательство карается забвением.</div>
                </li>
            </ul>
        </div>
    </div>

</@layout.page_layout>