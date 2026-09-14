<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('boss.dashboard.title')} | Cosa Nostra" activeTab="dashboard">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text"><@spring.message "boss.dashboard.title"/></h1>
            <p class="subtitle-text">
                <@spring.message "family.other.family_prefix"/> ${(family.name)!'Cosa Nostra'} • <@spring.message "boss.dashboard.subtitle"/>
            </p>
        </div>
    </div>

    <!-- Ключевые показатели семьи -->
    <div class="stats-grid">
        <div class="stat-card" style="border-color: var(--brass-gold);">
            <div class="stat-label"><@spring.message "boss.dashboard.treasury"/></div>
            <div class="stat-value">$${(family.treasuryBalance?string[",##0.00"])!'0.00'}</div>
            <a href="/boss/treasury" style="font-size: 0.75rem;"><@spring.message "boss.dashboard.manage_treasury"/></a>
        </div>
        <div class="stat-card">
            <div class="stat-label"><@spring.message "boss.dashboard.sworn_members"/></div>
            <div class="stat-value">${membersCount!0}</div>
            <a href="/boss/members" style="font-size: 0.75rem;"><@spring.message "boss.dashboard.personnel_records"/></a>
        </div>
        <div class="stat-card">
            <div class="stat-label"><@spring.message "boss.dashboard.controlled_rackets"/></div>
            <div class="stat-value">${businessesCount!0}</div>
            <a href="/boss/businesses" style="font-size: 0.75rem;"><@spring.message "boss.dashboard.businesses"/></a>
        </div>
    </div>

    <!-- Быстрая навигация Дона -->
    <div class="quick-nav-grid">
        <a href="/boss/members" class="quick-btn">
            <h3>🎖 <@spring.message "boss.dashboard.nav.members.title"/></h3>
            <p><@spring.message "boss.dashboard.nav.members.desc"/></p>
        </a>
        <a href="/boss/businesses" class="quick-btn">
            <h3>🏛 <@spring.message "boss.dashboard.nav.businesses.title"/></h3>
            <p><@spring.message "boss.dashboard.nav.businesses.desc"/></p>
        </a>
        <a href="/boss/treasury" class="quick-btn">
            <h3>💰 <@spring.message "boss.dashboard.nav.treasury.title"/></h3>
            <p><@spring.message "boss.dashboard.nav.treasury.desc"/></p>
        </a>
        <a href="/boss/diplomacy" class="quick-btn">
            <h3>🕊 <@spring.message "boss.dashboard.nav.diplomacy.title"/></h3>
            <p><@spring.message "boss.dashboard.nav.diplomacy.desc"/></p>
        </a>
        <a href="/boss/messages" class="quick-btn">
            <h3>✉ <@spring.message "boss.dashboard.nav.messages.title"/></h3>
            <p><@spring.message "boss.dashboard.nav.messages.desc"/></p>
        </a>
    </div>

    <!-- Последние транзакции общака -->
    <h2 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.3rem; margin-bottom: 1rem; text-transform: uppercase;">
        📜 <@spring.message "boss.dashboard.recent_operations"/>
    </h2>

    <#if recentLedger?? && recentLedger?has_content>
        <div class="table-responsive">
            <table class="speakeasy-table">
                <thead>
                <tr>
                    <th><@spring.message "boss.treasury.table.id"/></th>
                    <th><@spring.message "boss.treasury.table.initiator"/></th>
                    <th><@spring.message "boss.treasury.table.amount"/></th>
                    <th><@spring.message "boss.treasury.table.date"/></th>
                    <th><@spring.message "boss.treasury.table.description"/></th>
                </tr>
                </thead>
                <tbody>
                <#list recentLedger as item>
                    <tr>
                        <td>#${item.id}</td>
                        <td style="color: var(--brass-gold); font-weight: bold;">${(item.capo.username)!springMacroRequestContext.getMessage('user.anonymous')}</td>
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
        <p style="color: var(--text-muted);"><@spring.message "boss.dashboard.no_transactions"/></p>
    </#if>

</@layout.page_layout>