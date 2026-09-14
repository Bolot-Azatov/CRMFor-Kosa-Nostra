<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Кабинет Дона | Cosa Nostra" activeTab="dashboard">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text">Ставка Дона</h1>
            <p class="subtitle-text">
                Семья ${(family.name)!'Cosa Nostra'} • Сводная оперативная сводка
            </p>
        </div>
    </div>

    <!-- Ключевые показатели семьи -->
    <div class="stats-grid">
        <div class="stat-card" style="border-color: var(--brass-gold);">
            <div class="stat-label">Казначейство (Общак)</div>
            <div class="stat-value">$${(family.treasuryBalance?string[",##0.00"])!'0.00'}</div>
            <a href="/boss/treasury" style="font-size: 0.75rem;">Управление казной →</a>
        </div>
        <div class="stat-card">
            <div class="stat-label">Бойцов под присягой</div>
            <div class="stat-value">${membersCount!0}</div>
            <a href="/boss/members" style="font-size: 0.75rem;">Кадровый учет →</a>
        </div>
        <div class="stat-card">
            <div class="stat-label">Контролируемый рэкет</div>
            <div class="stat-value">${businessesCount!0}</div>
            <a href="/boss/businesses" style="font-size: 0.75rem;">Предприятия →</a>
        </div>
    </div>

    <!-- Быстрая навигация Дона -->
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
    <h2 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.3rem; margin-bottom: 1rem; text-transform: uppercase;">
        📜 Последние операции казны
    </h2>

    <#if recentLedger?? && recentLedger?has_content>
        <div class="table-responsive">
            <table class="speakeasy-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Инициатор</th>
                    <th>Сумма</th>
                    <th>Дата</th>
                    <th>Назначение</th>
                </tr>
                </thead>
                <tbody>
                <#list recentLedger as item>
                    <tr>
                        <td>#${item.id}</td>
                        <td style="color: var(--brass-gold); font-weight: bold;">${(item.capo.username)!'Семья'}</td>
                        <td>
                            <#if (item.amount >= 0)>
                                <span class="amount-positive">+$${item.amount?string[",##0.00"]}</span>
                            <#else>
                                <span class="amount-negative">-$${(-item.amount)?string[",##0.00"]}</span>
                            </#if>
                        </td>
                        <td style="color: var(--text-muted); font-size: 0.85rem;">${item.contributedAt}</td>
                        <td style="font-size: 0.85rem;">${item.description!"-"}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    <#else>
        <p style="color: var(--text-muted);">Транзакций пока нет.</p>
    </#if>

</@layout.page_layout>