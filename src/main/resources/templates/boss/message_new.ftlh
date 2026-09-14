<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Создать Депешу | Дон" activeTab="messages">

    <div style="max-width: 650px; margin: 0 auto; background: var(--bg-card); border: var(--border-gold); padding: clamp(1.5rem, 4vw, 2.5rem); box-shadow: var(--box-shadow-card);">
        <h1 style="font-family: var(--font-heading); font-size: 1.8rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.4rem;">
            Приказ / Депеша Дона
        </h1>
        <p style="color: var(--text-muted); font-size: 0.8rem; text-transform: uppercase; margin-bottom: 1.5rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 0.8rem;">
            Адресаты: свои Капо, свой Консильери или Боссы других 4 семей
        </p>

        <form action="/boss/messages/send" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div class="form-group">
                <label class="form-label">Получатель *</label>
                <select name="recipientId" class="form-select" required>
                    <#if recipients?? && recipients?has_content>
                        <#list recipients as r>
                            <option value="${r.id}">${r.username} — ${r.role} (${(r.family.name)!'Без семьи'})</option>
                        </#list>
                    <#else>
                        <option disabled>Нет доступных адресатов</option>
                    </#if>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label">Тема депеши *</label>
                <input type="text" name="subject" class="form-input" placeholder="Срочный сбор в Гарлеме..." required />
            </div>

            <div class="form-group">
                <label class="form-label">Текст распоряжения *</label>
                <textarea name="body" rows="6" class="form-textarea" placeholder="Изложите суть распоряжения..." style="resize: vertical;" required></textarea>
            </div>

            <button type="submit" class="btn-submit">
                Скрепить печатью и отправить
            </button>
        </form>
    </div>

</@layout.page_layout>