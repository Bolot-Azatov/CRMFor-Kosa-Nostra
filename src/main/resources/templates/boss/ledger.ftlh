<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Аудит Казны | Дон" activeTab="racket">

    <style>
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.2);
            padding-bottom: 1rem;
        }

        .title-text {
            font-family: 'Cinzel', serif;
            font-size: 2rem;
            color: var(--brass-gold);
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .ledger-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--bg-card);
            border: var(--border-gold);
            font-size: 0.9rem;
        }

        .ledger-table th {
            background-color: var(--burgundy-dark);
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
            text-transform: uppercase;
            padding: 1rem;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--brass-gold);
            text-align: left;
        }

        .ledger-table td {
            padding: 1rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.15);
            color: var(--text-main);
        }

        .amount-positive { color: #81C784; font-weight: bold; font-family: 'Cinzel', serif; }
        .amount-negative { color: #FF7777; font-weight: bold; font-family: 'Cinzel', serif; }
    </style>

    <div class="page-header">
        <div>
            <h1 class="title-text">Движение средств Общака</h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">Все транзакции: приток дани и целевые инвестиции Дона</p>
        </div>
        <a href="/boss" style="color: var(--brass-gold); text-decoration: none; font-family: 'Cinzel', serif;">← В кабинет Дона</a>
    </div>

    <#if ledger?? && ledger?has_content>
        <table class="ledger-table">
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
    <#else>
        <div style="text-align: center; padding: 3rem; background: var(--bg-card); border: var(--border-gold);">
            <p style="color: var(--text-muted);">Журнал пуст.</p>
        </div>
    </#if>

</@layout.page_layout>