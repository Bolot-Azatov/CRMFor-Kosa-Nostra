<!-- src/main/resources/templates/boss/businesses.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Бизнесы Семьи | Дон" activeTab="businesses">

    <style>
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            border-bottom: 1px solid rgba(197,160,89,0.2);
            padding-bottom: 1rem;
        }
        .biz-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--bg-card);
            border: var(--border-gold);
            margin-bottom: 2.5rem;
        }
        .biz-table th {
            background-color: var(--burgundy-dark);
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
            padding: 0.9rem;
            text-align: left;
            border-bottom: 1px solid var(--brass-gold);
        }
        .biz-table td {
            padding: 0.9rem;
            border-bottom: 1px solid rgba(197,160,89,0.15);
        }
        .assign-card {
            background: var(--bg-card);
            border: var(--border-gold);
            padding: 2rem;
            max-width: 650px;
        }
    </style>

    <div class="page-header">
        <div>
            <h1 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 2rem; margin: 0;">Предприятия и Рэкет Семьи</h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">Контроль доходных точек и ответственные Капореджиме</p>
        </div>
        <a href="/boss" style="color: var(--brass-gold); text-decoration: none; font-family: 'Cinzel', serif;">← В Кабинет Дона</a>
    </div>

    <#if businesses?? && businesses?has_content>
        <table class="biz-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Предприятие</th>
                <th>Отрасль</th>
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
                    <td style="color: #81C784; font-family: 'Cinzel', serif; font-weight: bold;">$${b.weeklyRevenue?string[",##0.00"]}</td>
                    <td>
                        <#if b.capo??>
                            <span style="color: var(--brass-gold);">${b.capo.username}</span>
                        <#else>
                            <span style="color: #FF7777;">Не закреплен</span>
                        </#if>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    </#if>

    <!-- Форма закрепления бизнеса за Капо -->
    <div class="assign-card">
        <h2 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 1.2rem; margin-bottom: 1.2rem; text-transform: uppercase;">
            ⚖ Закрепить предприятие за Капо (1 Капо = 1 Бизнес)
        </h2>
        <form action="/boss/businesses/assign" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div style="margin-bottom: 1rem;">
                <label style="display:block; font-family: 'Cinzel', serif; font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; margin-bottom: 0.3rem;">Выберите предприятие *</label>
                <select name="businessId" style="width: 100%; padding: 0.7rem; background: #121212; border: var(--border-gold); color: var(--text-main);" required>
                    <#list businesses as b>
                        <option value="${b.id}">${b.name} (${b.type})</option>
                    </#list>
                </select>
            </div>

            <div style="margin-bottom: 1.5rem;">
                <label style="display:block; font-family: 'Cinzel', serif; font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; margin-bottom: 0.3rem;">Выберите Капо *</label>
                <select name="capoId" style="width: 100%; padding: 0.7rem; background: #121212; border: var(--border-gold); color: var(--text-main);" required>
                    <#if capos?? && capos?has_content>
                        <#list capos as c>
                            <option value="${c.id}">${c.username}</option>
                        </#list>
                    <#else>
                        <option disabled>В семье пока нет назначенных Капо</option>
                    </#if>
                </select>
            </div>

            <button type="submit" style="padding: 0.8rem 1.6rem; background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%); color: #0A0A0A; border: none; font-family: 'Cinzel', serif; font-weight: bold; cursor: pointer; text-transform: uppercase;">
                Закрепить точку
            </button>
        </form>
    </div>

</@layout.page_layout>