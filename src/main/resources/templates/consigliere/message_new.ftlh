<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('consigliere.message_new.title')} | ${springMacroRequestContext.getMessage('role.consigliere.title')}" activeTab="message">

    <div style="max-width: 650px; margin: 0 auto; background: var(--bg-card); border: var(--border-gold); padding: clamp(1.5rem, 4vw, 2.5rem); position: relative; box-shadow: var(--box-shadow-card);">
        <h1 style="font-family: var(--font-heading); font-size: 1.8rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.4rem;">
            <@spring.message "consigliere.message_new.title"/>
        </h1>
        <p style="color: var(--text-muted); font-size: 0.8rem; text-transform: uppercase; margin-bottom: 1.8rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 0.8rem;">
            <@spring.message "consigliere.message_new.subtitle"/>
        </p>

        <form action="/consigliere/messages/send" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div class="form-group">
                <label class="form-label"><@spring.message "consigliere.message_new.subject"/></label>
                <input type="text" name="subject" class="form-input" placeholder="Brooklyn Dock Audit..." required />
            </div>

            <div class="form-group">
                <label class="form-label"><@spring.message "consigliere.message_new.body"/></label>
                <textarea name="body" rows="6" class="form-textarea" placeholder="..." style="resize: vertical;" required></textarea>
            </div>

            <button type="submit" class="btn-submit">
                <@spring.message "consigliere.message_new.submit"/>
            </button>
        </form>
    </div>

</@layout.page_layout>