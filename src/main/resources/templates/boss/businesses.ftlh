<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Предприятия Семьи | Дон" activeTab="racket">

    <style>
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.2);
            padding-bottom: 1rem;
        }

        .title-text {
            font-family: 'Cinzel', serif;
            font-size: 2rem;
            color: var(--brass-gold);
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .biz-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--bg-card);
            border: var(--border-gold);
            font-size: 0.9rem;
        }

        .biz-table th {
            background-color: var(--burgundy-dark);
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
            text-transform: uppercase;
            padding: 1rem;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--brass-gold);
            text-align: left;
        }

        .biz-table td {
            padding: 1rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.15);
            color: var(--text-main);
        }

        .biz-table tr:hover {
            background: rgba(197, 160, 89, 0.05);
        }
    </style>

    <div class="page-header">
        <div>
            <h1 class="title-text">Бизнесы и Рэкет Семьи</h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">Контролируемые предприятия и ответственные Капо</p>
        </div>
        <a href="/boss" style="color: var(--brass-gold); text-decoration: none; font-family: 'Cinzel', serif;">← В кабинет Дона</a>
    </div>

    <#if businesses?? && businesses?has_content>
        <table class="biz-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Наименование предприятия</th>
                <th>Тип деятельности</th>
                <th>Недельная выручка</th>
                <th>Ответственный Капо</th>
            </tr>
            </thead>
            <tbody>
            <#list businesses as b>
                <tr>
                    <td>#${b.id}</td>
                    <td style="color: var(--brass-gold); font-weight: bold;">${b.name}</td>
                    <td>${b.type}</td>
                    <td style="color: #81C784; font-family: 'Cinzel', serif; font-weight: bold;">
                        $${b.weeklyRevenue?string[",##0.00"]}
                    </td>
                    <td>
                        <#if b.capo??>
                            <span style="color: var(--brass-gold);">${b.capo.username}</span>
                        <#else>
                            <span style="color: var(--text-muted);">Не назначен</span>
                        </#if>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <div style="text-align: center; padding: 3rem; background: var(--bg-card); border: var(--border-gold);">
            <p style="color: var(--text-muted);">Под контролем семьи пока нет предприятий.</p>
        </div>
    </#if>

</@layout.page_layout>