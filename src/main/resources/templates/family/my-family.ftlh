<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('family.my.title')} | Cosa Nostra" activeTab="family">

    <div style="text-align: center; margin-bottom: 2.5rem;">
        <h1 style="font-family: var(--font-heading); font-size: clamp(1.8rem, 4vw, 2.4rem); color: var(--brass-gold); text-transform: uppercase; letter-spacing: 3px; text-shadow: 0 2px 10px rgba(0, 0, 0, 0.9); margin-bottom: 0.5rem;">
            <@spring.message "family.my.title"/>
        </h1>
        <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase; letter-spacing: 2px;">
            <@spring.message "family.my.subtitle"/>
        </p>
    </div>

    <div class="tree-container">

        <!-- 1. УРОВЕНЬ: ДОН -->
        <#if hierarchy.boss??>
            <a href="/profile/${hierarchy.boss.id}" class="card-node don-node" title="${springMacroRequestContext.getMessage('role.boss.title')}">
                <div class="avatar-frame" style="width: 54px; height: 54px; margin: 0 auto 0.8rem auto; font-size: 1.3rem;">
                    <#if (hierarchy.boss.photoUrl)?? && hierarchy.boss.photoUrl?has_content>
                        <img src="${hierarchy.boss.photoUrl}" alt="${hierarchy.boss.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(hierarchy.boss.username[0..0])!'D'}';"/>
                    <#else>
                        ${(hierarchy.boss.username[0..0])!'D'}
                    </#if>
                </div>
                <span class="role-badge" style="font-size: 0.7rem; margin-bottom: 0.5rem;"><@spring.message "role.boss.title"/></span>
                <div style="font-family: var(--font-heading); font-size: 1.1rem; color: var(--text-main); font-weight: bold; word-break: break-word;">
                    ${(hierarchy.boss.username)!springMacroRequestContext.getMessage("family.unknown_member")}
                </div>
                <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 0.4rem;"><@spring.message "family.boss.role_name"/></div>
            </a>
        <#else>
            <div class="card-node don-node" style="cursor: default;">
                <div class="avatar-frame" style="width: 54px; height: 54px; margin: 0 auto 0.8rem auto; font-size: 1.3rem;">👑</div>
                <span class="role-badge" style="background: var(--burgundy-dark); color: var(--brass-gold); border: 1px solid var(--brass-gold); font-size: 0.7rem;"><@spring.message "family.boss.not_assigned"/></span>
                <div style="font-family: var(--font-heading); font-size: 1.1rem; color: var(--text-main); font-weight: bold; margin-top: 0.4rem;"><@spring.message "family.boss.free_throne"/></div>
            </div>
        </#if>

        <div class="line-vertical"></div>

        <!-- 2. УРОВЕНЬ: КОНСИЛЬЕРИ -->
        <#if hierarchy.counselor??>
            <a href="/profile/${hierarchy.counselor.id}" class="card-node" title="${springMacroRequestContext.getMessage('role.consigliere.title')}">
                <div class="avatar-frame" style="width: 50px; height: 50px; margin: 0 auto 0.8rem auto; font-size: 1.2rem;">
                    <#if (hierarchy.counselor.photoUrl)?? && hierarchy.counselor.photoUrl?has_content>
                        <img src="${hierarchy.counselor.photoUrl}" alt="${hierarchy.counselor.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(hierarchy.counselor.username[0..0])!'C'}';"/>
                    <#else>
                        ${(hierarchy.counselor.username[0..0])!'C'}
                    </#if>
                </div>
                <span class="role-badge" style="background: var(--burgundy-dark); color: var(--brass-gold); border: 1px solid var(--brass-gold); font-size: 0.7rem; margin-bottom: 0.5rem;">
                    <@spring.message "role.consigliere.title"/>
                </span>
                <div style="font-family: var(--font-heading); font-size: 1.1rem; color: var(--text-main); font-weight: bold; word-break: break-word;">
                    ${(hierarchy.counselor.username)!springMacroRequestContext.getMessage("family.unknown_member")}
                </div>
                <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 0.4rem;"><@spring.message "family.counselor.role_name"/></div>
            </a>
            <div class="line-vertical"></div>
        </#if>

        <!-- 3. УРОВЕНЬ: КАПОРЕДЖИМЕ -->
        <div style="width: 100%; border-bottom: 1px solid rgba(197, 160, 89, 0.2); margin: 2rem 0; position: relative; text-align: center;">
            <span style="background: var(--bg-charcoal); color: var(--brass-gold); font-family: var(--font-heading); padding: 0 1rem; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 2px; position: relative; top: -0.6rem;">
                <@spring.message "family.capos.divider"/>
            </span>
        </div>

        <div class="tree-level">
            <#if hierarchy.capos?? && hierarchy.capos?has_content>
                <#list hierarchy.capos as capo>
                    <a href="/profile/${capo.id}" class="card-node" title="${springMacroRequestContext.getMessage('role.capo.title')}">
                        <div class="avatar-frame" style="width: 46px; height: 46px; margin: 0 auto 0.6rem auto; font-size: 1.1rem;">
                            <#if (capo.photoUrl)?? && capo.photoUrl?has_content>
                                <img src="${capo.photoUrl}" alt="${capo.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(capo.username[0..0])!'C'}';"/>
                            <#else>
                                ${(capo.username[0..0])!'C'}
                            </#if>
                        </div>
                        <span style="font-size: 0.7rem; color: var(--text-muted); text-transform: uppercase;"><@spring.message "role.capo.title"/></span>
                        <div style="font-family: var(--font-heading); font-size: 1.05rem; color: var(--text-main); font-weight: bold; margin-top: 0.3rem; word-break: break-word;">
                            ${(capo.username)!springMacroRequestContext.getMessage("family.unknown_member")}
                        </div>
                    </a>
                </#list>
            <#else>
                <p style="color: var(--text-muted); font-size: 0.85rem;"><@spring.message "family.capos.none"/></p>
            </#if>
        </div>

        <!-- 4. УРОВЕНЬ: СОЛДАТЫ -->
        <div style="width: 100%; border-bottom: 1px solid rgba(197, 160, 89, 0.2); margin: 2rem 0; position: relative; text-align: center;">
            <span style="background: var(--bg-charcoal); color: var(--brass-gold); font-family: var(--font-heading); padding: 0 1rem; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 2px; position: relative; top: -0.6rem;">
                <@spring.message "family.soldiers.divider"/>
            </span>
        </div>

        <#if hierarchy.soldiers?? && hierarchy.soldiers?has_content>
            <div class="soldiers-grid">
                <#list hierarchy.soldiers as soldier>
                    <a href="/profile/${soldier.id}" class="soldier-card" title="${springMacroRequestContext.getMessage('role.soldier.title')}">
                        <div class="avatar-frame" style="width: 38px; height: 38px; font-size: 0.9rem;">
                            <#if (soldier.photoUrl)?? && soldier.photoUrl?has_content>
                                <img src="${soldier.photoUrl}" alt="${soldier.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(soldier.username[0..0])!'S'}';"/>
                            <#else>
                                ${(soldier.username[0..0])!'S'}
                            </#if>
                        </div>
                        <div style="min-width: 0;">
                            <div style="font-family: var(--font-heading); color: var(--text-main); font-size: 0.88rem; font-weight: bold; word-break: break-word;">
                                ${(soldier.username)!springMacroRequestContext.getMessage("family.unknown_member")}
                            </div>
                            <div style="color: var(--brass-gold); font-size: 0.72rem; text-transform: uppercase;"><@spring.message "role.soldier.title"/></div>
                        </div>
                    </a>
                </#list>
            </div>
        <#else>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-align: center;"><@spring.message "family.soldiers.none"/></p>
        </#if>

    </div>

</@layout.page_layout>