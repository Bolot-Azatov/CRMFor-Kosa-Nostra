<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Почтовый Ящик | Дон" activeTab="messages">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text">Тайная Почта Дона</h1>
            <p class="subtitle-text">Переписка с Капо, Консильери и Боссами Синдиката</p>
        </div>
        <a href="/boss/messages/new" class="btn-gold" style="width: auto; padding: 0.7rem 1.4rem;">
            ✉ Написать депешу
        </a>
    </div>

    <!-- Входящие -->
    <h3 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">
        Входящие донесения
    </h3>
    <div class="table-responsive">
        <table class="speakeasy-table" style="margin-bottom: 2.5rem;">
            <thead>
            <tr>
                <th>Статус</th>
                <th>Отправитель</th>
                <th>Тема</th>
                <th>Время</th>
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
                        <td style="color: var(--brass-gold);">${m.sender.username} (${m.sender.role})</td>
                        <td style="font-weight: bold;">${m.subject}</td>
                        <td style="color: var(--text-muted); font-size: 0.85rem;">${m.sentAt}</td>
                        <td>
                            <a href="/boss/messages/${m.id}" style="font-family: var(--font-heading);">
                                Вскрыть конверт →
                            </a>
                        </td>
                    </tr>
                </#list>
            <#else>
                <tr><td colspan="5" style="padding: 1.5rem; text-align: center; color: var(--text-muted);">Входящих писем нет.</td></tr>
            </#if>
            </tbody>
        </table>
    </div>

    <!-- Исходящие -->
    <h3 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase; margin-bottom: 1rem;">
        Отправленные распоряжения
    </h3>
    <div class="table-responsive">
        <table class="speakeasy-table">
            <thead>
            <tr>
                <th>Получатель</th>
                <th>Тема</th>
                <th>Время</th>
                <th>Действие</th>
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
                                Просмотр →
                            </a>
                        </td>
                    </tr>
                </#list>
            <#else>
                <tr><td colspan="4" style="padding: 1.5rem; text-align: center; color: var(--text-muted);">Отправленных депеш нет.</td></tr>
            </#if>
            </tbody>
        </table>
    </div>

</@layout.page_layout>