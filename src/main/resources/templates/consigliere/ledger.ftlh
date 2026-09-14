<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Финансовая Книга | Консильери" activeTab="ledger">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text">Бухгалтерская Книга Семьи</h1>
            <p class="subtitle-text">Контроль финансовых поступлений и расходов общака</p>
        </div>
        <a href="/consigliere/messages/new" class="btn-gold" style="width: auto; padding: 0.7rem 1.4rem;">
            ✉ Донесение Дону
        </a>
    </div>

    <#if ledger?? && ledger?has_content>
        <div class="table-responsive">
            <table class="speakeasy-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Капореджиме</th>
                    <th>Сумма транзакции</th>
                    <th>Дата и Время</th>
                    <th>Назначение платежа</th>
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
                        <td style="color: var(--text-muted);">${(item.description)!"Еженедельный взнос"}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    <#else>
        <div style="text-align: center; padding: 3rem; background: var(--bg-card); border: var(--border-gold);">
            <p style="color: var(--text-muted);">В книге притоков пока нет записей.</p>
        </div>
    </#if>

</@layout.page_layout>