<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Семья ${(hierarchy.familyName)!'Неизвестно'} | Cosa Nostra" activeTab="family">

    <style>
        .page-back-bar {
            max-width: 1100px;
            margin: 0 auto 1.5rem auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(197,160,89,0.2);
            padding-bottom: 0.8rem;
        }

        .btn-back {
            color: var(--brass-gold);
            text-decoration: none;
            font-family: 'Cinzel', serif;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-back:hover {
            color: var(--brass-gold-hover);
            text-decoration: underline;
        }
    </style>

    <div class="page-back-bar">
        <a href="/family" class="btn-back">← Вернуться к своей Семье</a>
        <span style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase;">Разведданные синдиката</span>
    </div>

    <div class="hierarchy-header" style="text-align: center; margin-bottom: 2rem;">
        <h1 style="font-family: 'Cinzel', serif; font-size: 2.2rem; color: var(--brass-gold); text-transform: uppercase; letter-spacing: 3px;">
            Семья ${hierarchy.familyName}
        </h1>
        <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase; letter-spacing: 2px;">
            Структура и ключевые лица клана
        </p>
    </div>

    <!-- Дерево иерархии -->
    <div style="display: flex; flex-direction: column; align-items: center; max-width: 1100px; margin: 0 auto;">

        <!-- Дон -->
        <#if hierarchy.boss??>
            <div style="background: linear-gradient(180deg, #221410 0%, var(--bg-card) 100%); border: 2px solid var(--brass-gold); padding: 1.2rem 1.5rem; width: 300px; text-align: center; box-shadow: 0 0 25px rgba(197, 160, 89, 0.25);">
                <div style="width: 54px; height: 54px; margin: 0 auto 0.8rem auto; border: 1px solid var(--brass-gold); border-radius: 50%; background: var(--burgundy-dark); display: flex; align-items: center; justify-content: center; font-family: 'Cinzel', serif; font-size: 1.3rem; color: var(--brass-gold); font-weight: bold;">
                    ${(hierarchy.boss.username[0..0])!'D'}
                </div>
                <span style="display: inline-block; font-family: 'Cinzel', serif; font-size: 0.7rem; font-weight: bold; color: #0A0A0A; background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%); padding: 0.2rem 0.6rem; text-transform: uppercase; margin-bottom: 0.5rem;">
                    Capo di Tutti Capi
                </span>
                <div style="font-family: 'Cinzel', serif; font-size: 1.1rem; color: var(--text-main); font-weight: bold;">
                    ${(hierarchy.boss.username)!'Неизвестно'}
                </div>
            </div>
        </#if>

        <div style="width: 2px; height: 2rem; background: var(--brass-gold); opacity: 0.5;"></div>

        <!-- Консильери -->
        <#if hierarchy.counselor??>
            <div style="background: var(--bg-card); border: var(--border-gold); padding: 1.2rem 1.5rem; width: 280px; text-align: center; margin-bottom: 2rem;">
                <span style="display: inline-block; font-family: 'Cinzel', serif; font-size: 0.7rem; font-weight: bold; background: #3D0C02; color: var(--brass-gold); border: 1px solid var(--brass-gold); padding: 0.2rem 0.6rem; text-transform: uppercase; margin-bottom: 0.5rem;">
                    Consigliere
                </span>
                <div style="font-family: 'Cinzel', serif; font-size: 1.1rem; color: var(--text-main); font-weight: bold;">
                    ${(hierarchy.counselor.username)!'Неизвестно'}
                </div>
            </div>
        </#if>

        <!-- Капореджиме -->
        <div style="width: 100%; border-bottom: 1px solid rgba(197, 160, 89, 0.2); margin: 1.5rem 0; text-align: center;">
            <span style="background: var(--bg-charcoal); color: var(--brass-gold); font-family: 'Cinzel', serif; padding: 0 1rem; font-size: 0.85rem; text-transform: uppercase;">
                Капореджиме
            </span>
        </div>

        <div style="display: flex; justify-content: center; gap: 1.5rem; flex-wrap: wrap; width: 100%; margin-bottom: 2rem;">
            <#if hierarchy.capos?? && hierarchy.capos?has_content>
                <#list hierarchy.capos as capo>
                    <div style="background: var(--bg-card); border: var(--border-gold); padding: 1rem 1.5rem; width: 250px; text-align: center;">
                        <span style="font-family: 'Cinzel', serif; font-size: 0.7rem; color: var(--brass-gold); text-transform: uppercase;">Caporegime</span>
                        <div style="font-family: 'Cinzel', serif; font-size: 1rem; color: var(--text-main); font-weight: bold; margin-top: 0.3rem;">
                            ${capo.username}
                        </div>
                    </div>
                </#list>
            <#else>
                <p style="color: var(--text-muted); font-size: 0.85rem;">Капо не назначены</p>
            </#if>
        </div>

        <!-- Солдаты -->
        <div style="width: 100%; border-bottom: 1px solid rgba(197, 160, 89, 0.2); margin: 1.5rem 0; text-align: center;">
            <span style="background: var(--bg-charcoal); color: var(--brass-gold); font-family: 'Cinzel', serif; padding: 0 1rem; font-size: 0.85rem; text-transform: uppercase;">
                Солдаты
            </span>
        </div>

        <div style="display: flex; justify-content: center; gap: 1rem; flex-wrap: wrap; width: 100%;">
            <#if hierarchy.soldiers?? && hierarchy.soldiers?has_content>
                <#list hierarchy.soldiers as soldier>
                    <div style="background: #121212; border: 1px solid rgba(197, 160, 89, 0.2); padding: 0.8rem 1.2rem; width: 220px; text-align: center;">
                        <div style="font-family: 'Cinzel', serif; font-size: 0.9rem; color: var(--text-main); font-weight: bold;">
                            ${soldier.username}
                        </div>
                        <span style="font-size: 0.7rem; color: var(--brass-gold); text-transform: uppercase;">Soldier</span>
                    </div>
                </#list>
            <#else>
                <p style="color: var(--text-muted); font-size: 0.85rem;">Рядовые бойцы отсутствуют</p>
            </#if>
        </div>
    </div>

</@layout.page_layout>