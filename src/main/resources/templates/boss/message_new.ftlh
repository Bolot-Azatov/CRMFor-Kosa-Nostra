<!-- src/main/resources/templates/boss/message_new.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Создать Депешу | Дон" activeTab="messages">

    <div style="max-width: 650px; margin: 0 auto; background: var(--bg-card); border: var(--border-gold); padding: 2.5rem; box-shadow: 0 4px 25px rgba(0, 0, 0, 0.8);">
        <h1 style="font-family: 'Cinzel', serif; font-size: 1.8rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.4rem;">
            Приказ / Депеша Дона
        </h1>
        <p style="color: var(--text-muted); font-size: 0.8rem; text-transform: uppercase; margin-bottom: 1.5rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 0.8rem;">
            Адресаты: свои Капо, свой Консильери или Боссы других 4 семей
        </p>

        <form action="/boss/messages/send" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div style="margin-bottom: 1.2rem;">
                <label style="display:block; font-family: 'Cinzel', serif; font-size: 0.8rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.3rem;">Получатель *</label>
                <select name="recipientId" style="width: 100%; padding: 0.8rem; background: #121212; border: var(--border-gold); color: var(--text-main);" required>
                    <#if recipients?? && recipients?has_content>
                        <#list recipients as r>
                            <option value="${r.id}">${r.username} — ${r.role} (${(r.family.name)!'Без семьи'})</option>
                        </#list>
                    <#else>
                        <option disabled>Нет доступных адресатов</option>
                    </#if>
                </select>
            </div>

            <div style="margin-bottom: 1.2rem;">
                <label style="display:block; font-family: 'Cinzel', serif; font-size: 0.8rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.3rem;">Тема депеши *</label>
                <input type="text" name="subject" placeholder="Срочный сбор в Гарлеме..." style="width: 100%; padding: 0.8rem; background: #121212; border: var(--border-gold); color: var(--text-main);" required />
            </div>

            <div style="margin-bottom: 1.5rem;">
                <label style="display:block; font-family: 'Cinzel', serif; font-size: 0.8rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.3rem;">Текст распоряжения *</label>
                <textarea name="body" rows="6" placeholder="Изложите суть распоряжения..." style="width: 100%; padding: 0.8rem; background: #121212; border: var(--border-gold); color: var(--text-main);" required></textarea>
            </div>

            <button type="submit" style="width: 100%; padding: 0.9rem; background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%); color: #0A0A0A; font-family: 'Cinzel', serif; font-weight: bold; text-transform: uppercase; border: none; cursor: pointer;">
                Скрепить печатью и отправить
            </button>
        </form>
    </div>

</@layout.page_layout>