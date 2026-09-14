<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('boss.treasury.subtitle')} | ${springMacroRequestContext.getMessage('role.boss.badge')}" activeTab="racket">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text"><@spring.message "boss.dashboard.recent_operations"/></h1>
            <p class="subtitle-text"><@spring.message "boss.treasury.subtitle"/></p>
        </div>
        <a href="/boss" style="font-family: var(--font-heading);"><@spring.message "boss.back_to_hq"/></a>
    </div>

    <#if ledger?? && ledger?has_content>
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
                <#list ledger as item>
                    <tr>
                        <td>#${item.id}</td>
                        <td style="color: var(--brass-gold);">${(item.capo.username)!springMacroRequestContext.getMessage('family.other.family_prefix')}</td>
                        <td>
                            <#if (item.amount >= 0)>
                                <span class="amount-positive">+$${item.amount?string[",##0.00"]}</span>
                            <#else>
                                <span class="amount-negative">-$${(-item.amount)?string[",##0.00"]}</span>
                            </#if>
                        </td>
                        <td>${item.contributedAt}</td>
                        <td style="color: var(--text-muted);">${item.description!"-"}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    <#else>
        <div style="text-align: center; padding: 3rem; background: var(--bg-card); border: var(--border-gold);">
            <p style="color: var(--text-muted);"><@spring.message "boss.treasury.empty"/></p>
        </div>
    </#if>

</@layout.page_layout>