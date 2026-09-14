<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${(article.title)!springMacroRequestContext.getMessage('public.article.not_found')} | Cosa Nostra" activeTab="articles">

    <div style="max-width: 820px; margin: 0 auto;">
        <#if article??>
            <div class="article-paper">
                <!-- Сургучный штамп архива -->
                <div class="stamp-top-right" style="border: 2px solid var(--burgundy-light); color: #FF6666; padding: 0.3rem 0.8rem; font-family: var(--font-heading); font-size: 0.8rem; letter-spacing: 2px; text-transform: uppercase;">
                    <@spring.message "public.article.stamp"/>
                </div>

                <div style="border-bottom: 1px solid rgba(197, 160, 89, 0.25); padding-bottom: 1.5rem; margin-bottom: 2rem;">
                    <span style="display: inline-block; background: var(--burgundy-dark); color: var(--brass-gold); border: 1px solid rgba(197, 160, 89, 0.4); padding: 0.25rem 0.6rem; font-size: 0.75rem; font-family: var(--font-heading); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 1rem;">
                        <@spring.message "public.articles.family_prefix"/> ${(article.familyName)!springMacroRequestContext.getMessage("public.articles.general_archive")}
                    </span>
                    <h1 class="article-title" style="font-family: var(--font-heading); color: var(--brass-gold); line-height: 1.3; letter-spacing: 2px; word-break: break-word;">
                        ${article.title}
                    </h1>
                </div>

                <div style="line-height: 1.9; font-size: 1rem; color: var(--text-main); white-space: pre-line; word-break: break-word; margin-bottom: 2.5rem;">
                    ${article.content}
                </div>

                <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px dashed rgba(197, 160, 89, 0.2); padding-top: 1.5rem; flex-wrap: wrap; gap: 0.8rem;">
                    <a href="/articles" style="font-family: var(--font-heading); font-size: 0.85rem; letter-spacing: 1px; text-transform: uppercase;">
                        <@spring.message "public.article.back_to_list"/>
                    </a>
                    <span style="font-size: 0.75rem; color: var(--text-muted);"><@spring.message "public.article.protocol_prefix"/>${article.id}</span>
                </div>
            </div>
        <#else>
            <div style="text-align: center; padding: 4rem; background: var(--bg-card); border: var(--border-gold);">
                <h2 style="font-family: var(--font-heading); color: var(--brass-gold); text-transform: uppercase;"><@spring.message "public.article.not_found"/></h2>
                <a href="/articles" style="margin-top: 1.5rem; display: inline-block; font-family: var(--font-heading); text-transform: uppercase;">
                    <@spring.message "public.article.back_to_archive"/>
                </a>
            </div>
        </#if>
    </div>

</@layout.page_layout>