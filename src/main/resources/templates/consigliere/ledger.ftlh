<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('consigliere.ledger.title')} | ${springMacroRequestContext.getMessage('role.consigliere.title')}" activeTab="ledger">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text"><@spring.message "consigliere.ledger.title"/></h1>
            <p class="subtitle-text"><@spring.message "consigliere.ledger.subtitle"/></p>
        </div>
        <a href="/consigliere/messages/new" class="btn-gold" style="width: auto; padding: 0.7rem 1.4rem;">
            ✉ <@spring.message "consigliere.ledger.btn_report"/>
        </a>
    </div>

    <#if ledger?? && ledger?has_content>
        <div class="table-responsive">
            <table class="speakeasy-table">
                <thead>
                <tr>
                    <th><@spring.message "consigliere.ledger.table.id"/></th>
                    <th><@spring.message "consigliere.ledger.table.capo"/></th>
                    <th><@spring.message "consigliere.ledger.table.amount"/></th>
                    <th><@spring.message "consigliere.ledger.table.datetime"/></th>
                    <th><@spring.message "consigliere.ledger.table.description"/></th>
                </tr>
                </thead>
                <tbody>
                <#list ledger as item>
                    <tr>
                        <td>#${item.id}</td>
                        <td style="color: var(--brass-gold); font-weight: bold;">${item.capoUsername}</td>
                        <td>
                            <#if (item.amount >= 0)>
                                <span class="amount-positive">+$${item.amount?string[",##0.00"]}</span>
                            <#else>
                                <span class="amount-negative">-$${(-item.amount)?string[",##0.00"]}</span>
                            </#if>
                        </td>
                        <td>${item.contributedAt}</td>
                        <td style="color: var(--text-muted);">${(item.description)!springMacroRequestContext.getMessage("consigliere.ledger.default_desc")}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    <#else>
        <div style="text-align: center; padding: 3rem; background: var(--bg-card); border: var(--border-gold);">
            <p style="color: var(--text-muted);"><@spring.message "consigliere.ledger.empty"/></p>
        </div>
    </#if>

</@layout.page_layout>