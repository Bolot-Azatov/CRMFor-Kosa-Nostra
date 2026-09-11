<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Финансовая Книга | Консильери" activeTab="racket">

    <style>
        .ledger-header {
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

        .btn-action {
            padding: 0.7rem 1.4rem;
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            color: #0A0A0A;
            font-family: 'Cinzel', serif;
            font-size: 0.85rem;
            font-weight: bold;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            background: linear-gradient(180deg, var(--brass-gold-hover) 0%, var(--brass-gold) 100%);
            transform: translateY(-2px);
        }

        .speakeasy-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--bg-card);
            border: var(--border-gold);
            font-size: 0.9rem;
        }

        .speakeasy-table th {
            background-color: var(--burgundy-dark);
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
            text-transform: uppercase;
            padding: 1rem;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--brass-gold);
            text-align: left;
        }

        .speakeasy-table td {
            padding: 1rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.15);
            color: var(--text-main);
        }

        .speakeasy-table tr:hover {
            background: rgba(197, 160, 89, 0.05);
        }

        .amount-positive {
            color: #81C784;
            font-weight: bold;
            font-family: 'Cinzel', serif;
        }

        .amount-negative {
            color: #FF7777;
            font-weight: bold;
            font-family: 'Cinzel', serif;
        }
    </style>

    <div class="ledger-header">
        <div>
            <h1 class="title-text">Бухгалтерская Книга Семьи</h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">Контроль финансовых поступлений и расходов общака</p>
        </div>
        <a href="/counselor/message" class="btn-action">✉ Донесение Дону</a>
    </div>

    <#if ledger?? && ledger?has_content>
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
    <#else>
        <div style="text-align: center; padding: 3rem; background: var(--bg-card); border: var(--border-gold);">
            <p style="color: var(--text-muted);">В книге притоков пока нет записей.</p>
        </div>
    </#if>

</@layout.page_layout>