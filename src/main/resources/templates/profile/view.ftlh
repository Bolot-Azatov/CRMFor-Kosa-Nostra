<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Досье: ${(user.username)!'Неизвестный'} | Cosa Nostra" activeTab="profile">

    <div class="dossier-container">
        <#if user??>
            <div class="dossier-card">
                <span class="file-stamp">ЛИЧНОЕ ДЕЛО №${user.id}</span>

                <div class="dossier-header">
                    <!-- Фотография бойца -->
                    <div class="avatar-box <#if (user.photoUrl)?? && user.photoUrl?has_content>clickable</#if>"
                            <#if (user.photoUrl)?? && user.photoUrl?has_content>
                        onclick="openPhotoModal('${user.photoUrl}')"
                        title="Нажмите, чтобы увеличить фото"
                            </#if>>
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
                    <p class="bio-text">${((user.bio)!"Записи в архиве отсутствуют...")?trim}</p>
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

            <!-- Модальное окно зума фото -->
            <div id="photoModal" class="photo-modal" onclick="closePhotoModal(event)">
                <div class="photo-modal-card">
                    <button type="button" class="photo-modal-close" onclick="closeModalDirect()" title="Закрыть">&times;</button>
                    <img id="modalImage" src="" alt="${user.username}" class="photo-modal-img"/>
                    <div class="photo-modal-caption">${user.username} • Архивное фото</div>
                </div>
            </div>

            <script>
                function openPhotoModal(src) {
                    const modal = document.getElementById('photoModal');
                    const img = document.getElementById('modalImage');
                    if (modal && img) {
                        img.src = src;
                        modal.classList.add('active');
                    }
                }

                function closeModalDirect() {
                    const modal = document.getElementById('photoModal');
                    if (modal) {
                        modal.classList.remove('active');
                    }
                }

                function closePhotoModal(event) {
                    if (event.target.id === 'photoModal') {
                        closeModalDirect();
                    }
                }

                document.addEventListener('keydown', function(e) {
                    if (e.key === 'Escape') {
                        closeModalDirect();
                    }
                });
            </script>

        <#else>
            <div style="text-align: center; padding: 3rem; background: var(--bg-card); border: var(--border-gold);">
                <h2 style="font-family: var(--font-heading); color: var(--brass-gold); margin-bottom: 1rem; text-transform: uppercase;">
                    ⛔ Досье не найдено
                </h2>
                <p style="color: var(--text-muted);">Запрошенная карточка участника отсутствует в архиве Cosa Nostra.</p>
                <a href="/" class="btn-action" style="margin-top: 1.5rem;">Вернуться на главную</a>
            </div>
        </#if>
    </div>

</@layout.page_layout>