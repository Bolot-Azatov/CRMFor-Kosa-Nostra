<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Досье: ${(user.username)!'Неизвестный'} | Cosa Nostra" activeTab="profile">

    <style>
        .dossier-container {
            max-width: 780px;
            margin: 0 auto;
        }

        .dossier-card {
            background-color: var(--bg-card);
            border: var(--border-gold);
            padding: 2.5rem;
            position: relative;
            box-shadow: 0 0 40px rgba(0, 0, 0, 0.9), inset 0 0 20px rgba(61, 12, 2, 0.4);
        }

        .dossier-card::before, .dossier-card::after {
            content: '';
            position: absolute;
            width: 14px;
            height: 14px;
            border: 2px solid var(--brass-gold);
        }
        .dossier-card::before { top: 8px; left: 8px; border-right: none; border-bottom: none; }
        .dossier-card::after { bottom: 8px; right: 8px; border-left: none; border-top: none; }

        .file-stamp {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            border: 2px dashed var(--burgundy-light);
            color: #FF5555;
            padding: 0.3rem 0.8rem;
            font-size: 0.75rem;
            font-family: 'Cinzel', serif;
            letter-spacing: 2px;
            text-transform: uppercase;
            transform: rotate(-3deg);
            opacity: 0.85;
            user-select: none;
        }

        .dossier-header {
            display: flex;
            align-items: center;
            gap: 2rem;
            padding-bottom: 2rem;
            border-bottom: 1px solid rgba(197, 160, 89, 0.2);
            margin-bottom: 2rem;
        }

        .avatar-box {
            width: 110px;
            height: 110px;
            border: 2px solid var(--brass-gold);
            background-color: var(--burgundy-dark);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Cinzel', serif;
            font-size: 2.5rem;
            color: var(--brass-gold);
            box-shadow: 0 0 15px rgba(197, 160, 89, 0.2);
            flex-shrink: 0;
            text-shadow: 0 2px 5px rgba(0, 0, 0, 0.8);
            overflow: hidden;
        }

        .avatar-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .user-title-group {
            flex-grow: 1;
        }

        .username-title {
            font-family: 'Cinzel', serif;
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--brass-gold);
            letter-spacing: 2px;
            margin-bottom: 0.4rem;
            text-transform: uppercase;
        }

        .role-badge {
            display: inline-block;
            font-family: 'Cinzel', serif;
            font-size: 0.8rem;
            font-weight: bold;
            color: #0A0A0A;
            background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%);
            padding: 0.25rem 0.8rem;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.5);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        @media (max-width: 580px) {
            .dossier-header {
                flex-direction: column;
                text-align: center;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
        }

        .info-item {
            background-color: #121212;
            border: 1px solid rgba(197, 160, 89, 0.2);
            padding: 1rem 1.2rem;
        }

        .info-label {
            font-family: 'Cinzel', serif;
            font-size: 0.75rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.3rem;
            display: block;
        }

        .info-value {
            font-size: 1.05rem;
            color: var(--text-main);
            font-weight: bold;
            word-break: break-all;
        }

        .info-value.gold {
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
        }

        .bio-panel {
            background-color: #121212;
            border: 1px solid rgba(197, 160, 89, 0.2);
            padding: 1.2rem;
            margin-bottom: 2rem;
        }

        .actions-panel {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            padding-top: 1.5rem;
            border-top: 1px dashed rgba(197, 160, 89, 0.2);
        }

        .btn-action {
            padding: 0.75rem 1.5rem;
            font-family: 'Cinzel', serif;
            font-size: 0.82rem;
            font-weight: bold;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            background: transparent;
            color: var(--brass-gold);
            border: var(--border-gold);
        }

        .btn-action:hover {
            background: rgba(197, 160, 89, 0.1);
            color: var(--brass-gold-hover);
            border-color: var(--brass-gold-hover);
        }
    </style>

    <div class="dossier-container">
        <#if user??>
            <div class="dossier-card">
                <span class="file-stamp">ЛИЧНОЕ ДЕЛО №${user.id}</span>

                <div class="dossier-header">
                    <!-- Фотография бойца или винтажная литера -->
                    <div class="avatar-box">
                        <#if (user.photoUrl)?? && user.photoUrl?has_content>
                            <img src="${user.photoUrl}" alt="${user.username}" class="avatar-img" onerror="this.style.display='none'; this.parentElement.innerText='${(user.username[0..0])!'U'}';"/>
                        <#else>
                            ${(user.username[0..0])!'U'}
                        </#if>
                    </div>

                    <div class="user-title-group">
                        <h1 class="username-title">${user.username}</h1>
                        <span class="role-badge">${user.role!"ASSOCIATE"}</span>
                    </div>
                </div>

                <!-- Характеристики участника -->
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Идентификатор (ID)</span>
                        <span class="info-value">#${user.id}</span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Псевдоним в синдикате</span>
                        <span class="info-value gold">${user.username}</span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Статус в иерархии</span>
                        <span class="info-value">${user.role!"Не назначен"}</span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Принадлежность к Семье</span>
                        <#if (user.familyName)?? && user.familyName?has_content>
                            <span class="info-value gold">Семья ${user.familyName}</span>
                        <#else>
                            <span class="info-value" style="color: var(--text-muted);">Без семьи</span>
                        </#if>
                    </div>
                </div>

                <!-- Досье / Биография -->
                <div class="bio-panel">
                    <span class="info-label">Досье / Характеристика</span>
                    <p style="color: var(--text-main); font-size: 0.92rem; line-height: 1.6; margin-top: 0.5rem; white-space: pre-wrap;">
                        ${(user.bio)!"Записи в архиве отсутствуют..."}
                    </p>
                </div>

                <!-- Действия -->
                <div class="actions-panel">
                    <a href="/family" class="btn-action">
                        🏛️ К Древу Семьи
                    </a>
                    <a href="/articles" class="btn-action">
                        📜 К Архивам
                    </a>
                </div>
            </div>
        <#else>
            <div style="text-align: center; padding: 3rem; background: var(--bg-card); border: var(--border-gold);">
                <h2 style="font-family: 'Cinzel', serif; color: var(--brass-gold); margin-bottom: 1rem;">
                    ⛔ Досье не найдено
                </h2>
                <p style="color: var(--text-muted);">Запрошенная карточка участника отсутствует в архиве Cosa Nostra.</p>
                <a href="/" class="btn-action" style="margin-top: 1.5rem;">Вернуться на главную</a>
            </div>
        </#if>
    </div>

</@layout.page_layout>