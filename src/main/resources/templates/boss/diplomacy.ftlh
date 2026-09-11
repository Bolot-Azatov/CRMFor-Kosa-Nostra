<!-- src/main/resources/templates/boss/diplomacy.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Дипломатия и Внешняя Политика | Дон" activeTab="diplomacy">

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 1rem;">
        <div>
            <h1 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 2rem; margin: 0;">Дипломатические Отношения</h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">Статусы перемирий, пактов и военных конфликтов</p>
        </div>
        <a href="/boss" style="color: var(--brass-gold); text-decoration: none; font-family: 'Cinzel', serif;">← В Кабинет Дона</a>
    </div>

    <table style="width: 100%; border-collapse: collapse; background: var(--bg-card); border: var(--border-gold);">
        <thead>
        <tr style="background: var(--burgundy-dark); color: var(--brass-gold); font-family: 'Cinzel', serif; text-align: left;">
            <th style="padding: 1rem;">Семья-контрагент</th>
            <th style="padding: 1rem;">Текущий Статус</th>
            <th style="padding: 1rem;">Действия Дона</th>
        </tr>
        </thead>
        <tbody>
        <#list relations as rel>
            <#assign otherFamily = (rel.family1.id == currentFamily.id)?then(rel.family2, rel.family1)>
            <tr style="border-bottom: 1px solid rgba(197,160,89,0.15);">
                <td style="padding: 1rem; font-family: 'Cinzel', serif; font-weight: bold; font-size: 1.1rem; color: var(--brass-gold);">
                    Семья ${otherFamily.name}
                </td>
                <td style="padding: 1rem;">
                    <#if rel.status == 'PEACE'>
                        <span style="color: #81C784; font-weight: bold;">🕊️ МИР</span>
                    <#elseif rel.status == 'WAR'>
                        <span style="color: #FF5555; font-weight: bold;">🗡️ ВОЙНА</span>
                    <#elseif rel.status == 'PENDING_PEACE'>
                        <span style="color: #FFB74D; font-weight: bold;">⏳ ЗАПРОС НА МИР</span>
                    </#if>
                </td>
                <td style="padding: 1rem; display: flex; gap: 0.6rem; align-items: center;">
                    <#if rel.status != 'WAR'>
                        <form action="/boss/diplomacy/declare-war" method="POST" onsubmit="return confirm('Вы уверены, что хотите объявить войну семье ${otherFamily.name}?');">
                            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                            <input type="hidden" name="targetFamilyId" value="${otherFamily.id}"/>
                            <button type="submit" style="background: #6B1310; border: 1px solid #FF5555; color: #FFF; padding: 0.4rem 0.8rem; font-family: 'Cinzel', serif; cursor: pointer; text-transform: uppercase;">
                                Война
                            </button>
                        </form>
                    </#if>

                    <#if rel.status == 'WAR'>
                        <form action="/boss/diplomacy/propose-peace" method="POST">
                            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                            <input type="hidden" name="targetFamilyId" value="${otherFamily.id}"/>
                            <button type="submit" style="background: transparent; border: 1px solid var(--brass-gold); color: var(--brass-gold); padding: 0.4rem 0.8rem; font-family: 'Cinzel', serif; cursor: pointer; text-transform: uppercase;">
                                Предложить мир
                            </button>
                        </form>
                    </#if>

                    <#if rel.status == 'PENDING_PEACE'>
                        <form action="/boss/diplomacy/accept-peace" method="POST">
                            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                            <input type="hidden" name="targetFamilyId" value="${otherFamily.id}"/>
                            <button type="submit" style="background: #1B5E20; border: 1px solid #81C784; color: #FFF; padding: 0.4rem 0.8rem; font-family: 'Cinzel', serif; cursor: pointer; text-transform: uppercase;">
                                Принять мир
                            </button>
                        </form>
                    </#if>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>

</@layout.page_layout>