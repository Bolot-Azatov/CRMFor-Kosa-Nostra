<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Синдикат 1950 | Главная" activeTab="home">

    <!-- Главный баннер -->
    <div style="text-align: center; padding: 2.5rem 1rem 2rem 1rem; border-bottom: 1px solid rgba(197, 160, 89, 0.25); margin-bottom: 2.5rem;">
        <h1 style="font-family: var(--font-heading); font-size: clamp(1.8rem, 5vw, 3rem); font-weight: 900; color: var(--brass-gold); letter-spacing: 3px; text-transform: uppercase; text-shadow: 0 2px 12px rgba(0, 0, 0, 0.9); margin-bottom: 0.5rem;">
            Пять Семей Нью-Йорка
        </h1>
        <p style="font-size: 0.95rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 2px; max-width: 650px; margin: 0 auto;">
            Комиссия 1931 года • Закон Омерты • Тайная империя Синдиката
        </p>
    </div>

    <!-- Сетка из двух информационных блоков -->
    <div class="columns-grid" style="display: grid; grid-template-columns: 2fr 1fr; gap: 2rem; margin-bottom: 3rem;">
        <!-- Левая колонка: История -->
        <div style="background-color: var(--bg-card); border: var(--border-gold); padding: 2rem; position: relative; box-shadow: var(--box-shadow-card);">
            <h2 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.3rem; text-transform: uppercase; letter-spacing: 2px; border-bottom: 1px solid rgba(197, 160, 89, 0.2); padding-bottom: 0.8rem; margin-bottom: 1.2rem;">
                ⚖ Создание Комиссии (1931)
            </h2>
            <p style="line-height: 1.8; font-size: 0.92rem; color: var(--text-main); margin-bottom: 1rem;">
                После кровопролитной Кастелламмарской войны Чарльз «Лаки» Лучано упразднил титул <em>Capo di tutti i capi</em> («Босса всех боссов»), создав коллегиальный орган — <strong>Комиссию</strong>. Нью-Йорк был поделён между Пятью Семьями: Гамбино, Дженовезе, Луккезе, Бонанно и Коломбо.
            </p>
            <p style="line-height: 1.8; font-size: 0.92rem; color: var(--text-main); margin-bottom: 1.8rem;">
                Настоящая система CRM представляет собой цифровой эквивалент бухгалтерских книг и дипломатических каналов 1950-х годов: от учета дани с бруклинских доков до негласных мирных договоров между кланами.
            </p>
            <div>
                <a href="/articles" class="btn-gold" style="display: inline-block; width: auto; padding: 0.8rem 1.6rem;">Архив сводок и статей →</a>
            </div>
        </div>

        <!-- Правая колонка: Омерта -->
        <div style="background-color: var(--bg-card); border: var(--border-gold); padding: 2rem; position: relative; box-shadow: var(--box-shadow-card);">
            <h2 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.3rem; text-transform: uppercase; letter-spacing: 2px; border-bottom: 1px solid rgba(197, 160, 89, 0.2); padding-bottom: 0.8rem; margin-bottom: 1.2rem;">
                📜 Кодекс Омерты
            </h2>
            <ul style="list-style: none; padding: 0;">
                <li style="padding: 0.8rem 0; border-bottom: 1px dashed rgba(197, 160, 89, 0.2); font-size: 0.88rem; display: flex; gap: 12px;">
                    <span style="color: var(--brass-gold); font-family: var(--font-heading); font-weight: bold;">I.</span>
                    <div>Никто не может представиться нашему другу сам. Нас должен познакомить третий.</div>
                </li>
                <li style="padding: 0.8rem 0; border-bottom: 1px dashed rgba(197, 160, 89, 0.2); font-size: 0.88rem; display: flex; gap: 12px;">
                    <span style="color: var(--brass-gold); font-family: var(--font-heading); font-weight: bold;">II.</span>
                    <div>Никогда не смотрите на жен друзей. Уважение семьи превыше соблазнов.</div>
                </li>
                <li style="padding: 0.8rem 0; border-bottom: 1px dashed rgba(197, 160, 89, 0.2); font-size: 0.88rem; display: flex; gap: 12px;">
                    <span style="color: var(--brass-gold); font-family: var(--font-heading); font-weight: bold;">III.</span>
                    <div>Капо и Дон всегда получают 80% от дохода в установленный срок.</div>
                </li>
                <li style="padding: 0.8rem 0; font-size: 0.88rem; display: flex; gap: 12px;">
                    <span style="color: var(--brass-gold); font-family: var(--font-heading); font-weight: bold;">IV.</span>
                    <div>Слово чести — единственный нерушимый контракт. Предательство карается забвением.</div>
                </li>
            </ul>
        </div>
    </div>

</@layout.page_layout>