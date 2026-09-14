<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${(msg.subject)!''} | ${springMacroRequestContext.getMessage('role.consigliere.title')}" activeTab="message">

    <div style="max-width: 750px; margin: 0 auto; background: var(--bg-card); border: var(--border-gold); padding: clamp(1.5rem, 4vw, 3rem); position: relative; box-shadow: 0 0 35px rgba(0,0,0,0.9);">
        <div class="file-stamp" style="top: 1.5rem; right: 1.5rem;">
            <@spring.message "consigliere.message_detail.stamp"/>
        </div>

        <div style="border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 1.5rem; margin-bottom: 2rem;">
            <h1 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.8rem; margin-bottom: 0.8rem; word-break: break-word;">
                ${msg.subject}
            </h1>
            <div style="font-size: 0.85rem; color: var(--text-muted); line-height: 1.7;">
                <div><strong><@spring.message "boss.message_detail.from"/></strong> ${msg.sender.username} (${msg.sender.role})</div>
                <div><strong><@spring.message "boss.message_detail.to"/></strong> ${msg.recipient.username} (${msg.recipient.role})</div>
                <div><strong><@spring.message "consigliere.messages.table.date"/>:</strong> ${msg.sentAt}</div>
            </div>
        </div>

        <div style="line-height: 1.8; font-size: 1rem; color: var(--text-main); white-space: pre-wrap; word-break: break-word; margin-bottom: 2.5rem;">
            ${msg.body}
        </div>

        <div style="border-top: 1px dashed rgba(197,160,89,0.2); padding-top: 1.5rem;">
            <a href="/consigliere/messages" style="font-family: var(--font-heading); text-transform: uppercase;">
                <@spring.message "consigliere.message_detail.back"/>
            </a>
        </div>
    </div>

</@layout.page_layout>