<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${(article.title)!'Дело архива'} | Cosa Nostra" activeTab="articles">

    <style>
        .article-container {
            max-width: 820px;
            margin: 0 auto;
        }

        .article-paper {
            background: var(--bg-card);
            border: var(--border-gold);
            padding: 3rem;
            position: relative;
            box-shadow: 0 0 50px rgba(0, 0, 0, 0.9), inset 0 0 25px rgba(61, 12, 2, 0.3);
        }

        .stamp-top-right {
            position: absolute;
            top: 2rem;
            right: 2rem;
            border: 2px solid var(--burgundy-light);
            color: #FF6666;
            padding: 0.3rem 0.8rem;
            font-family: 'Cinzel', serif;
            font-size: 0.8rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            transform: rotate(4deg);
            opacity: 0.85;
        }

        .article-header {
            border-bottom: 1px solid rgba(197, 160, 89, 0.25);
            padding-bottom: 1.5rem;
            margin-bottom: 2rem;
        }

        .family-tag {
            display: inline-block;
            background: var(--burgundy-dark);
            color: var(--brass-gold);
            border: 1px solid rgba(197, 160, 89, 0.4);
            padding: 0.2rem 0.6rem;
            font-size: 0.75rem;
            font-family: 'Cinzel', serif;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 1rem;
        }

        .article-title {
            font-family: 'Cinzel', serif;
            font-size: 2.2rem;
            color: var(--brass-gold);
            line-height: 1.3;
            letter-spacing: 2px;
        }

        .article-body {
            line-height: 1.9;
            font-size: 1rem;
            color: var(--text-main);
            white-space: pre-line;
            margin-bottom: 2.5rem;
        }

        .article-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px dashed rgba(197, 160, 89, 0.2);
            padding-top: 1.5rem;
        }

        .btn-back {
            color: var(--brass-gold);
            text-decoration: none;
            font-family: 'Cinzel', serif;
            font-size: 0.85rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: color 0.2s ease;
        }

        .btn-back:hover {
            color: var(--brass-gold-hover);
            text-decoration: underline;
        }
    </style>

    <div class="article-container">
        <#if article??>
            <div class="article-paper">
                <span class="stamp-top-right">Архив Синдиката</span>

                <div class="article-header">
                    <span class="family-tag">Семья: ${(article.familyName)!'Общий архив'}</span>
                    <h1 class="article-title">${article.title}</h1>
                </div>

                <div class="article-body">
                    ${article.content}
                </div>

                <div class="article-actions">
                    <a href="/articles" class="btn-back">← Вернуться ко всем сводкам</a>
                    <span style="font-size: 0.75rem; color: var(--text-muted);">Протокол #${article.id}</span>
                </div>
            </div>
        <#else>
            <div style="text-align: center; padding: 4rem;">
                <h2 style="font-family: 'Cinzel', serif; color: var(--brass-gold);">Дело не найдено</h2>
                <a href="/articles" class="btn-back" style="margin-top: 1rem; display: inline-block;">Вернуться к архиву</a>
            </div>
        </#if>
    </div>

</@layout.page_layout>