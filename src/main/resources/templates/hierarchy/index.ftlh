<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('hierarchy.index.title')} | Cosa Nostra" activeTab="family">

    <div style="text-align: center; margin-bottom: 2rem;">
        <h1 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: clamp(1.6rem, 4vw, 2.2rem); letter-spacing: 3px; text-transform: uppercase;">
            <@spring.message "hierarchy.index.title"/>
        </h1>
        <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">
            <@spring.message "hierarchy.index.subtitle"/>
        </p>
    </div>

    <!-- Табы переключения Семей -->
    <div style="display: flex; justify-content: center; gap: 0.6rem; flex-wrap: wrap; margin-bottom: 2.5rem;">
        <#list families as fam>
            <button class="btn-action <#if fam_index == 0>active</#if>"
                    id="tab-btn-${fam_index}"
                    style="padding: 0.6rem 1.2rem; cursor: pointer; <#if fam_index == 0>background: var(--gold-gradient); color: #0A0A0A;</#if>"
                    onclick="showFamilyTab(${fam_index})">
                ${fam.familyName}
            </button>
        </#list>
    </div>

    <#list families as fam>
        <div id="fam-tab-${fam_index}" style="display: <#if fam_index == 0>block<#else>none</#if>;">
            <div class="tree-box">
                <!-- DON -->
                <#if fam.boss??>
                    <a href="/profile/${fam.boss.id}" class="card-member card-don" title="${springMacroRequestContext.getMessage('role.boss.title')}">
                        <div class="avatar-frame" style="width: 50px; height: 50px; margin: 0 auto 0.6rem auto; font-size: 1.3rem;">
                            <#if (fam.boss.photoUrl)?? && fam.boss.photoUrl?has_content>
                                <img src="${fam.boss.photoUrl}" alt="${fam.boss.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(fam.boss.username[0..0])!'D'}';"/>
                            <#else>
                                ${(fam.boss.username[0..0])!'D'}
                            </#if>
                        </div>
                        <span class="role-badge" style="font-size: 0.68rem; padding: 0.2rem 0.5rem; margin-bottom: 0.4rem;"><@spring.message "role.boss.title"/></span>
                        <h3 style="font-family: var(--font-heading); color: var(--text-main); font-size: 1.1rem; margin: 0.2rem 0; word-break: break-word;">
                            ${fam.boss.username}
                        </h3>
                        <p style="font-size: 0.75rem; color: var(--text-muted); margin: 0;"><@spring.message "family.boss.role_name"/></p>
                    </a>
                <#else>
                    <div class="card-member card-don" style="cursor: default;">
                        <div class="avatar-frame" style="width: 50px; height: 50px; margin: 0 auto 0.6rem auto; font-size: 1.3rem;">👑</div>
                        <span class="role-badge" style="background: var(--burgundy-dark); color: var(--brass-gold); border: 1px solid var(--brass-gold); font-size: 0.68rem;"><@spring.message "family.boss.not_assigned"/></span>
                    </div>
                </#if>

                <div class="line-vertical"></div>

                <!-- CONSIGLIERE -->
                <#if fam.counselor??>
                    <a href="/profile/${fam.counselor.id}" class="card-member" title="${springMacroRequestContext.getMessage('role.consigliere.title')}">
                        <div class="avatar-frame" style="width: 50px; height: 50px; margin: 0 auto 0.6rem auto; font-size: 1.3rem;">
                            <#if (fam.counselor.photoUrl)?? && fam.counselor.photoUrl?has_content>
                                <img src="${fam.counselor.photoUrl}" alt="${fam.counselor.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(fam.counselor.username[0..0])!'C'}';"/>
                            <#else>
                                ${(fam.counselor.username[0..0])!'C'}
                            </#if>
                        </div>
                        <span class="role-badge" style="background: var(--burgundy-dark); color: var(--brass-gold); border: 1px solid var(--brass-gold); font-size: 0.68rem; padding: 0.2rem 0.5rem; margin-bottom: 0.4rem;">
                            <@spring.message "role.consigliere.title"/>
                        </span>
                        <h4 style="font-family: var(--font-heading); color: var(--text-main); font-size: 1rem; margin: 0.2rem 0; word-break: break-word;">
                            ${fam.counselor.username}
                        </h4>
                        <p style="font-size: 0.75rem; color: var(--text-muted); margin: 0;"><@spring.message "family.counselor.role_name"/></p>
                    </a>
                    <div class="line-vertical"></div>
                </#if>

                <!-- CAPOS -->
                <div style="width: 100%; text-align: center; border-bottom: 1px solid rgba(197,160,89,0.2); margin: 1.8rem 0; position: relative;">
                    <span style="background: var(--bg-charcoal); color: var(--brass-gold); font-family: var(--font-heading); font-size: 0.8rem; padding: 0 1rem; position: relative; top: -0.6rem; text-transform: uppercase; letter-spacing: 1px;">
                        <@spring.message "family.other.capos.divider"/>
                    </span>
                </div>

                <div class="row-members">
                    <#if fam.capos?? && fam.capos?has_content>
                        <#list fam.capos as capo>
                            <a href="/profile/${capo.id}" class="card-member" title="${springMacroRequestContext.getMessage('role.capo.title')}">
                                <div class="avatar-frame" style="width: 44px; height: 44px; margin: 0 auto 0.6rem auto; font-size: 1.1rem;">
                                    <#if (capo.photoUrl)?? && capo.photoUrl?has_content>
                                        <img src="${capo.photoUrl}" alt="${capo.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(capo.username[0..0])!'C'}';"/>
                                    <#else>
                                        ${(capo.username[0..0])!'C'}
                                    </#if>
                                </div>
                                <span style="font-size: 0.7rem; color: var(--text-muted); text-transform: uppercase;"><@spring.message "role.capo.title"/></span>
                                <div style="font-family: var(--font-heading); font-weight: bold; margin-top: 0.3rem; color: var(--brass-gold); word-break: break-word;">
                                    ${capo.username}
                                </div>
                            </a>
                        </#list>
                    <#else>
                        <p style="color: var(--text-muted); font-size: 0.85rem;"><@spring.message "family.capos.none"/></p>
                    </#if>
                </div>

                <!-- SOLDIERS -->
                <div style="width: 100%; text-align: center; border-bottom: 1px solid rgba(197,160,89,0.2); margin: 1.8rem 0; position: relative;">
                    <span style="background: var(--bg-charcoal); color: var(--brass-gold); font-family: var(--font-heading); font-size: 0.8rem; padding: 0 1rem; position: relative; top: -0.6rem; text-transform: uppercase; letter-spacing: 1px;">
                        <@spring.message "family.other.soldiers.divider"/>
                    </span>
                </div>

                <div class="soldiers-grid">
                    <#if fam.soldiers?? && fam.soldiers?has_content>
                        <#list fam.soldiers as s>
                            <a href="/profile/${s.id}" class="soldier-card-link" title="${s.username}">
                                <div class="avatar-frame" style="width: 36px; height: 36px; font-size: 0.9rem;">
                                    <#if (s.photoUrl)?? && s.photoUrl?has_content>
                                        <img src="${s.photoUrl}" alt="${s.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(s.username[0..0])!'S'}';"/>
                                    <#else>
                                        ${(s.username[0..0])!'S'}
                                    </#if>
                                </div>
                                <div class="soldier-info">
                                    <div class="soldier-name" title="${s.username}">${s.username}</div>
                                    <div class="soldier-role"><@spring.message "role.soldier.title"/></div>
                                </div>
                            </a>
                        </#list>
                    <#else>
                        <p style="color: var(--text-muted); font-size: 0.85rem;"><@spring.message "family.soldiers.none"/></p>
                    </#if>
                </div>
            </div>
        </div>
    </#list>

    <script>
        function showFamilyTab(idx) {
            document.querySelectorAll('[id^="fam-tab-"]').forEach(el => el.style.display = 'none');
            document.querySelectorAll('[id^="tab-btn-"]').forEach(btn => {
                btn.style.background = 'transparent';
                btn.style.color = 'var(--brass-gold)';
            });

            const currentTab = document.getElementById('fam-tab-' + idx);
            const currentBtn = document.getElementById('tab-btn-' + idx);

            if (currentTab) currentTab.style.display = 'block';
            if (currentBtn) {
                currentBtn.style.background = 'var(--gold-gradient)';
                currentBtn.style.color = '#0A0A0A';
            }
        }
    </script>

</@layout.page_layout>