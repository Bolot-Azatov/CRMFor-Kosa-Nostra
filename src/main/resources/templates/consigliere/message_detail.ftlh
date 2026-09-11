<!-- src/main/resources/templates/consigliere/message_detail.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Донесение: ${(msg.subject)!''} | Консильери" activeTab="message">

    <div style="max-width: 750px; margin: 0 auto; background: var(--bg-card); border: var(--border-gold); padding: 3rem; position: relative; box-shadow: 0 0 35px rgba(0,0,0,0.9);">
        <div style="position: absolute; top: 1.5rem; right: 1.5rem; border: 2px solid var(--burgundy-light); color: #FF6666; padding: 0.2rem 0.6rem; font-family: 'Cinzel', serif; font-size: 0.75rem; text-transform: uppercase;">
            Конфиденциально
        </div>

        <div style="border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 1.5rem; margin-bottom: 2rem;">
            <h1 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 1.8rem; margin-bottom: 0.8rem;">${msg.subject}</h1>
            <div style="font-size: 0.85rem; color: var(--text-muted);">
                <div><strong>От:</strong> ${msg.sender.username} (${msg.sender.role})</div>
                <div><strong>Кому:</strong> ${msg.recipient.username} (${msg.recipient.role})</div>
                <div><strong>Отправлено:</strong> ${msg.sentAt}</div>
            </div>
        </div>

        <div style="line-height: 1.8; font-size: 1rem; color: var(--text-main); white-space: pre-wrap; margin-bottom: 2.5rem;">
            ${msg.body}
        </div>

        <div style="border-top: 1px dashed rgba(197,160,89,0.2); padding-top: 1.5rem;">
            <a href="/consigliere/messages" style="color: var(--brass-gold); text-decoration: none; font-family: 'Cinzel', serif; text-transform: uppercase;">← Вернуться к списку сообщений</a>
        </div>
    </div>

</@layout.page_layout>