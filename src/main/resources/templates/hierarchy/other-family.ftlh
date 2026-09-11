<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Иерархия Семьи: ${(hierarchy.familyName)!'Неизвестно'} | Cosa Nostra" activeTab="family">
    <div style="margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 1rem;">
        <div>
            <h1 style="font-family: 'Cinzel', serif; font-size: 2.2rem; color: var(--brass-gold); text-transform: uppercase; margin-bottom: 0.3rem;">
                Семья ${hierarchy.familyName}
            </h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">Разведданные синдиката</p>
        </div>
        <a href="/family" style="color: var(--brass-gold); text-decoration: none; font-family: 'Cinzel', serif; font-size: 0.85rem; text-transform: uppercase;">
            ← К своей семье
        </a>
    </div>

    <#include "my-family.ftlh">
</@layout.page_layout>