<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<#assign confirmWarMsg = springMacroRequestContext.getMessage('boss.diplomacy.confirm_war')>

<@layout.page_layout title="${springMacroRequestContext.getMessage('boss.diplomacy.title')} | ${springMacroRequestContext.getMessage('role.boss.badge')}" activeTab="diplomacy">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text"><@spring.message "boss.diplomacy.title"/></h1>
            <p class="subtitle-text"><@spring.message "boss.diplomacy.subtitle"/></p>
        </div>
        <a href="/boss" style="font-family: var(--font-heading);"><@spring.message "boss.back_to_hq"/></a>
    </div>

    <div class="table-responsive">
        <table class="speakeasy-table">
            <thead>
            <tr>
                <th><@spring.message "boss.diplomacy.table.family"/></th>
                <th><@spring.message "boss.diplomacy.table.status"/></th>
                <th><@spring.message "boss.diplomacy.table.actions"/></th>
            </tr>
            </thead>
            <tbody>
            <#list relations as rel>
                <#assign otherFamily = (rel.family1.id == currentFamily.id)?then(rel.family2, rel.family1)>
                <#assign isOurProposal = (rel.initiatorFamily?? && rel.initiatorFamily.id == currentFamily.id)>

                <tr>
                    <td style="font-family: var(--font-heading); font-weight: bold; font-size: 1.05rem; color: var(--brass-gold);">
                        <@spring.message "family.other.family_prefix"/> ${otherFamily.name}
                    </td>
                    <td>
                        <#if rel.status == 'PEACE'>
                            <span style="color: #81C784; font-weight: bold;">🕊️ <@spring.message "boss.diplomacy.status.peace"/></span>
                        <#elseif rel.status == 'WAR'>
                            <span style="color: #FF5555; font-weight: bold;">🗡️ <@spring.message "boss.diplomacy.status.war"/></span>
                        <#elseif rel.status == 'PENDING_PEACE'>
                            <#if isOurProposal>
                                <span style="color: #FFB74D; font-weight: bold;">⏳ <@spring.message "boss.diplomacy.status.pending_our"/></span>
                            <#else>
                                <span style="color: #64B5F6; font-weight: bold;">✉️ <@spring.message "boss.diplomacy.status.pending_incoming"/></span>
                            </#if>
                        </#if>
                    </td>
                    <td>
                        <div style="display: flex; gap: 0.6rem; align-items: center; flex-wrap: wrap;">
                            <#if rel.status != 'WAR'>
                                <form action="/boss/diplomacy/declare-war" method="POST" onsubmit="return confirm('${confirmWarMsg} ${otherFamily.name}?');" style="margin: 0;">
                                    <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                                    <input type="hidden" name="targetFamilyId" value="${otherFamily.id}"/>
                                    <button type="submit" style="background: #6B1310; border: 1px solid #FF5555; color: #FFF; padding: 0.4rem 0.8rem; font-family: var(--font-heading); cursor: pointer; text-transform: uppercase; font-size: 0.75rem;">
                                        <@spring.message "boss.diplomacy.btn.war"/>
                                    </button>
                                </form>
                            </#if>

                            <#if rel.status == 'WAR'>
                                <form action="/boss/diplomacy/propose-peace" method="POST" style="margin: 0;">
                                    <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                                    <input type="hidden" name="targetFamilyId" value="${otherFamily.id}"/>
                                    <button type="submit" class="btn-action" style="padding: 0.4rem 0.8rem; font-size: 0.75rem;">
                                        <@spring.message "boss.diplomacy.btn.propose_peace"/>
                                    </button>
                                </form>
                            </#if>

                            <#if rel.status == 'PENDING_PEACE'>
                                <#if isOurProposal>
                                    <span style="color: var(--text-muted); font-size: 0.8rem; font-style: italic;"><@spring.message "boss.diplomacy.dispatched"/></span>
                                <#else>
                                    <form action="/boss/diplomacy/accept-peace" method="POST" style="margin: 0;">
                                        <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                                        <input type="hidden" name="targetFamilyId" value="${otherFamily.id}"/>
                                        <button type="submit" style="background: #1B5E20; border: 1px solid #81C784; color: #FFF; padding: 0.4rem 0.8rem; font-family: var(--font-heading); cursor: pointer; text-transform: uppercase; font-size: 0.75rem;">
                                            <@spring.message "boss.diplomacy.btn.accept_peace"/>
                                        </button>
                                    </form>
                                </#if>
                            </#if>
                        </div>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>

</@layout.page_layout>