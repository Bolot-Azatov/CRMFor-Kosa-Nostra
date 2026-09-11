<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Архив Сводок | Cosa Nostra" activeTab="articles">

    <style>
        /* Верхняя панель управления заголовком и кнопкой создания */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.2);
        }

        .page-title {
            font-family: 'Cinzel', serif;
            font-size: 2rem;
            color: var(--brass-gold);
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 0 2px 8px rgba(0, 0, 0, 0.8);
        }

        .btn-create {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 0.7rem 1.4rem;
            font-family: 'Cinzel', serif;
            font-size: 0.85rem;
            font-weight: bold;
            color: #0A0A0A;
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 1px;
            border: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
        }

        .btn-create:hover {
            background: linear-gradient(180deg, var(--brass-gold-hover) 0%, var(--brass-gold) 100%);
            box-shadow: 0 0 15px rgba(197, 160, 89, 0.4);
            transform: translateY(-2px);
        }

        /* Сетка карточек статей */
        .articles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 1.8rem;
        }

        /* Карточка статьи / Сводки */
        .article-card {
            background-color: var(--bg-card);
            border: var(--border-gold);
            padding: 1.8rem;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.6);
        }

        .article-card:hover {
            border-color: var(--brass-gold-hover);
            box-shadow: 0 0 25px rgba(197, 160, 89, 0.25);
            transform: translateY(-3px);
        }

        /* Декоративный гриф секретности */
        .confidential-stamp {
            position: absolute;
            top: 1rem;
            right: 1rem;
            font-size: 0.65rem;
            color: var(--burgundy-light);
            border: 1px solid var(--burgundy-light);
            padding: 2px 6px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transform: rotate(4deg);
            opacity: 0.8;
            user-select: none;
        }

        .article-header {
            margin-bottom: 1rem;
        }

        .family-badge {
            display: inline-block;
            font-family: 'Cinzel', serif;
            font-size: 0.75rem;
            color: var(--brass-gold);
            background: var(--burgundy-dark);
            border: 1px solid rgba(197, 160, 89, 0.3);
            padding: 0.25rem 0.6rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.8rem;
        }

        .article-title {
            font-family: 'Cinzel', serif;
            font-size: 1.25rem;
            color: var(--text-main);
            line-height: 1.4;
            margin-bottom: 0.8rem;
        }

        /* Ограничение предпросмотра текста (3 строки) */
        .article-content-preview {
            color: var(--text-muted);
            font-size: 0.88rem;
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-bottom: 1.5rem;
            white-space: pre-wrap;
        }

        .article-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 1rem;
            border-top: 1px dashed rgba(197, 160, 89, 0.2);
        }

        .article-link {
            font-family: 'Cinzel', serif;
            font-size: 0.8rem;
            color: var(--brass-gold);
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: color 0.2s ease;
        }

        .article-link:hover {
            color: var(--brass-gold-hover);
            text-shadow: 0 0 5px rgba(197, 160, 89, 0.5);
        }

        /* Пустое состояние (если статей нет) */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--bg-card);
            border: var(--border-gold);
            color: var(--text-muted);
        }

        .empty-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--brass-gold);
        }
    </style>

    <!-- Заголовок страницы -->
    <div class="page-header">
        <div>
            <h1 class="page-title">Сводки и архивы</h1>
            <p style="color: var(--text-muted); font-size: 0.82rem; margin-top: 0.3rem;">Конфиденциальные донесения семей Синдиката</p>
        </div>
    </div>

    <!-- Проверка наличия статей в модели (модель ожидает список "articles") -->
    <#if articles?? && articles?has_content>
        <div class="articles-grid">
            <#list articles as article>
                <article class="article-card">
                    <span class="confidential-stamp">Секретно</span>

                    <div>
                        <div class="article-header">
                            <!-- Семья автора -->
                            <span class="family-badge">Семья: ${article.familyName!"Неизвестно"}</span>

                            <!-- Название статьи -->
                            <h2 class="article-title">${article.title}</h2>
                        </div>

                        <!-- Содержание (Предпросмотр) -->
                        <p class="article-content-preview">${article.content}</p>
                    </div>

                    <div class="article-footer">
                        <span style="font-size: 0.75rem; color: var(--text-muted);">Дело #${article.id}</span>
                        <a href="/articles/${article.id}" class="article-link">Читать полностью →</a>
                    </div>
                </article>
            </#list>
        </div>
    <#else>
        <!-- Если список пуст -->
        <div class="empty-state">
            <div class="empty-icon">📁</div>
            <h3 style="font-family: 'Cinzel', serif; color: var(--brass-gold); margin-bottom: 0.5rem;">Архив пуст</h3>
            <p>В архивах Синдиката пока нет ни одной опубликованной сводки.</p>
        </div>
    </#if>

</@layout.page_layout>