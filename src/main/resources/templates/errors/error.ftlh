<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Ошибка ${status!500} | Cosa Nostra">
    <div style="max-width: 650px; margin: 3rem auto; background: var(--bg-card); border: 1px solid var(--burgundy-light); padding: 2.5rem; box-shadow: 0 0 30px rgba(0,0,0,0.85); position: relative;">
        <div style="border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 1rem; margin-bottom: 1.5rem; display: flex; justify-content: space-between; align-items: center;">
            <h2 style="font-family: 'Cinzel', serif; color: #FF6666; margin: 0; font-size: 1.6rem; text-transform: uppercase;">
                ⚠️ ${errorTitle!"Произошла ошибка"}
            </h2>
            <span style="font-family: 'Cinzel', serif; background: var(--burgundy-dark); color: var(--brass-gold); border: 1px solid var(--brass-gold); padding: 0.2rem 0.6rem; font-size: 0.9rem;">
                ${status!500}
            </span>
        </div>

        <p style="font-size: 1rem; color: var(--text-main); line-height: 1.7; margin-bottom: 1.5rem;">
            ${message!"Произошла непредвиденная ошибка при обработке распоряжения."}
        </p>

        <div style="background: #121212; border: 1px solid rgba(255,255,255,0.1); padding: 0.8rem; font-size: 0.78rem; color: var(--text-muted); margin-bottom: 2rem;">
            <#if path??>
                <div><strong>Секция запроса:</strong> <code>${path}</code></div>
            </#if>
            <#if timestamp??>
                <div><strong>Время протокола:</strong> ${timestamp}</div>
            </#if>
        </div>

        <div style="display: flex; justify-content: space-between; gap: 1rem;">
            <a href="javascript:history.back()" style="color: var(--brass-gold); text-decoration: none; font-family: 'Cinzel', serif; font-size: 0.85rem; padding: 0.6rem 1rem; border: var(--border-gold); text-transform: uppercase;">
                ← Назад
            </a>
            <a href="/" style="background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%); color: #0A0A0A; text-decoration: none; font-family: 'Cinzel', serif; font-weight: bold; font-size: 0.85rem; padding: 0.6rem 1.2rem; text-transform: uppercase;">
                На главную
            </a>
        </div>
    </div>
</@layout.page_layout>