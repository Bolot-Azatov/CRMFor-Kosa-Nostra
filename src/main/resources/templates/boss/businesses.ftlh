<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Бизнесы Семьи | Дон" activeTab="businesses">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text">Предприятия и Рэкет Семьи</h1>
            <p class="subtitle-text">Контроль доходных точек и ответственные Капореджиме</p>
        </div>
        <a href="/boss" style="font-family: var(--font-heading);">← В Кабинет Дона</a>
    </div>

    <#if businesses?? && businesses?has_content>
        <div class="table-responsive">
            <table class="speakeasy-table">
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
                        <td style="color: #81C784; font-family: var(--font-heading); font-weight: bold;">
                            $${b.weeklyRevenue?string[",##0.00"]}
                        </td>
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
        </div>
    </#if>

    <!-- Форма закрепления бизнеса за Капо -->
    <div style="background: var(--bg-card); border: var(--border-gold); padding: 2rem; max-width: 650px; box-shadow: var(--box-shadow-card);">
        <h2 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.2rem; margin-bottom: 1.2rem; text-transform: uppercase;">
            ⚖ Закрепить предприятие за Капо (1 Капо = 1 Бизнес)
        </h2>
        <form action="/boss/businesses/assign" method="POST">
            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

            <div class="form-group">
                <label class="form-label">Выберите предприятие *</label>
                <select name="businessId" class="form-select" required>
                    <#list businesses as b>
                        <option value="${b.id}">${b.name} (${b.type})</option>
                    </#list>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label">Выберите Капо *</label>
                <select name="capoId" class="form-select" required>
                    <#if capos?? && capos?has_content>
                        <#list capos as c>
                            <option value="${c.id}">${c.username}</option>
                        </#list>
                    <#else>
                        <option disabled>В семье пока нет назначенных Капо</option>
                    </#if>
                </select>
            </div>

            <button type="submit" class="btn-gold" style="width: auto; padding: 0.8rem 1.6rem;">
                Закрепить точку
            </button>
        </form>
    </div>

</@layout.page_layout>