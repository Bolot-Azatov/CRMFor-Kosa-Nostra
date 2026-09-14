<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('boss.messages.title')} | ${springMacroRequestContext.getMessage('role.boss.badge')}" activeTab="messages">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text"><@spring.message "boss.messages.title"/></h1>
            <p class="subtitle-text"><@spring.message "boss.messages.subtitle"/></p>
        </div>
        <a href="/boss/messages/new" class="btn-gold" style="width: auto; padding: 0.7rem 1.4rem;">
            <@spring.message "boss.messages.btn.new"/>
        </a>
    </div>

    <!-- Входящие -->
    <h3 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">
        <@spring.message "boss.messages.inbox_title"/>
    </h3>
    <div class="table-responsive">
        <table class="speakeasy-table" style="margin-bottom: 2.5rem;">
            <thead>
            <tr>
                <th><@spring.message "boss.messages.table.status"/></th>
                <th><@spring.message "boss.messages.table.sender"/></th>
                <th><@spring.message "boss.messages.table.subject"/></th>
                <th><@spring.message "boss.messages.table.time"/></th>
                <th><@spring.message "boss.messages.table.action"/></th>
            </tr>
            </thead>
            <tbody>
            <#if inbox?? && inbox?has_content>
                <#list inbox as m>
                    <tr <#if !m.read>style="background: rgba(197,160,89,0.08);"</#if>>
                        <td>
                            <#if m.read>
                                <span style="color: var(--text-muted);"><@spring.message "boss.messages.status.read"/></span>
                            <#else>
                                <span style="color: #FF5555; font-weight: bold;"><@spring.message "boss.messages.status.new"/></span>
                            </#if>
                        </td>
                        <td style="color: var(--brass-gold);">${m.sender.username} (${m.sender.role})</td>
                        <td style="font-weight: bold;">${m.subject}</td>
                        <td style="color: var(--text-muted); font-size: 0.85rem;">${m.sentAt}</td>
                        <td>
                            <a href="/boss/messages/${m.id}" style="font-family: var(--font-heading);">
                                <@spring.message "boss.messages.open_envelope"/>
                            </a>
                        </td>
                    </tr>
                </#list>
            <#else>
                <tr><td colspan="5" style="padding: 1.5rem; text-align: center; color: var(--text-muted);"><@spring.message "boss.messages.empty_inbox"/></td></tr>
            </#if>
            </tbody>
        </table>
    </div>

    <!-- Исходящие -->
    <h3 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">
        <@spring.message "boss.messages.outbox_title"/>
    </h3>
    <div class="table-responsive">
        <table class="speakeasy-table">
            <thead>
            <tr>
                <th><@spring.message "boss.messages.table.recipient"/></th>
                <th><@spring.message "boss.messages.table.subject"/></th>
                <th><@spring.message "boss.messages.table.time"/></th>
                <th><@spring.message "boss.messages.table.action"/></th>
            </tr>
            </thead>
            <tbody>
            <#if outbox?? && outbox?has_content>
                <#list outbox as m>
                    <tr>
                        <td style="color: var(--brass-gold);">${m.recipient.username} (${m.recipient.role})</td>
                        <td>${m.subject}</td>
                        <td style="color: var(--text-muted); font-size: 0.85rem;">${m.sentAt}</td>
                        <td>
                            <a href="/boss/messages/${m.id}" style="font-family: var(--font-heading);">
                                <@spring.message "boss.messages.view_btn"/>
                            </a>
                        </td>
                    </tr>
                </#list>
            <#else>
                <tr><td colspan="4" style="padding: 1.5rem; text-align: center; color: var(--text-muted);"><@spring.message "boss.messages.empty_outbox"/></td></tr>
            </#if>
            </tbody>
        </table>
    </div>

</@layout.page_layout>