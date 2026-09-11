<!-- src/main/resources/templates/consigliere/messages.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Почтовый Ящик | Консильери" activeTab="message">

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 1rem;">
        <div>
            <h1 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 2rem; margin: 0;">Тайная Почта Консильери</h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">Секретные депеши и донесения Дону</p>
        </div>
        <a href="/consigliere/messages/new" style="padding: 0.7rem 1.4rem; background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%); color: #0A0A0A; text-decoration: none; font-family: 'Cinzel', serif; font-weight: bold; text-transform: uppercase;">
            ✉ Донесение Дону
        </a>
    </div>

    <!-- Входящие -->
    <h3 style="font-family: 'Cinzel', serif; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">Входящие депеши</h3>
    <table style="width: 100%; border-collapse: collapse; background: var(--bg-card); border: var(--border-gold); margin-bottom: 2.5rem;">
        <thead>
        <tr style="background: var(--burgundy-dark); color: var(--brass-gold); font-family: 'Cinzel', serif; text-align: left;">
            <th style="padding: 0.8rem;">Статус</th>
            <th style="padding: 0.8rem;">От кого</th>
            <th style="padding: 0.8rem;">Тема</th>
            <th style="padding: 0.8rem;">Дата</th>
            <th style="padding: 0.8rem;">Действие</th>
        </tr>
        </thead>
        <tbody>
        <#if inbox?? && inbox?has_content>
            <#list inbox as m>
                <tr style="border-bottom: 1px solid rgba(197,160,89,0.15); <#if !m.read>background: rgba(197,160,89,0.08);</#if>">
                    <td style="padding: 0.8rem;">
                        <#if m.read>
                            <span style="color: var(--text-muted);">Прочитано</span>
                        <#else>
                            <span style="color: #FF5555; font-weight: bold;">● НОВОЕ</span>
                        </#if>
                    </td>
                    <td style="padding: 0.8rem; color: var(--brass-gold);">${m.sender.username}</td>
                    <td style="padding: 0.8rem; font-weight: bold;">${m.subject}</td>
                    <td style="padding: 0.8rem; color: var(--text-muted);">${m.sentAt}</td>
                    <td style="padding: 0.8rem;">
                        <a href="/consigliere/messages/${m.id}" style="color: var(--brass-gold); text-decoration: none; font-family: 'Cinzel', serif;">Читать →</a>
                    </td>
                </tr>
            </#list>
        <#else>
            <tr><td colspan="5" style="padding: 1.5rem; text-align: center; color: var(--text-muted);">Входящих посланий нет.</td></tr>
        </#if>
        </tbody>
    </table>

    <!-- Исходящие -->
    <h3 style="font-family: 'Cinzel', serif; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">Исходящие донесения</h3>
    <table style="width: 100%; border-collapse: collapse; background: var(--bg-card); border: var(--border-gold);">
        <thead>
        <tr style="background: var(--burgundy-dark); color: var(--brass-gold); font-family: 'Cinzel', serif; text-align: left;">
            <th style="padding: 0.8rem;">Адресат</th>
            <th style="padding: 0.8rem;">Тема</th>
            <th style="padding: 0.8rem;">Дата</th>
            <th style="padding: 0.8rem;">Действие</th>
        </tr>
        </thead>
        <tbody>
        <#if outbox?? && outbox?has_content>
            <#list outbox as m>
                <tr style="border-bottom: 1px solid rgba(197,160,89,0.15);">
                    <td style="padding: 0.8rem; color: var(--brass-gold);">${m.recipient.username}</td>
                    <td style="padding: 0.8rem;">${m.subject}</td>
                    <td style="padding: 0.8rem; color: var(--text-muted);">${m.sentAt}</td>
                    <td style="padding: 0.8rem;">
                        <a href="/consigliere/messages/${m.id}" style="color: var(--brass-gold); text-decoration: none; font-family: 'Cinzel', serif;">Просмотр →</a>
                    </td>
                </tr>
            </#list>
        <#else>
            <tr><td colspan="4" style="padding: 1.5rem; text-align: center; color: var(--text-muted);">Исходящих донесений нет.</td></tr>
        </#if>
        </tbody>
    </table>

</@layout.page_layout>