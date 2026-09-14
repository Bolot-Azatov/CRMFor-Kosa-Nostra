<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('consigliere.messages.title')} | ${springMacroRequestContext.getMessage('role.consigliere.title')}" activeTab="message">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text"><@spring.message "consigliere.messages.title"/></h1>
            <p class="subtitle-text"><@spring.message "consigliere.messages.subtitle"/></p>
        </div>
        <a href="/consigliere/messages/new" class="btn-gold" style="width: auto; padding: 0.7rem 1.4rem;">
            ✉ <@spring.message "consigliere.messages.btn_new"/>
        </a>
    </div>

    <!-- Входящие -->
    <h3 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">
        <@spring.message "consigliere.messages.inbox_title"/>
    </h3>
    <div class="table-responsive">
        <table class="speakeasy-table" style="margin-bottom: 2.5rem;">
            <thead>
            <tr>
                <th><@spring.message "consigliere.messages.table.status"/></th>
                <th><@spring.message "consigliere.messages.table.sender"/></th>
                <th><@spring.message "consigliere.messages.table.subject"/></th>
                <th><@spring.message "consigliere.messages.table.date"/></th>
                <th><@spring.message "consigliere.messages.table.action"/></th>
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
                                <span style="color: #FF5555; font-weight: bold;">● <@spring.message "boss.messages.status.new"/></span>
                            </#if>
                        </td>
                        <td style="color: var(--brass-gold);">${m.sender.username}</td>
                        <td style="font-weight: bold;">${m.subject}</td>
                        <td style="color: var(--text-muted);">${m.sentAt}</td>
                        <td>
                            <a href="/consigliere/messages/${m.id}" style="font-family: var(--font-heading);">
                                <@spring.message "consigliere.messages.read"/> →
                            </a>
                        </td>
                    </tr>
                </#list>
            <#else>
                <tr><td colspan="5" style="padding: 1.5rem; text-align: center; color: var(--text-muted);"><@spring.message "consigliere.messages.empty_inbox"/></td></tr>
            </#if>
            </tbody>
        </table>
    </div>

    <!-- Исходящие -->
    <h3 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">
        <@spring.message "consigliere.messages.outbox_title"/>
    </h3>
    <div class="table-responsive">
        <table class="speakeasy-table">
            <thead>
            <tr>
                <th><@spring.message "consigliere.messages.table.recipient"/></th>
                <th><@spring.message "consigliere.messages.table.subject"/></th>
                <th><@spring.message "consigliere.messages.table.date"/></th>
                <th><@spring.message "consigliere.messages.table.action"/></th>
            </tr>
            </thead>
            <tbody>
            <#if outbox?? && outbox?has_content>
                <#list outbox as m>
                    <tr>
                        <td style="color: var(--brass-gold);">${m.recipient.username}</td>
                        <td>${m.subject}</td>
                        <td style="color: var(--text-muted);">${m.sentAt}</td>
                        <td>
                            <a href="/consigliere/messages/${m.id}" style="font-family: var(--font-heading);">
                                <@spring.message "consigliere.messages.view"/> →
                            </a>
                        </td>
                    </tr>
                </#list>
            <#else>
                <tr><td colspan="4" style="padding: 1.5rem; text-align: center; color: var(--text-muted);"><@spring.message "consigliere.messages.empty_outbox"/></td></tr>
            </#if>
            </tbody>
        </table>
    </div>

</@layout.page_layout>