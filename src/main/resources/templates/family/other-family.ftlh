<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Семья ${(hierarchy.familyName)!'Неизвестно'} | Cosa Nostra" activeTab="family">

    <div class="page-header-bar">
        <a href="/family" style="font-family: var(--font-heading); font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px;">
            ← Вернуться к своей Семье
        </a>
        <span style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase;">Разведданные синдиката</span>
    </div>

    <div style="text-align: center; margin-bottom: 2rem;">
        <h1 style="font-family: var(--font-heading); font-size: clamp(1.8rem, 4vw, 2.2rem); color: var(--brass-gold); text-transform: uppercase; letter-spacing: 3px;">
            Семья ${hierarchy.familyName}
        </h1>
        <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase; letter-spacing: 2px;">
            Структура и ключевые лица клана
        </p>
    </div>

    <!-- Дерево иерархии -->
    <div class="tree-container">

        <!-- Дон -->
        <#if hierarchy.boss??>
            <a href="/profile/${hierarchy.boss.id}" class="card-node don-node" title="Открыть досье Дона">
                <div class="avatar-frame" style="width: 54px; height: 54px; margin: 0 auto 0.8rem auto; font-size: 1.3rem;">
                    <#if (hierarchy.boss.photoUrl)?? && hierarchy.boss.photoUrl?has_content>
                        <img src="${hierarchy.boss.photoUrl}" alt="${hierarchy.boss.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(hierarchy.boss.username[0..0])!'D'}';"/>
                    <#else>
                        ${(hierarchy.boss.username[0..0])!'D'}
                    </#if>
                </div>
                <span class="role-badge" style="font-size: 0.7rem; margin-bottom: 0.5rem;">Capo di Tutti Capi</span>
                <div style="font-family: var(--font-heading); font-size: 1.1rem; color: var(--text-main); font-weight: bold; word-break: break-word;">
                    ${(hierarchy.boss.username)!'Неизвестно'}
                </div>
            </a>
        </#if>

        <div class="line-vertical"></div>

        <!-- Консильери -->
        <#if hierarchy.counselor??>
            <a href="/profile/${hierarchy.counselor.id}" class="card-node" title="Открыть досье Консильери">
                <div class="avatar-frame" style="width: 50px; height: 50px; margin: 0 auto 0.8rem auto; font-size: 1.2rem;">
                    <#if (hierarchy.counselor.photoUrl)?? && hierarchy.counselor.photoUrl?has_content>
                        <img src="${hierarchy.counselor.photoUrl}" alt="${hierarchy.counselor.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(hierarchy.counselor.username[0..0])!'C'}';"/>
                    <#else>
                        ${(hierarchy.counselor.username[0..0])!'C'}
                    </#if>
                </div>
                <span class="role-badge" style="background: var(--burgundy-dark); color: var(--brass-gold); border: 1px solid var(--brass-gold); font-size: 0.7rem; margin-bottom: 0.5rem;">
                    Consigliere
                </span>
                <div style="font-family: var(--font-heading); font-size: 1.1rem; color: var(--text-main); font-weight: bold; word-break: break-word;">
                    ${(hierarchy.counselor.username)!'Неизвестно'}
                </div>
            </a>
        </#if>

        <!-- Капореджиме -->
        <div style="width: 100%; border-bottom: 1px solid rgba(197, 160, 89, 0.2); margin: 2rem 0; position: relative; text-align: center;">
            <span style="background: var(--bg-charcoal); color: var(--brass-gold); font-family: var(--font-heading); padding: 0 1rem; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 2px; position: relative; top: -0.6rem;">
                Капореджиме
            </span>
        </div>

        <div class="tree-level">
            <#if hierarchy.capos?? && hierarchy.capos?has_content>
                <#list hierarchy.capos as capo>
                    <a href="/profile/${capo.id}" class="card-node" title="Открыть досье Капо">
                        <div class="avatar-frame" style="width: 46px; height: 46px; margin: 0 auto 0.6rem auto; font-size: 1.1rem;">
                            <#if (capo.photoUrl)?? && capo.photoUrl?has_content>
                                <img src="${capo.photoUrl}" alt="${capo.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(capo.username[0..0])!'C'}';"/>
                            <#else>
                                ${(capo.username[0..0])!'C'}
                            </#if>
                        </div>
                        <span style="font-size: 0.7rem; color: var(--text-muted); text-transform: uppercase;">Caporegime</span>
                        <div style="font-family: var(--font-heading); font-size: 1rem; color: var(--text-main); font-weight: bold; margin-top: 0.3rem; word-break: break-word;">
                            ${capo.username}
                        </div>
                    </a>
                </#list>
            <#else>
                <p style="color: var(--text-muted); font-size: 0.85rem;">Капо не назначены</p>
            </#if>
        </div>

        <!-- Солдаты -->
        <div style="width: 100%; border-bottom: 1px solid rgba(197, 160, 89, 0.2); margin: 2rem 0; position: relative; text-align: center;">
            <span style="background: var(--bg-charcoal); color: var(--brass-gold); font-family: var(--font-heading); padding: 0 1rem; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 2px; position: relative; top: -0.6rem;">
                Солдаты
            </span>
        </div>

        <div class="soldiers-grid">
            <#if hierarchy.soldiers?? && hierarchy.soldiers?has_content>
                <#list hierarchy.soldiers as soldier>
                    <a href="/profile/${soldier.id}" class="soldier-card" title="Открыть досье Солдата">
                        <div class="avatar-frame" style="width: 38px; height: 38px; font-size: 0.9rem;">
                            <#if (soldier.photoUrl)?? && soldier.photoUrl?has_content>
                                <img src="${soldier.photoUrl}" alt="${soldier.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(soldier.username[0..0])!'S'}';"/>
                            <#else>
                                ${(soldier.username[0..0])!'S'}
                            </#if>
                        </div>
                        <div style="min-width: 0;">
                            <div style="font-family: var(--font-heading); font-size: 0.9rem; color: var(--text-main); font-weight: bold; word-break: break-word;">
                                ${soldier.username}
                            </div>
                            <span style="font-size: 0.7rem; color: var(--brass-gold); text-transform: uppercase;">Soldier</span>
                        </div>
                    </a>
                </#list>
            <#else>
                <p style="color: var(--text-muted); font-size: 0.85rem;">Рядовые бойцы отсутствуют</p>
            </#if>
        </div>
    </div>

</@layout.page_layout>