<!-- src/main/resources/templates/boss/dashboard.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Кабинет Дона | Cosa Nostra" activeTab="dashboard">

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
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }
        @media (max-width: 768px) {
            .stats-grid { grid-template-columns: 1fr; }
        }
        .stat-card {
            background: var(--bg-card);
            border: var(--border-gold);
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.8);
        }
        .stat-value {
            font-family: 'Cinzel', serif;
            font-size: 2rem;
            color: var(--brass-gold);
            font-weight: bold;
            margin: 0.5rem 0;
        }
        .stat-label {
            font-size: 0.8rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .quick-nav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.2rem;
            margin-bottom: 2.5rem;
        }
        .quick-btn {
            background: #161616;
            border: var(--border-gold);
            padding: 1.2rem;
            text-align: center;
            text-decoration: none;
            color: var(--text-main);
            transition: all 0.3s ease;
            display: block;
        }
        .quick-btn:hover {
            background: var(--burgundy-dark);
            border-color: var(--brass-gold);
            transform: translateY(-2px);
        }
        .quick-btn h3 {
            font-family: 'Cinzel', serif;
            color: var(--brass-gold);
            font-size: 1rem;
            margin-bottom: 0.4rem;
            text-transform: uppercase;
        }
        .quick-btn p {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin: 0;
        }
    </style>

    <div class="boss-header">
        <div>
            <h1 class="boss-title">Ставка Дона</h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">
                Семья ${(family.name)!'Cosa Nostra'} • Сводная оперативная сводка
            </p>
        </div>
    </div>

    <!-- Блок ключевых показателей семьи -->
    <div class="stats-grid">
        <div class="stat-card" style="border-color: var(--brass-gold);">
            <div class="stat-label">Казначейство (Общак)</div>
            <div class="stat-value">$${(family.treasuryBalance?string[",##0.00"])!'0.00'}</div>
            <a href="/boss/treasury" style="color: var(--brass-gold); font-size: 0.75rem; text-decoration: none;">Управление казной →</a>
        </div>
        <div class="stat-card">
            <div class="stat-label">Бойцов под присягой</div>
            <div class="stat-value">${membersCount!0}</div>
            <a href="/boss/members" style="color: var(--brass-gold); font-size: 0.75rem; text-decoration: none;">Кадровый учет →</a>
        </div>
        <div class="stat-card">
            <div class="stat-label">Контролируемый рэкет</div>
            <div class="stat-value">${businessesCount!0}</div>
            <a href="/boss/businesses" style="color: var(--brass-gold); font-size: 0.75rem; text-decoration: none;">Предприятия →</a>
        </div>
    </div>

    <!-- Быстрая навигация по министерствам Дона -->
    <div class="quick-nav-grid">
        <a href="/boss/members" class="quick-btn">
            <h3>🎖 Личный состав</h3>
            <p>Назначение Капо и Консильери</p>
        </a>
        <a href="/boss/businesses" class="quick-btn">
            <h3>🏛 Предприятия</h3>
            <p>Закрепление точек за Капо</p>
        </a>
        <a href="/boss/treasury" class="quick-btn">
            <h3>💰 Инвестиции</h3>
            <p>Списание средств из общака</p>
        </a>
        <a href="/boss/diplomacy" class="quick-btn">
            <h3>🕊 Дипломатия</h3>
            <p>Отношения с 4 семьями</p>
        </a>
        <a href="/boss/messages" class="quick-btn">
            <h3>✉ Тайная Почта</h3>
            <p>Депеши и переписка Дона</p>
        </a>
    </div>

    <!-- Последние транзакции общака -->
    <h2 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 1.3rem; margin-bottom: 1rem; text-transform: uppercase;">
        📜 Последние операции казны
    </h2>
    <#if recentLedger?? && recentLedger?has_content>
        <table style="width: 100%; border-collapse: collapse; background: var(--bg-card); border: var(--border-gold);">
            <thead>
            <tr style="background: var(--burgundy-dark); color: var(--brass-gold); font-family: 'Cinzel', serif; text-align: left;">
                <th style="padding: 0.8rem;">ID</th>
                <th style="padding: 0.8rem;">Инициатор</th>
                <th style="padding: 0.8rem;">Сумма</th>
                <th style="padding: 0.8rem;">Дата</th>
                <th style="padding: 0.8rem;">Назначение</th>
            </tr>
            </thead>
            <tbody>
            <#list recentLedger as item>
                <tr style="border-bottom: 1px solid rgba(197,160,89,0.15);">
                    <td style="padding: 0.8rem;">#${item.id}</td>
                    <td style="padding: 0.8rem; color: var(--brass-gold); font-weight: bold;">${(item.capo.username)!'Семья'}</td>
                    <td style="padding: 0.8rem; font-family: 'Cinzel', serif; font-weight: bold;">
                        <#if (item.amount >= 0)>
                            <span style="color: #81C784;">+$${item.amount?string[",##0.00"]}</span>
                        <#else>
                            <span style="color: #FF7777;">-$${(-item.amount)?string[",##0.00"]}</span>
                        </#if>
                    </td>
                    <td style="padding: 0.8rem; color: var(--text-muted); font-size: 0.85rem;">${item.contributedAt}</td>
                    <td style="padding: 0.8rem; color: var(--text-main); font-size: 0.85rem;">${item.description!"-"}</td>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <p style="color: var(--text-muted);">Транзакций пока нет.</p>
    </#if>

</@layout.page_layout>