<!-- src/main/resources/templates/hierarchy/index.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Иерархия Пяти Семей | Cosa Nostra" activeTab="family">

    <style>
        .tabs-bar {
            display: flex;
            justify-content: center;
            gap: 0.8rem;
            flex-wrap: wrap;
            margin-bottom: 2.5rem;
        }
        .tab-btn {
            background: var(--bg-card);
            border: var(--border-gold);
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
            font-size: 0.85rem;
            padding: 0.6rem 1.4rem;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            transition: all 0.3s;
        }
        .tab-btn:hover, .tab-btn.active {
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            color: #0A0A0A;
            box-shadow: 0 0 15px rgba(197, 160, 89, 0.4);
        }
        .family-tab-content {
            display: none;
            animation: fadeIn 0.4s ease;
        }
        .family-tab-content.active {
            display: block;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .tree-box {
            display: flex;
            flex-direction: column;
            align-items: center;
            max-width: 1000px;
            margin: 0 auto;
        }

        /* Кликабельная карточка мафиози */
        .card-member {
            background: var(--bg-card);
            border: var(--border-gold);
            padding: 1.2rem;
            width: 280px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.8);
            transition: transform 0.25s ease, border-color 0.25s ease, box-shadow 0.25s ease;
            text-decoration: none;
            display: block;
            color: inherit;
            cursor: pointer;
        }
        .card-member:hover {
            transform: translateY(-4px);
            border-color: var(--brass-gold-hover);
            box-shadow: 0 0 25px rgba(197, 160, 89, 0.4);
        }
        .card-don {
            width: 310px;
            border: 2px solid var(--brass-gold);
            background: linear-gradient(180deg, #221410 0%, var(--bg-card) 100%);
        }
        .card-don:hover {
            box-shadow: 0 0 30px rgba(197, 160, 89, 0.5);
        }
        .member-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 1px solid var(--brass-gold);
            background: var(--burgundy-dark);
            color: var(--brass-gold);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Cinzel', serif;
            font-size: 1.3rem;
            margin: 0 auto 0.6rem auto;
            overflow: hidden;
        }
        .badge-rank {
            display: inline-block;
            font-family: 'Cinzel', serif;
            font-size: 0.68rem;
            padding: 0.2rem 0.5rem;
            background: var(--brass-gold);
            color: #0A0A0A;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 0.4rem;
        }
        .badge-cons {
            background: var(--burgundy-dark);
            color: var(--brass-gold);
            border: 1px solid var(--brass-gold);
        }
        .v-line {
            width: 2px;
            height: 1.8rem;
            background: var(--brass-gold);
            opacity: 0.5;
            margin: 0 auto;
        }
        .row-members {
            display: flex;
            justify-content: center;
            gap: 1.2rem;
            flex-wrap: wrap;
            width: 100%;
        }
        .section-lbl {
            width: 100%;
            text-align: center;
            border-bottom: 1px solid rgba(197,160,89,0.2);
            margin: 1.8rem 0;
        }
        .section-lbl span {
            background: var(--bg-charcoal);
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
            font-size: 0.8rem;
            padding: 0 1rem;
            position: relative;
            top: -0.6rem;
            text-transform: uppercase;
        }

        /* Кликабельная карточка солдата */
        .soldier-card-link {
            background: #121212;
            border: 1px solid rgba(197,160,89,0.2);
            padding: 0.6rem 1rem;
            width: 220px;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            text-decoration: none;
            color: inherit;
            cursor: pointer;
            transition: all 0.25s ease;
        }
        .soldier-card-link:hover {
            transform: translateY(-2px);
            border-color: var(--brass-gold);
            box-shadow: 0 0 15px rgba(197, 160, 89, 0.25);
        }
    </style>

    <div style="text-align: center; margin-bottom: 2rem;">
        <h1 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 2.2rem; letter-spacing: 3px; text-transform: uppercase;">
            Единая Иерархия Пяти Семей
        </h1>
        <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">Архивные структуры синдиката Нью-Йорка</p>
    </div>

    <div class="tabs-bar">
        <#list families as fam>
            <button class="tab-btn <#if fam_index == 0>active</#if>" onclick="showFamilyTab(${fam_index}, this)">
                ${fam.familyName}
            </button>
        </#list>
    </div>

    <#list families as fam>
        <div id="fam-tab-${fam_index}" class="family-tab-content <#if fam_index == 0>active</#if>">
            <div class="tree-box">
                <!-- DON -->
                <#if fam.boss??>
                    <a href="/profile/${fam.boss.id}" class="card-member card-don" title="Открыть досье Дона">
                        <div class="member-avatar">
                            <#if (fam.boss.photoUrl)?? && fam.boss.photoUrl?has_content>
                                <img src="${fam.boss.photoUrl}" alt="${fam.boss.username}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(fam.boss.username[0..0])!'D'}';"/>
                            <#else>
                                ${(fam.boss.username[0..0])!'D'}
                            </#if>
                        </div>
                        <span class="badge-rank">Capo di Tutti Capi</span>
                        <h3 style="font-family: 'Cinzel', serif; color: var(--text-main); font-size: 1.1rem; margin: 0.2rem 0;">
                            ${fam.boss.username}
                        </h3>
                        <p style="font-size: 0.75rem; color: var(--text-muted); margin: 0;">Глава Семьи</p>
                    </a>
                <#else>
                    <div class="card-member card-don" style="cursor: default;">
                        <div class="member-avatar">👑</div>
                        <span class="badge-rank">Трон свободен</span>
                    </div>
                </#if>

                <div class="v-line"></div>

                <!-- CONSIGLIERE -->
                <#if fam.counselor??>
                    <a href="/profile/${fam.counselor.id}" class="card-member" title="Открыть досье Консильери">
                        <div class="member-avatar">
                            <#if (fam.counselor.photoUrl)?? && fam.counselor.photoUrl?has_content>
                                <img src="${fam.counselor.photoUrl}" alt="${fam.counselor.username}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(fam.counselor.username[0..0])!'C'}';"/>
                            <#else>
                                ${(fam.counselor.username[0..0])!'C'}
                            </#if>
                        </div>
                        <span class="badge-rank badge-cons">Consigliere</span>
                        <h4 style="font-family: 'Cinzel', serif; color: var(--text-main); margin: 0.2rem 0;">
                            ${fam.counselor.username}
                        </h4>
                        <p style="font-size: 0.75rem; color: var(--text-muted); margin: 0;">Советник Дона</p>
                    </a>
                    <div class="v-line"></div>
                </#if>

                <!-- CAPOS -->
                <div class="section-lbl"><span>Капореджиме</span></div>
                <div class="row-members">
                    <#if fam.capos?? && fam.capos?has_content>
                        <#list fam.capos as capo>
                            <a href="/profile/${capo.id}" class="card-member" title="Открыть досье Капо">
                                <div class="member-avatar">
                                    <#if (capo.photoUrl)?? && capo.photoUrl?has_content>
                                        <img src="${capo.photoUrl}" alt="${capo.username}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(capo.username[0..0])!'C'}';"/>
                                    <#else>
                                        ${(capo.username[0..0])!'C'}
                                    </#if>
                                </div>
                                <span class="badge-rank">Caporegime</span>
                                <div style="font-family: 'Cinzel', serif; font-weight: bold; margin-top: 0.3rem; color: var(--brass-gold);">
                                    ${capo.username}
                                </div>
                            </a>
                        </#list>
                    <#else>
                        <p style="color: var(--text-muted); font-size: 0.85rem;">Капо не назначены</p>
                    </#if>
                </div>

                <!-- SOLDIERS -->
                <div class="section-lbl"><span>Солдаты</span></div>
                <div class="row-members">
                    <#if fam.soldiers?? && fam.soldiers?has_content>
                        <#list fam.soldiers as s>
                            <a href="/profile/${s.id}" class="soldier-card-link" title="Открыть досье Солдата">
                                <div style="width: 38px; height: 38px; border-radius: 50%; border: 1px solid var(--brass-gold); overflow: hidden; flex-shrink: 0; background: var(--burgundy-dark); display: flex; align-items: center; justify-content: center; color: var(--brass-gold); font-family: 'Cinzel', serif;">
                                    <#if (s.photoUrl)?? && s.photoUrl?has_content>
                                        <img src="${s.photoUrl}" alt="${s.username}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.style.display='none'; this.parentElement.innerText='${(s.username[0..0])!'S'}';"/>
                                    <#else>
                                        ${(s.username[0..0])!'S'}
                                    </#if>
                                </div>
                                <div style="text-align: left;">
                                    <div style="color: var(--text-main); font-family: 'Cinzel', serif; font-size: 0.85rem; font-weight: bold;">${s.username}</div>
                                    <div style="font-size: 0.68rem; color: var(--brass-gold); text-transform: uppercase;">Soldier</div>
                                </div>
                            </a>
                        </#list>
                    <#else>
                        <p style="color: var(--text-muted); font-size: 0.85rem;">Рядовые солдаты отсутствуют</p>
                    </#if>
                </div>
            </div>
        </div>
    </#list>

    <script>
        function showFamilyTab(idx, btn) {
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.querySelectorAll('.family-tab-content').forEach(c => c.classList.remove('active'));
            btn.classList.add('active');
            document.getElementById('fam-tab-' + idx).classList.add('active');
        }
    </script>

</@layout.page_layout>