<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('boss.treasury.title')} | ${springMacroRequestContext.getMessage('role.boss.badge')}" activeTab="boss_ledger">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text"><@spring.message "boss.treasury.title"/></h1>
            <p class="subtitle-text"><@spring.message "boss.treasury.subtitle"/></p>
        </div>
        <div style="background: var(--burgundy-dark); border: 2px solid var(--brass-gold); padding: 0.8rem 1.5rem; text-align: right;">
            <div style="font-size: 0.72rem; color: var(--text-muted); text-transform: uppercase;"><@spring.message "boss.treasury.balance_label"/></div>
            <div style="font-family: var(--font-heading); font-size: 1.6rem; color: var(--brass-gold); font-weight: bold;">
                $${(family.treasuryBalance?string[",##0.00"])!'0.00'}
            </div>
        </div>
    </div>

    <!-- Форма инвестиций -->
    <div style="background: var(--bg-card); border: var(--border-gold); padding: 1.8rem; margin-bottom: 2.5rem; max-width: 600px; box-shadow: var(--box-shadow-card);">
        <h2 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.2rem; margin-bottom: 1.2rem; text-transform: uppercase;">
            💰 <@spring.message "boss.treasury.invest.title"/>
        </h2>
        <form action="/boss/treasury/invest" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div class="form-group">
                <label class="form-label"><@spring.message "boss.treasury.invest.amount"/></label>
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
                <label class="form-label"><@spring.message "boss.treasury.invest.desc"/></label>
                <input type="text" name="description" placeholder="${springMacroRequestContext.getMessage('boss.treasury.invest.desc_placeholder')}" class="form-input" required />
            </div>

            <button type="submit" class="btn-gold" style="width: auto; padding: 0.8rem 1.6rem;">
                <@spring.message "boss.treasury.btn.deduct"/>
            </button>
        </form>
    </div>

    <!-- Журнал движений -->
    <h3 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">
        <@spring.message "boss.treasury.ledger_title"/>
    </h3>

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
        <p style="color: var(--text-muted);"><@spring.message "boss.treasury.empty"/></p>
    </#if>

</@layout.page_layout>