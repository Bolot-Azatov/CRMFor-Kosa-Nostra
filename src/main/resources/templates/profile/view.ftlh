<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Досье: ${(user.username)!'Неизвестный'} | Cosa Nostra" activeTab="dossiers">

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

        /* Декоративные уголки */
        .dossier-card::before, .dossier-card::after {
            content: '';
            position: absolute;
            width: 14px;
            height: 14px;
            border: 2px solid var(--brass-gold);
        }
        .dossier-card::before { top: 8px; left: 8px; border-right: none; border-bottom: none; }
        .dossier-card::after { bottom: 8px; right: 8px; border-left: none; border-top: none; }

        /* Печать картотеки */
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

        /* Аватар в форме винтажной рамки */
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

        /* Сетка характеристик */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-bottom: 2.5rem;
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
            font-size: 1.1rem;
            color: var(--text-main);
            font-weight: bold;
            word-break: break-all;
        }

        .info-value.gold {
            color: var(--brass-gold);
            font-family: 'Cinzel', serif;
        }

        /* Нижние действия */
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
        }

        .btn-secondary {
            background: transparent;
            color: var(--brass-gold);
            border: var(--border-gold);
        }

        .btn-secondary:hover {
            background: rgba(197, 160, 89, 0.1);
            color: var(--brass-gold-hover);
            border-color: var(--brass-gold-hover);
        }

        .btn-danger {
            background: transparent;
            color: #FF6B6B;
            border: 1px solid var(--burgundy-light);
        }

        .btn-danger:hover {
            background: var(--burgundy-dark);
            color: #FF8888;
        }

        .empty-dossier {
            text-align: center;
            padding: 3rem;
            background: var(--bg-card);
            border: var(--border-gold);
            color: var(--text-muted);
        }
    </style>

    <div class="dossier-container">

        <#if user??>
            <div class="dossier-card">
                <span class="file-stamp">ЛИЧНОЕ ДЕЛО №${user.id}</span>

                <div class="dossier-header">
                    <!-- Первая буква имени в качестве винтажной иконки -->
                    <div class="avatar-box">
                        ${user.username[0]!u}
                    </div>

                    <div class="user-title-group">
                        <h1 class="username-title">${user.username}</h1>
                        <span class="role-badge">${user.role!"ASSOCIATE"}</span>
                    </div>
                </div>

                <!-- Подробные атрибуты из UserResponse -->
                <div class="info-grid">

                    <div class="info-item">
                        <span class="info-label">Идентификатор (ID)</span>
                        <span class="info-value">#${user.id}</span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Псевдоним в системе</span>
                        <span class="info-value gold">${user.username}</span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Статус / Ранг</span>
                        <span class="info-value">${user.role!"Не назначен"}</span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Принадлежность к Семье</span>
                        <#if user.familyId??>
                            <span class="info-value gold">Семья #${user.familyId}</span>
                        <#else>
                            <span class="info-value" style="color: var(--text-muted);">Без семьи</span>
                        </#if>
                    </div>

                </div>

                <!-- Панель кнопок / Действий -->
                <div class="actions-panel">
                    <#if user.familyId??>
                        <a href="/families/${user.familyId}" class="btn-action btn-secondary">
                            🏛️ К клану семьи
                        </a>
                    </#if>
                    <a href="/dossiers" class="btn-action btn-secondary">
                        ← В архив досье
                    </a>
                </div>

            </div>
        <#else>
            <div class="empty-dossier">
                <h2 style="font-family: 'Cinzel', serif; color: var(--brass-gold); margin-bottom: 1rem;">
                    ⛔ Досье не найдено
                </h2>
                <p>Запрошенная карточка участника отсутствует в архиве Cosa Nostra.</p>
                <a href="/dossiers" class="btn-action btn-secondary" style="margin-top: 1.5rem;">
                    Вернуться к картотеке
                </a>
            </div>
        </#if>

    </div>

</@layout.page_layout>