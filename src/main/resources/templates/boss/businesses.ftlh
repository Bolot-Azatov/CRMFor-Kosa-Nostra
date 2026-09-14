<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('boss.businesses.title')} | ${springMacroRequestContext.getMessage('role.boss.badge')}" activeTab="businesses">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text"><@spring.message "boss.businesses.title"/></h1>
            <p class="subtitle-text"><@spring.message "boss.businesses.subtitle"/></p>
        </div>
        <a href="/boss" style="font-family: var(--font-heading);"><@spring.message "boss.back_to_hq"/></a>
    </div>

    <#if businesses?? && businesses?has_content>
        <div class="table-responsive">
            <table class="speakeasy-table">
                <thead>
                <tr>
                    <th><@spring.message "boss.businesses.table.id"/></th>
                    <th><@spring.message "boss.businesses.table.name"/></th>
                    <th><@spring.message "boss.businesses.table.industry"/></th>
                    <th><@spring.message "boss.businesses.table.revenue"/></th>
                    <th><@spring.message "boss.businesses.table.capo"/></th>
                </tr>
                </thead>
                <tbody>
                <#list businesses as b>
                    <tr>
                        <td>#${b.id}</td>
                        <td style="color: var(--brass-gold); font-weight: bold;">${b.name}</td>
                        <td>${b.type}</td>
                        <td style="color: #81C784; font-family: var(--font-heading); font-weight: bold;">
                            $${b.weeklyRevenue?string[",##0.00"]}
                        </td>
                        <td>
                            <#if b.capo??>
                                <span style="color: var(--brass-gold);">${b.capo.username}</span>
                            <#else>
                                <span style="color: #FF7777;"><@spring.message "boss.businesses.not_assigned"/></span>
                            </#if>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    </#if>

    <!-- Форма закрепления бизнеса за Капо -->
    <div style="background: var(--bg-card); border: var(--border-gold); padding: 2rem; max-width: 650px; box-shadow: var(--box-shadow-card);">
        <h2 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.2rem; margin-bottom: 1.2rem; text-transform: uppercase;">
            ⚖ <@spring.message "boss.businesses.assign.title"/>
        </h2>
        <form action="/boss/businesses/assign" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div class="form-group">
                <label class="form-label"><@spring.message "boss.businesses.select_biz"/></label>
                <select name="businessId" class="form-select" required>
                    <#list businesses as b>
                        <option value="${b.id}">${b.name} (${b.type})</option>
                    </#list>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label"><@spring.message "boss.businesses.select_capo"/></label>
                <select name="capoId" class="form-select" required>
                    <#if capos?? && capos?has_content>
                        <#list capos as c>
                            <option value="${c.id}">${c.username}</option>
                        </#list>
                    <#else>
                        <option disabled><@spring.message "boss.businesses.no_capos"/></option>
                    </#if>
                </select>
            </div>

            <button type="submit" class="btn-gold" style="width: auto; padding: 0.8rem 1.6rem;">
                <@spring.message "boss.businesses.btn.assign"/>
            </button>
        </form>
    </div>

</@layout.page_layout>