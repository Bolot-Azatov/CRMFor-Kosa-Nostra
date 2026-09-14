<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('public.articles.header')} | Cosa Nostra" activeTab="articles">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text"><@spring.message "public.articles.header"/></h1>
            <p class="subtitle-text"><@spring.message "public.articles.subtitle"/></p>
        </div>
    </div>

    <#if articles?? && articles?has_content>
        <div class="articles-grid">
            <#list articles as article>
                <article class="article-card">
                    <!-- Штамп грифа секретности -->
                    <span style="position: absolute; top: 1rem; right: 1rem; font-size: 0.65rem; color: var(--burgundy-light); border: 1px solid var(--burgundy-light); padding: 2px 6px; text-transform: uppercase; letter-spacing: 1px; transform: rotate(4deg); opacity: 0.85; user-select: none;">
                        <@spring.message "public.articles.secret_stamp"/>
                    </span>

                    <div style="margin-bottom: 1.2rem;">
                        <span style="display: inline-block; font-family: var(--font-heading); font-size: 0.72rem; color: var(--brass-gold); background: var(--burgundy-dark); border: 1px solid rgba(197, 160, 89, 0.3); padding: 0.2rem 0.6rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 0.8rem;">
                            <@spring.message "public.articles.family_prefix"/> ${(article.familyName)!springMacroRequestContext.getMessage("public.articles.general_archive")}
                        </span>

                        <h2 style="font-family: var(--font-heading); font-size: 1.25rem; color: var(--text-main); line-height: 1.4; margin-bottom: 0.8rem; word-break: break-word;">
                            ${article.title}
                        </h2>

                        <!-- Превью текста (3 строки) -->
                        <p style="color: var(--text-muted); font-size: 0.88rem; line-height: 1.5; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; white-space: pre-wrap; margin: 0;">
                            ${article.content}
                        </p>
                    </div>

                    <div style="display: flex; justify-content: space-between; align-items: center; padding-top: 1rem; border-top: 1px dashed rgba(197, 160, 89, 0.2); font-size: 0.8rem;">
                        <span style="color: var(--text-muted);"><@spring.message "public.articles.case_prefix"/>${article.id}</span>
                        <a href="/articles/${article.id}" style="font-family: var(--font-heading); letter-spacing: 1px; text-transform: uppercase;">
                            <@spring.message "public.articles.read_full"/>
                        </a>
                    </div>
                </article>
            </#list>
        </div>
    <#else>
        <div style="text-align: center; padding: 4rem 2rem; background: var(--bg-card); border: var(--border-gold); color: var(--text-muted);">
            <div style="font-size: 3rem; margin-bottom: 1rem; color: var(--brass-gold);">📁</div>
            <h3 style="font-family: var(--font-heading); color: var(--brass-gold); margin-bottom: 0.5rem; text-transform: uppercase;">
                <@spring.message "public.articles.empty_title"/>
            </h3>
            <p><@spring.message "public.articles.empty_desc"/></p>
        </div>
    </#if>

</@layout.page_layout>