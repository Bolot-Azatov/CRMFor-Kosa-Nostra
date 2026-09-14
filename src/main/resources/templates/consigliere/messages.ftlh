<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Почтовый Ящик | Консильери" activeTab="message">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text">Тайная Почта Консильери</h1>
            <p class="subtitle-text">Секретные депеши и донесения Дону</p>
        </div>
        <a href="/consigliere/messages/new" class="btn-gold" style="width: auto; padding: 0.7rem 1.4rem;">
            ✉ Донесение Дону
        </a>
    </div>

    <!-- Входящие -->
    <h3 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">
        Входящие депеши
    </h3>
    <div class="table-responsive">
        <table class="speakeasy-table" style="margin-bottom: 2.5rem;">
            <thead>
            <tr>
                <th>Статус</th>
                <th>От кого</th>
                <th>Тема</th>
                <th>Дата</th>
                <th>Действие</th>
            </tr>
            </thead>
            <tbody>
            <#if inbox?? && inbox?has_content>
                <#list inbox as m>
                    <tr <#if !m.read>style="background: rgba(197,160,89,0.08);"</#if>>
                        <td>
                            <#if m.read>
                                <span style="color: var(--text-muted);">Прочитано</span>
                            <#else>
                                <span style="color: #FF5555; font-weight: bold;">● НОВОЕ</span>
                            </#if>
                        </td>
                        <td style="color: var(--brass-gold);">${m.sender.username}</td>
                        <td style="font-weight: bold;">${m.subject}</td>
                        <td style="color: var(--text-muted);">${m.sentAt}</td>
                        <td>
                            <a href="/consigliere/messages/${m.id}" style="font-family: var(--font-heading);">
                                Читать →
                            </a>
                        </td>
                    </tr>
                </#list>
            <#else>
                <tr><td colspan="5" style="padding: 1.5rem; text-align: center; color: var(--text-muted);">Входящих посланий нет.</td></tr>
            </#if>
            </tbody>
        </table>
    </div>

    <!-- Исходящие -->
    <h3 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">
        Исходящие донесения
    </h3>
    <div class="table-responsive">
        <table class="speakeasy-table">
            <thead>
            <tr>
                <th>Адресат</th>
                <th>Тема</th>
                <th>Дата</th>
                <th>Действие</th>
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
                                Просмотр →
                            </a>
                        </td>
                    </tr>
                </#list>
            <#else>
                <tr><td colspan="4" style="padding: 1.5rem; text-align: center; color: var(--text-muted);">Исходящих донесений нет.</td></tr>
            </#if>
            </tbody>
        </table>
    </div>

</@layout.page_layout>