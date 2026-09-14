<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Ошибка ${status!500} | Cosa Nostra">
    <div style="max-width: 650px; margin: 2rem auto; background: var(--bg-card); border: 1px solid var(--burgundy-light); padding: clamp(1.5rem, 4vw, 2.5rem); box-shadow: 0 0 30px rgba(0,0,0,0.85); position: relative;">

        <div style="border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 1rem; margin-bottom: 1.5rem; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 0.8rem;">
            <h2 style="font-family: var(--font-heading); color: #FF6666; margin: 0; font-size: 1.4rem; text-transform: uppercase; word-break: break-word;">
                ⚠️ ${errorTitle!"Произошла ошибка"}
            </h2>
            <span style="font-family: var(--font-heading); background: var(--burgundy-dark); color: var(--brass-gold); border: 1px solid var(--brass-gold); padding: 0.2rem 0.6rem; font-size: 0.9rem;">
                ${status!500}
            </span>
        </div>

        <p style="font-size: 0.95rem; color: var(--text-main); line-height: 1.7; margin-bottom: 1.5rem; word-break: break-word;">
            ${message!"Произошла непредвиденная ошибка при обработке распоряжения."}
        </p>

        <div style="background: #121212; border: 1px solid rgba(255,255,255,0.1); padding: 0.8rem 1rem; font-size: 0.78rem; color: var(--text-muted); margin-bottom: 2rem; word-break: break-all;">
            <#if path??>
                <div><strong>Секция запроса:</strong> <code>${path}</code></div>
            </#if>
            <#if timestamp??>
                <div style="margin-top: 0.3rem;"><strong>Время протокола:</strong> ${timestamp}</div>
            </#if>
        </div>

        <div style="display: flex; justify-content: space-between; gap: 1rem; flex-wrap: wrap;">
            <a href="javascript:history.back()" class="btn-secondary" style="width: auto; padding: 0.6rem 1.2rem;">
                ← Назад
            </a>
            <a href="/" class="btn-primary" style="width: auto; padding: 0.6rem 1.2rem;">
                На главную
            </a>
        </div>
    </div>
</@layout.page_layout>