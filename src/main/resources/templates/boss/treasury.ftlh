<!-- src/main/resources/templates/boss/treasury.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Казначейство и Общак | Дон" activeTab="boss_ledger">

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 1rem;">
        <div>
            <h1 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 2rem; margin: 0;">Казначейство Семьи</h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">Финансовый аудит и целевые инвестиции</p>
        </div>
        <div style="background: var(--burgundy-dark); border: 2px solid var(--brass-gold); padding: 0.8rem 1.5rem; text-align: right;">
            <div style="font-size: 0.72rem; color: var(--text-muted); text-transform: uppercase;">Баланс Казны:</div>
            <div style="font-family: 'Cinzel', serif; font-size: 1.6rem; color: var(--brass-gold); font-weight: bold;">
                $${(family.treasuryBalance?string[",##0.00"])!'0.00'}
            </div>
        </div>
    </div>

    <!-- Форма инвестиций -->
    <div style="background: var(--bg-card); border: var(--border-gold); padding: 1.8rem; margin-bottom: 2.5rem; max-width: 600px;">
        <h2 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 1.2rem; margin-bottom: 1.2rem; text-transform: uppercase;">
            💰 Провести целевую инвестицию
        </h2>
        <form action="/boss/treasury/invest" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div style="margin-bottom: 1rem;">
                <label style="display:block; font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; margin-bottom: 0.3rem;">Сумма ($) *</label>
                <input type="number" step="0.01" min="0.01" name="amount" style="width: 100%; padding: 0.7rem; background: #121212; border: var(--border-gold); color: var(--text-main);" required />
            </div>

            <div style="margin-bottom: 1.5rem;">
                <label style="display:block; font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; margin-bottom: 0.3rem;">Назначение средств *</label>
                <input type="text" name="description" placeholder="Подкуп полиции / Оружие" style="width: 100%; padding: 0.7rem; background: #121212; border: var(--border-gold); color: var(--text-main);" required />
            </div>

            <button type="submit" style="padding: 0.8rem 1.6rem; background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%); color: #0A0A0A; border: none; font-family: 'Cinzel', serif; font-weight: bold; cursor: pointer; text-transform: uppercase;">
                Списать средства
            </button>
        </form>
    </div>

    <!-- Журнал движений -->
    <h3 style="font-family: 'Cinzel', serif; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">Журнал проводок</h3>
    <#if ledger?? && ledger?has_content>
        <table style="width: 100%; border-collapse: collapse; background: var(--bg-card); border: var(--border-gold);">
            <thead>
            <tr style="background: var(--burgundy-dark); color: var(--brass-gold); font-family: 'Cinzel', serif; text-align: left;">
                <th style="padding: 0.8rem;">ID</th>
                <th style="padding: 0.8rem;">Инициатор</th>
                <th style="padding: 0.8rem;">Сумма</th>
                <th style="padding: 0.8rem;">Дата</th>
                <th style="padding: 0.8rem;">Описание</th>
            </tr>
            </thead>
            <tbody>
            <#list ledger as item>
                <tr style="border-bottom: 1px solid rgba(197,160,89,0.15);">
                    <td style="padding: 0.8rem;">#${item.id}</td>
                    <td style="padding: 0.8rem; color: var(--brass-gold);">${(item.capo.username)!'Семья'}</td>
                    <td style="padding: 0.8rem; font-family: 'Cinzel', serif; font-weight: bold;">
                        <#if (item.amount >= 0)>
                            <span style="color: #81C784;">+$${item.amount?string[",##0.00"]}</span>
                        <#else>
                            <span style="color: #FF7777;">-$${(-item.amount)?string[",##0.00"]}</span>
                        </#if>
                    </td>
                    <td style="padding: 0.8rem;">${item.contributedAt}</td>
                    <td style="padding: 0.8rem; color: var(--text-muted);">${item.description!"-"}</td>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <p style="color: var(--text-muted);">Записей нет.</p>
    </#if>

</@layout.page_layout>