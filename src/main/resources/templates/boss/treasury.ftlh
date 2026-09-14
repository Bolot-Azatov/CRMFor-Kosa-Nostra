<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Казначейство и Общак | Дон" activeTab="boss_ledger">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text">Казначейство Семьи</h1>
            <p class="subtitle-text">Финансовый аудит и целевые инвестиции</p>
        </div>
        <div style="background: var(--burgundy-dark); border: 2px solid var(--brass-gold); padding: 0.8rem 1.5rem; text-align: right;">
            <div style="font-size: 0.72rem; color: var(--text-muted); text-transform: uppercase;">Баланс Казны:</div>
            <div style="font-family: var(--font-heading); font-size: 1.6rem; color: var(--brass-gold); font-weight: bold;">
                $${(family.treasuryBalance?string[",##0.00"])!'0.00'}
            </div>
        </div>
    </div>

    <!-- Форма инвестиций -->
    <div style="background: var(--bg-card); border: var(--border-gold); padding: 1.8rem; margin-bottom: 2.5rem; max-width: 600px; box-shadow: var(--box-shadow-card);">
        <h2 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.2rem; margin-bottom: 1.2rem; text-transform: uppercase;">
            💰 Провести целевую инвестицию
        </h2>
        <form action="/boss/treasury/invest" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div class="form-group">
                <label class="form-label">Сумма ($) *</label>
                <input type="number"
                       step="0.01"
                       min="0.01"
                       name="amount"
                       placeholder="100.00"
                       onkeydown="if(event.key === '-' || event.key === '+' || event.key === 'e' || event.key === 'E') event.preventDefault();"
                       oninput="if(this.value !== '' && this.value <= 0) this.value = Math.abs(this.value) || 0.01;"
                       class="form-input"
                       required />
            </div>

            <div class="form-group">
                <label class="form-label">Назначение средств *</label>
                <input type="text" name="description" placeholder="Подкуп полиции / Оружие" class="form-input" required />
            </div>

            <button type="submit" class="btn-gold" style="width: auto; padding: 0.8rem 1.6rem;">
                Списать средства
            </button>
        </form>
    </div>

    <!-- Журнал движений -->
    <h3 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">
        Журнал проводок
    </h3>

    <#if ledger?? && ledger?has_content>
        <div class="table-responsive">
            <table class="speakeasy-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Инициатор</th>
                    <th>Сумма</th>
                    <th>Дата</th>
                    <th>Описание</th>
                </tr>
                </thead>
                <tbody>
                <#list ledger as item>
                    <tr>
                        <td>#${item.id}</td>
                        <td style="color: var(--brass-gold);">${(item.capo.username)!'Семья'}</td>
                        <td style="font-family: var(--font-heading); font-weight: bold;">
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
        <p style="color: var(--text-muted);">Записей нет.</p>
    </#if>

</@layout.page_layout>