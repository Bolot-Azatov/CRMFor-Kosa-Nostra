<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Дипломатия и Внешняя Политика | Дон" activeTab="diplomacy">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text">Дипломатические Отношения</h1>
            <p class="subtitle-text">Статусы перемирий, пактов и военных конфликтов</p>
        </div>
        <a href="/boss" style="font-family: var(--font-heading);">← В Кабинет Дона</a>
    </div>

    <div class="table-responsive">
        <table class="speakeasy-table">
            <thead>
            <tr>
                <th>Семья-контрагент</th>
                <th>Текущий Статус</th>
                <th>Действия Дона</th>
            </tr>
            </thead>
            <tbody>
            <#list relations as rel>
                <#assign otherFamily = (rel.family1.id == currentFamily.id)?then(rel.family2, rel.family1)>
                <#assign isOurProposal = (rel.initiatorFamily?? && rel.initiatorFamily.id == currentFamily.id)>

                <tr>
                    <td style="font-family: var(--font-heading); font-weight: bold; font-size: 1.05rem; color: var(--brass-gold);">
                        Семья ${otherFamily.name}
                    </td>
                    <td>
                        <#if rel.status == 'PEACE'>
                            <span style="color: #81C784; font-weight: bold;">🕊️ МИР</span>
                        <#elseif rel.status == 'WAR'>
                            <span style="color: #FF5555; font-weight: bold;">🗡️ ВОЙНА</span>
                        <#elseif rel.status == 'PENDING_PEACE'>
                            <#if isOurProposal>
                                <span style="color: #FFB74D; font-weight: bold;">⏳ МИР ПРЕДЛОЖЕН (Ожидание)</span>
                            <#else>
                                <span style="color: #64B5F6; font-weight: bold;">✉️ ВХОДЯЩЕЕ ПРЕДЛОЖЕНИЕ МИРА</span>
                            </#if>
                        </#if>
                    </td>
                    <td>
                        <div style="display: flex; gap: 0.6rem; align-items: center; flex-wrap: wrap;">
                            <#if rel.status != 'WAR'>
                                <form action="/boss/diplomacy/declare-war" method="POST" onsubmit="return confirm('Вы уверены, что хотите объявить войну семье ${otherFamily.name}?');" style="margin: 0;">
                                    <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                                    <input type="hidden" name="targetFamilyId" value="${otherFamily.id}"/>
                                    <button type="submit" style="background: #6B1310; border: 1px solid #FF5555; color: #FFF; padding: 0.4rem 0.8rem; font-family: var(--font-heading); cursor: pointer; text-transform: uppercase; font-size: 0.75rem;">
                                        Война
                                    </button>
                                </form>
                            </#if>

                            <#if rel.status == 'WAR'>
                                <form action="/boss/diplomacy/propose-peace" method="POST" style="margin: 0;">
                                    <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                                    <input type="hidden" name="targetFamilyId" value="${otherFamily.id}"/>
                                    <button type="submit" class="btn-action" style="padding: 0.4rem 0.8rem; font-size: 0.75rem;">
                                        Предложить мир
                                    </button>
                                </form>
                            </#if>

                            <#if rel.status == 'PENDING_PEACE'>
                                <#if isOurProposal>
                                    <span style="color: var(--text-muted); font-size: 0.8rem; font-style: italic;">Депеша отправлена</span>
                                <#else>
                                    <form action="/boss/diplomacy/accept-peace" method="POST" style="margin: 0;">
                                        <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                                        <input type="hidden" name="targetFamilyId" value="${otherFamily.id}"/>
                                        <button type="submit" style="background: #1B5E20; border: 1px solid #81C784; color: #FFF; padding: 0.4rem 0.8rem; font-family: var(--font-heading); cursor: pointer; text-transform: uppercase; font-size: 0.75rem;">
                                            Принять мир
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