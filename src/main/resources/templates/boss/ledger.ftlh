<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Аудит Казны | Дон" activeTab="racket">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text">Движение средств Общака</h1>
            <p class="subtitle-text">Все транзакции: приток дани и целевые инвестиции Дона</p>
        </div>
        <a href="/boss" style="font-family: var(--font-heading);">← В кабинет Дона</a>
    </div>

    <#if ledger?? && ledger?has_content>
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
                <#list ledger as item>
                    <tr>
                        <td>#${item.id}</td>
                        <td style="color: var(--brass-gold);">${(item.capo.username)!'Семья'}</td>
                        <td>
                            <#if (item.amount >= 0)>
                                <span class="amount-positive">+$${item.amount?string[",##0.00"]}</span>
                            <#else>
                                <span class="amount-negative">-$${(-item.amount)?string[",##0.00"]}</span>
                            </#if>
                        </td>
                        <td>${item.contributedAt}</td>
                        <td style="color: var(--text-muted);">${item.description!"Без описания"}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    <#else>
        <div style="text-align: center; padding: 3rem; background: var(--bg-card); border: var(--border-gold);">
            <p style="color: var(--text-muted);">Журнал пуст.</p>
        </div>
    </#if>

</@layout.page_layout>