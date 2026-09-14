<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Депеша: ${(msg.subject)!''} | Дон" activeTab="messages">

    <div style="max-width: 750px; margin: 0 auto; background: var(--bg-card); border: var(--border-gold); padding: clamp(1.5rem, 4vw, 3rem); position: relative; box-shadow: 0 0 35px rgba(0,0,0,0.9);">
        <div class="file-stamp" style="top: 1.5rem; right: 1.5rem;">
            Сургучная печать Дона
        </div>

        <div style="border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 1.5rem; margin-bottom: 2rem;">
            <h1 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.8rem; margin-bottom: 0.8rem; word-break: break-word;">
                ${msg.subject}
            </h1>
            <div style="font-size: 0.85rem; color: var(--text-muted); line-height: 1.7;">
                <div><strong>От:</strong> ${msg.sender.username} (${msg.sender.role})</div>
                <div><strong>Кому:</strong> ${msg.recipient.username} (${msg.recipient.role})</div>
                <div><strong>Дата протокола:</strong> ${msg.sentAt}</div>
            </div>
        </div>

        <div style="line-height: 1.8; font-size: 1rem; color: var(--text-main); white-space: pre-wrap; word-break: break-word; margin-bottom: 2.5rem;">
            ${msg.body}
        </div>

        <div style="border-top: 1px dashed rgba(197,160,89,0.2); padding-top: 1.5rem; display: flex; justify-content: space-between; flex-wrap: wrap; gap: 1rem;">
            <a href="/boss/messages" style="font-family: var(--font-heading); text-transform: uppercase;">
                ← Вернуться к почте
            </a>
            <a href="/boss/messages/new" style="font-family: var(--font-heading); text-transform: uppercase;">
                Ответить →
            </a>
        </div>
    </div>

</@layout.page_layout>