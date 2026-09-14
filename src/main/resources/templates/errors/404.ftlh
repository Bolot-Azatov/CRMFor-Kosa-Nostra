<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title=springMacroRequestContext.getMessage("error.404.title")>
    <div style="max-width: 600px; margin: 3rem auto; text-align: center; background: var(--bg-card); border: 1px solid var(--burgundy-light); padding: clamp(1.5rem, 4vw, 3rem); box-shadow: 0 0 35px rgba(0,0,0,0.9);">
        <div style="font-size: 3rem; margin-bottom: 1rem;">🗂️</div>
        <h1 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: clamp(1.4rem, 4vw, 2.2rem); letter-spacing: 2px; text-transform: uppercase; margin-bottom: 1rem; word-break: break-word;">
            <@spring.message "error.404.heading"/>
        </h1>
        <p style="color: var(--text-muted); font-size: 0.95rem; line-height: 1.7; margin-bottom: 2rem;">
            <@spring.message "error.404.desc"/>
        </p>
        <a href="/" class="btn-primary" style="display: inline-block; width: auto; padding: 0.8rem 1.6rem;">
            <@spring.message "error.404.btn"/>
        </a>
    </div>
</@layout.page_layout>