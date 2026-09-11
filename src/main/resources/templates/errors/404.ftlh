<!-- src/main/resources/templates/errors/404.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="404 Дело не найдено | Cosa Nostra">
    <div style="max-width: 600px; margin: 4rem auto; text-align: center; background: var(--bg-card); border: 1px solid var(--burgundy-light); padding: 3rem 2rem; box-shadow: 0 0 35px rgba(0,0,0,0.9);">
        <div style="font-size: 3.5rem; margin-bottom: 1rem;">🗂️</div>
        <h1 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 2.2rem; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 1rem;">
            404 — След Потерян
        </h1>
        <p style="color: var(--text-muted); font-size: 0.95rem; line-height: 1.7; margin-bottom: 2rem;">
            По указанному адресу нет конспиративной квартиры, а запрошенное досье было уничтожено или никогда не существовало в архивах Синдиката.
        </p>
        <a href="/" style="display: inline-block; padding: 0.8rem 1.6rem; background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%); color: #0A0A0A; text-decoration: none; font-family: 'Cinzel', serif; font-weight: bold; text-transform: uppercase; letter-spacing: 1px;">
            Вернуться в штаб
        </a>
    </div>
</@layout.page_layout>