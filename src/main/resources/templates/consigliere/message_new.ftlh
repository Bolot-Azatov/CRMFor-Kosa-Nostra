<!-- src/main/resources/templates/consigliere/message_new.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Донесение Дону | Консильери" activeTab="message">

    <div style="max-width: 650px; margin: 0 auto; background: var(--bg-card); border: var(--border-gold); padding: 2.5rem; position: relative;">
        <h1 style="font-family: 'Cinzel', serif; font-size: 1.8rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.4rem;">
            Донесение Дону
        </h1>
        <p style="color: var(--text-muted); font-size: 0.8rem; text-transform: uppercase; margin-bottom: 1.8rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 0.8rem;">
            Зашифрованный канал связи Советника с Главой Семьи
        </p>

        <form action="/consigliere/messages/send" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div style="margin-bottom: 1.3rem;">
                <label style="display:block; font-family: 'Cinzel', serif; font-size: 0.8rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.4rem;">Тема доклада *</label>
                <input type="text" name="subject" placeholder="Аудит верфей Бруклина..." style="width: 100%; padding: 0.85rem; background: #121212; border: var(--border-gold); color: var(--text-main);" required />
            </div>

            <div style="margin-bottom: 1.5rem;">
                <label style="display:block; font-family: 'Cinzel', serif; font-size: 0.8rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.4rem;">Текст послания *</label>
                <textarea name="body" rows="6" placeholder="Дон, спешу доложить о ситуации..." style="width: 100%; padding: 0.85rem; background: #121212; border: var(--border-gold); color: var(--text-main);" required></textarea>
            </div>

            <button type="submit" style="width: 100%; padding: 0.9rem; background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%); color: #0A0A0A; font-family: 'Cinzel', serif; font-weight: bold; text-transform: uppercase; border: none; cursor: pointer;">
                Опечатать сургучом и отправить
            </button>
        </form>
    </div>

</@layout.page_layout>