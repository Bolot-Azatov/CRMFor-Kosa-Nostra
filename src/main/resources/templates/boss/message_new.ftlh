<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('boss.message_new.title')} | ${springMacroRequestContext.getMessage('role.boss.badge')}" activeTab="messages">

    <div style="max-width: 650px; margin: 0 auto; background: var(--bg-card); border: var(--border-gold); padding: clamp(1.5rem, 4vw, 2.5rem); box-shadow: var(--box-shadow-card);">
        <h1 style="font-family: var(--font-heading); font-size: 1.8rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.4rem;">
            <@spring.message "boss.message_new.title"/>
        </h1>
        <p style="color: var(--text-muted); font-size: 0.8rem; text-transform: uppercase; margin-bottom: 1.5rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 0.8rem;">
            <@spring.message "boss.message_new.subtitle"/>
        </p>

        <form action="/boss/messages/send" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div class="form-group">
                <label class="form-label"><@spring.message "boss.message_new.recipient"/></label>
                <select name="recipientId" class="form-select" required>
                    <option value="" disabled <#if !(messageRequest.recipientId)??>selected</#if>>-- <@spring.message "boss.message_new.recipient"/> --</option>
                    <#if recipients?? && recipients?has_content>
                        <#list recipients as r>
                            <option value="${r.id}" <#if (messageRequest.recipientId!0) == r.id>selected</#if>>
                                ${r.username} — ${r.role} (${(r.family.name)!springMacroRequestContext.getMessage('profile.no_family')})
                            </option>
                        </#list>
                    <#else>
                        <option disabled><@spring.message "boss.message_new.no_recipients"/></option>
                    </#if>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label"><@spring.message "boss.message_new.subject"/></label>
                <input type="text"
                       name="subject"
                       value="${(messageRequest.subject)!''}"
                       class="form-input"
                       placeholder="<@spring.message 'boss.message_new.subject_placeholder'/>"
                       required />
            </div>

            <div class="form-group">
                <label class="form-label"><@spring.message "boss.message_new.body"/></label>
                <textarea name="body"
                          rows="6"
                          class="form-textarea"
                          placeholder="<@spring.message 'boss.message_new.body_placeholder'/>"
                          style="resize: vertical;"
                          required>${(messageRequest.body)!''}</textarea>
            </div>

            <button type="submit" class="btn-submit">
                <@spring.message "boss.message_new.submit"/>
            </button>
        </form>
    </div>

</@layout.page_layout>