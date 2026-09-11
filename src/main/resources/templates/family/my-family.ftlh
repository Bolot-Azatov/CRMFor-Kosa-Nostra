<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Иерархия Семьи | Cosa Nostra" activeTab="capos">

    <style>
        * {
            box-sizing: border-box;
        }

        .hierarchy-header {
            text-align: center;
            margin-bottom: 2.5rem;
            position: relative;
        }

        .hierarchy-title {
            font-family: 'Cinzel', serif;
            font-size: 2.4rem;
            color: var(--brass-gold);
            text-transform: uppercase;
            letter-spacing: 3px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.9);
            margin-bottom: 0.5rem;
        }

        .hierarchy-subtitle {
            color: var(--text-muted);
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        /* Главный контейнер — строгая вертикальная ось по центру */
        .tree-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
            max-width: 1100px;
            margin: 0 auto;
            padding: 1rem 0 3rem 0;
        }

        /* Карточка участника */
        .card-node {
            background: var(--bg-card);
            border: var(--border-gold);
            padding: 1.2rem 1.5rem;
            width: 280px;
            text-align: center;
            position: relative;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.8);
            transition: all 0.3s ease;
            z-index: 2;
            flex-shrink: 0;
        }

        .card-node:hover {
            border-color: var(--brass-gold-hover);
            box-shadow: 0 0 25px rgba(197, 160, 89, 0.3);
            transform: translateY(-3px);
        }

        /* Дон (Вершина) */
        .card-node.don-node {
            width: 300px;
            background: linear-gradient(180deg, #221410 0%, var(--bg-card) 100%);
            border: 2px solid var(--brass-gold);
            box-shadow: 0 0 30px rgba(197, 160, 89, 0.25);
        }

        .avatar-frame {
            width: 54px;
            height: 54px;
            margin: 0 auto 0.8rem auto;
            border: 1px solid var(--brass-gold);
            border-radius: 50%;
            background: var(--burgundy-dark);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Cinzel', serif;
            font-size: 1.3rem;
            color: var(--brass-gold);
            font-weight: bold;
            text-transform: uppercase;
        }

        .node-role {
            display: inline-block;
            font-family: 'Cinzel', serif;
            font-size: 0.7rem;
            font-weight: bold;
            color: #0A0A0A;
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            padding: 0.2rem 0.6rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
        }

        .counselor-role {
            background: #3D0C02 !important;
            color: var(--brass-gold) !important;
            border: 1px solid var(--brass-gold);
        }

        .node-name {
            font-family: 'Cinzel', serif;
            font-size: 1.1rem;
            color: var(--text-main);
            font-weight: bold;
            word-break: break-word;
        }

        .node-details {
            font-size: 0.78rem;
            color: var(--text-muted);
            margin-top: 0.4rem;
        }

        /* Соединительная линия строго по центру без отрицательных отступов */
        .line-vertical {
            width: 2px;
            height: 2rem;
            background: var(--brass-gold);
            opacity: 0.5;
            margin: 0 auto;
        }

        /* Уровни с несколькими элементами */
        .tree-level {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1.5rem;
            width: 100%;
            flex-wrap: wrap;
        }

        .section-divider {
            width: 100%;
            border-bottom: 1px solid rgba(197, 160, 89, 0.2);
            margin: 2rem 0;
            position: relative;
            text-align: center;
        }

        .section-divider span {
            background: var(--bg-charcoal);
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
            padding: 0 1rem;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            top: -0.6rem;
        }

        /* Солдаты — flex-центрирование для любого количества элементов */
        .soldiers-grid {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.2rem;
            width: 100%;
        }

        .soldier-card {
            background-color: #121212;
            border: 1px solid rgba(197, 160, 89, 0.2);
            padding: 0.8rem 1.2rem;
            width: 250px;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            transition: all 0.3s ease;
        }

        .soldier-card:hover {
            border-color: var(--brass-gold);
            transform: translateY(-2px);
        }

        .soldier-avatar {
            width: 38px;
            height: 38px;
            background: var(--burgundy-dark);
            border: 1px solid var(--brass-gold);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Cinzel', serif;
            color: var(--brass-gold);
            font-size: 0.9rem;
            flex-shrink: 0;
            text-transform: uppercase;
        }

        .soldier-name {
            font-family: 'Cinzel', serif;
            color: var(--text-main);
            font-size: 0.88rem;
            font-weight: bold;
            word-break: break-word;
        }

        .soldier-role {
            color: var(--brass-gold);
            font-size: 0.72rem;
            text-transform: uppercase;
        }

        .empty-text {
            color: var(--text-muted);
            font-size: 0.85rem;
            text-align: center;
        }
    </style>

    <div class="hierarchy-header">
        <h1 class="hierarchy-title">Клановый Состав Семьи</h1>
        <p class="hierarchy-subtitle">Структура подчинения и омерта</p>
    </div>

    <div class="tree-container">

        <!-- 1. УРОВЕНЬ: ДОН (Boss) -->
        <#if hierarchy.boss??>
            <div class="card-node don-node">
                <div class="avatar-frame">${(hierarchy.boss.username[0..0])!'D'}</div>
                <span class="node-role">Capo di Tutti Capi</span>
                <div class="node-name">${(hierarchy.boss.username)!'Неизвестно'}</div>
                <div class="node-details">Глава Семьи</div>
            </div>
        <#else>
            <div class="card-node don-node">
                <div class="avatar-frame">👑</div>
                <span class="node-role">Дон не назначен</span>
                <div class="node-name">Трон свободен</div>
            </div>
        </#if>

        <div class="line-vertical"></div>

        <!-- 2. УРОВЕНЬ: КОНСИЛЬЕРИ (Consigliere) -->
        <#if hierarchy.counselor??>
            <div class="card-node">
                <div class="avatar-frame">${(hierarchy.counselor.username[0..0])!'C'}</div>
                <span class="node-role counselor-role">Consigliere</span>
                <div class="node-name">${(hierarchy.counselor.username)!'Неизвестно'}</div>
                <div class="node-details">Советник Дона</div>
            </div>
            <div class="line-vertical"></div>
        </#if>

        <!-- 3. УРОВЕНЬ: КАПОРЕДЖИМЕ (Capos) -->
        <div class="section-divider">
            <span>Капореджиме (Командиры)</span>
        </div>

        <div class="tree-level">
            <#if hierarchy.capos?? && hierarchy.capos?has_content>
                <#list hierarchy.capos as capo>
                    <div class="card-node">
                        <div class="avatar-frame">${(capo.username[0..0])!'C'}</div>
                        <span class="node-role">Caporegime</span>
                        <div class="node-name">${(capo.username)!'Неизвестно'}</div>
                    </div>
                </#list>
            <#else>
                <p class="empty-text">Капореджиме не назначены</p>
            </#if>
        </div>

        <!-- 4. УРОВЕНЬ: СОЛДАТЫ (Soldiers) -->
        <div class="section-divider">
            <span>Солдаты и Соучастники</span>
        </div>

        <#if hierarchy.soldiers?? && hierarchy.soldiers?has_content>
            <div class="soldiers-grid">
                <#list hierarchy.soldiers as soldier>
                    <div class="soldier-card">
                        <div class="soldier-avatar">${(soldier.username[0..0])!'S'}</div>
                        <div>
                            <div class="soldier-name">${(soldier.username)!'Неизвестно'}</div>
                            <div class="soldier-role">"SOLDIER"</div>
                        </div>
                    </div>
                </#list>
            </div>
        <#else>
            <p class="empty-text">В строю нет рядовых солдат</p>
        </#if>

    </div>

</@layout.page_layout>