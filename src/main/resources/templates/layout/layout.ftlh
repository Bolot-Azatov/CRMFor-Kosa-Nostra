<#import "/spring.ftl" as spring/>

<#macro page_layout title=springMacroRequestContext.getMessage("app.title") activeTab="">
    <!DOCTYPE html>
    <html lang="${springMacroRequestContext.locale.language!'ru'}">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0">
        <title>${title}</title>

        <!-- Тематический фавикон: золотые весы на темно-бордовой сургучной печати -->
        <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='7' fill='%233D0C02' stroke='%23C5A059' stroke-width='1.5'/%3E%3Cg transform='translate(4, 4)' stroke='%23FFFFFF' stroke-width='2' fill='none' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M12 3v18'/%3E%3Cpath d='M7 21h10'/%3E%3Cpath d='M3 7h18'/%3E%3Cpath d='M2 15l3-8 3 8a3 3 0 0 1-6 0z' fill='%23FFFFFF' fill-opacity='0.3'/%3E%3Cpath d='M16 15l3-8 3 8a3 3 0 0 1-6 0z' fill='%23FFFFFF' fill-opacity='0.3'/%3E%3C/g%3E%3C/svg%3E">
        <!-- Шрифты Cinzel и Courier Prime -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;800;900&family=Courier+Prime:wght@400;700&display=swap" rel="stylesheet">

        <!-- Единый мастер-стиль -->
        <link rel="stylesheet" href="/css/style.css">

        <!-- Определение контекста пользователя и ролей Spring Security -->
        <#global known = SPRING_SECURITY_CONTEXT??>
        <#global isBoss = false>
        <#global isConsigliere = false>
        <#global isCapo = false>
        <#global isSoldier = false>

        <#if known>
            <#assign principal = SPRING_SECURITY_CONTEXT.authentication.principal>
            <#assign username = principal.username!>
            <#assign authorities = SPRING_SECURITY_CONTEXT.authentication.authorities!>

            <#list authorities as auth>
                <#if auth.authority == "ROLE_BOSS" || auth.authority == "BOSS">
                    <#global isBoss = true>
                </#if>
                <#if auth.authority == "ROLE_CONSIGLIERE" || auth.authority == "CONSIGLIERE" || auth.authority == "ROLE_COUNSELOR">
                    <#global isConsigliere = true>
                </#if>
                <#if auth.authority == "ROLE_CAPO" || auth.authority == "CAPO">
                    <#global isCapo = true>
                </#if>
                <#if auth.authority == "ROLE_SOLDIER" || auth.authority == "SOLDIER">
                    <#global isSoldier = true>
                </#if>
            </#list>

            <#if isBoss>
                <#assign roleBadge = springMacroRequestContext.getMessage("role.boss.badge")>
                <#assign roleTitle = springMacroRequestContext.getMessage("role.boss.title")>
            <#elseif isConsigliere>
                <#assign roleBadge = springMacroRequestContext.getMessage("role.consigliere.badge")>
                <#assign roleTitle = springMacroRequestContext.getMessage("role.consigliere.title")>
            <#elseif isCapo>
                <#assign roleBadge = springMacroRequestContext.getMessage("role.capo.badge")>
                <#assign roleTitle = springMacroRequestContext.getMessage("role.capo.title")>
            <#elseif isSoldier>
                <#assign roleBadge = springMacroRequestContext.getMessage("role.soldier.badge")>
                <#assign roleTitle = springMacroRequestContext.getMessage("role.soldier.title")>
            <#else>
                <#assign roleBadge = springMacroRequestContext.getMessage("role.associate.badge")>
                <#assign roleTitle = springMacroRequestContext.getMessage("role.associate.title")>
            </#if>
        </#if>
    </head>
    <body>

    <header class="speakeasy-navbar">
        <div class="navbar-top">
            <a href="/" class="brand-logo"><@spring.message "app.brand"/></a>

            <div class="user-status">
                <!-- Переключатель языка -->
                <div class="lang-switch">
                    <a href="?lang=ru" class="lang-btn <#if (springMacroRequestContext.locale.language == 'ru')!true>active</#if>">RU</a>
                    <span class="lang-divider">/</span>
                    <a href="?lang=en" class="lang-btn <#if (springMacroRequestContext.locale.language == 'en')!false>active</#if>">EN</a>
                </div>

                <#if known>
                    <a href="/profile" class="user-profile-link" title="<@spring.message 'user.profile.title'/>">
                        <div class="avatar-frame">${roleBadge!"MBR"}</div>
                        <div>
                            <div style="color: var(--brass-gold); font-family: var(--font-heading); font-weight: bold; font-size: 0.85rem;">
                                ${username!springMacroRequestContext.getMessage("user.anonymous")}
                            </div>
                            <div style="color: var(--text-muted); font-size: 0.68rem; text-transform: uppercase;">
                                ${roleTitle!springMacroRequestContext.getMessage("user.associate")}
                            </div>
                        </div>
                    </a>

                    <form action="/logout" method="post" class="logout-form" onsubmit="localStorage.removeItem('syndicate_playlist'); localStorage.removeItem('syndicate_track_idx'); localStorage.removeItem('syndicate_audio_time');">
                        <#if _csrf??>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </#if>
                        <button type="submit" class="logout-btn" title="<@spring.message 'user.logout'/>">
                            🚪 <@spring.message "user.logout"/>
                        </button>
                    </form>
                <#else>
                    <a href="/login" class="btn-auth-link"><@spring.message "user.login"/></a>
                    <a href="/register" class="btn-auth-link" style="border-color: rgba(197, 160, 89, 0.6); background: rgba(197, 160, 89, 0.1);"><@spring.message "user.register"/></a>
                </#if>
            </div>
        </div>

        <nav class="navbar-menu">
            <ul class="nav-links">
                <li>
                    <a href="/" class="nav-link <#if activeTab == 'home'>active</#if>"><@spring.message "nav.home"/></a>
                </li>
                <li>
                    <a href="/articles" class="nav-link <#if activeTab == 'articles'>active</#if>"><@spring.message "nav.articles"/></a>
                </li>

                <#if known>
                    <li>
                        <a href="/hierarchy" class="nav-link <#if activeTab == 'family'>active</#if>"><@spring.message "nav.hierarchy"/></a>
                    </li>

                    <#if isCapo>
                        <li>
                            <a href="/capo/business" class="nav-link <#if activeTab == 'racket' || activeTab == 'business'>active</#if>"><@spring.message "nav.capo.racket"/></a>
                        </li>
                        <li>
                            <a href="/capo/tribute" class="nav-link <#if activeTab == 'tribute'>active</#if>"><@spring.message "nav.capo.tribute"/></a>
                        </li>
                    </#if>

                    <#if isConsigliere>
                        <li>
                            <a href="/consigliere/ledger" class="nav-link <#if activeTab == 'ledger'>active</#if>"><@spring.message "nav.consigliere.ledger"/></a>
                        </li>
                        <li>
                            <a href="/consigliere/messages" class="nav-link <#if activeTab == 'message'>active</#if>"><@spring.message "nav.consigliere.messages"/></a>
                        </li>
                    </#if>

                    <#if isBoss>
                        <li>
                            <a href="/boss/dashboard" class="nav-link <#if activeTab == 'dashboard'>active</#if>"><@spring.message "nav.boss.dashboard"/></a>
                        </li>
                        <li>
                            <a href="/boss/members" class="nav-link <#if activeTab == 'capos'>active</#if>"><@spring.message "nav.boss.members"/></a>
                        </li>
                        <li>
                            <a href="/boss/businesses" class="nav-link <#if activeTab == 'businesses'>active</#if>"><@spring.message "nav.boss.businesses"/></a>
                        </li>
                        <li>
                            <a href="/boss/treasury" class="nav-link <#if activeTab == 'boss_ledger'>active</#if>"><@spring.message "nav.boss.treasury"/></a>
                        </li>
                        <li>
                            <a href="/boss/diplomacy" class="nav-link <#if activeTab == 'diplomacy'>active</#if>"><@spring.message "nav.boss.diplomacy"/></a>
                        </li>
                        <li>
                            <a href="/boss/messages" class="nav-link <#if activeTab == 'messages'>active</#if>"><@spring.message "nav.boss.messages"/></a>
                        </li>
                    </#if>
                </#if>
            </ul>
        </nav>
    </header>

    <main class="main-container">

        <#if spring.status?? && spring.status.errorMessages?has_content>
            <div class="alert-box">
                <div class="alert-title">⚠️ <@spring.message "alert.errors.title"/></div>
                <ul>
                    <#list spring.status.errorMessages as error>
                        <li>${error}</li>
                    </#list>
                </ul>
            </div>
        </#if>

        <#if errorMessage??>
            <div class="alert-box">
                <div class="alert-title">⛔ <@spring.message "alert.omerta.violation"/></div>
                <p><@spring.messageText errorMessage, errorMessage/></p>
            </div>
        </#if>

        <#if successMessage??>
            <div class="alert-box alert-success">
                <div class="alert-title" style="color: #81C784;">🗡️ <@spring.message "alert.case.closed"/></div>
                <p><@spring.messageText successMessage, successMessage/></p>
            </div>
        </#if>

        <#nested/>

    </main>

    <!-- Аудио-плеер Синдиката -->
    <audio id="syndicateAudio" preload="auto"></audio>

    <!-- Скромная кнопка управления звуком в углу экрана -->
    <div id="audioControls" style="position: fixed; bottom: 15px; right: 15px; z-index: 9999; background: var(--bg-card); border: var(--border-gold); padding: 6px 12px; display: flex; align-items: center; gap: 8px; font-family: var(--font-heading); font-size: 0.75rem; box-shadow: 0 2px 10px rgba(0,0,0,0.8);">
        <span id="audioTrackName" style="color: var(--brass-gold); max-width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
            ♫ Синдикат
        </span>
        <button type="button" id="audioToggleBtn" style="background: none; border: none; color: var(--brass-gold); cursor: pointer; font-size: 1rem; line-height: 1;">
            🔊
        </button>
    </div>

    <script>
        (function() {
            // Список доступных треков
            const TRACKS = [
                { src: '/audio/track1.mp3', title: 'Композиция I' },
                { src: '/audio/track2.mp3', title: 'Композиция II' },
                { src: '/audio/track3.mp3', title: 'Композиция III' }
            ];

            const audio = document.getElementById('syndicateAudio');
            const toggleBtn = document.getElementById('audioToggleBtn');
            const trackNameEl = document.getElementById('audioTrackName');

            // Алгоритм Фишера-Йетса для честного случайного перемешивания очереди
            function shuffle(array) {
                const arr = [...array];
                for (let i = arr.length - 1; i > 0; i--) {
                    const j = Math.floor(Math.random() * (i + 1));
                    [arr[i], arr[j]] = [arr[j], arr[i]];
                }
                return arr;
            }

            // Инициализация или получение перемешанного плейлиста
            function getPlaylist() {
                let playlist = null;
                try {
                    playlist = JSON.parse(localStorage.getItem('syndicate_playlist'));
                } catch (e) {}

                // Если списка еще нет или он пуст — генерируем случайный порядок
                if (!playlist || !Array.isArray(playlist) || playlist.length === 0) {
                    playlist = shuffle(TRACKS);
                    localStorage.setItem('syndicate_playlist', JSON.stringify(playlist));
                    localStorage.setItem('syndicate_track_idx', '0');
                    localStorage.setItem('syndicate_audio_time', '0');
                }
                return playlist;
            }

            let playlist = getPlaylist();
            let currentIndex = parseInt(localStorage.getItem('syndicate_track_idx') || '0', 10);
            if (currentIndex >= playlist.length) currentIndex = 0;

            function loadAndPlayCurrent(startTime = 0) {
                const track = playlist[currentIndex];
                audio.src = track.src;
                trackNameEl.textContent = '♫ ' + track.title;
                trackNameEl.title = track.title;

                audio.addEventListener('loadedmetadata', function onLoaded() {
                    if (startTime > 0 && startTime < audio.duration) {
                        audio.currentTime = startTime;
                    }
                    audio.removeEventListener('loadedmetadata', onLoaded);
                });

                // Пробуем запустить воспроизведение
                const isMuted = localStorage.getItem('syndicate_audio_muted') === 'true';
                if (!isMuted) {
                    audio.play().then(() => {
                        toggleBtn.textContent = '🔊';
                    }).catch(() => {
                        // Если браузер заблокировал autoplay без клика — ждем первого клика по странице
                        toggleBtn.textContent = '🔇';
                        const unlockAutoplay = () => {
                            if (localStorage.getItem('syndicate_audio_muted') !== 'true') {
                                audio.play().then(() => {
                                    toggleBtn.textContent = '🔊';
                                }).catch(() => {});
                            }
                            window.removeEventListener('click', unlockAutoplay);
                        };
                        window.addEventListener('click', unlockAutoplay);
                    });
                } else {
                    toggleBtn.textContent = '🔇';
                }
            }

            // Событие: трек закончился -> переходим к следующему по рандомной очереди
            audio.addEventListener('ended', function() {
                currentIndex++;
                // Когда все 3 композиции из очереди отыграли:
                if (currentIndex >= playlist.length) {
                    // Заново перемешиваем треки в новом случайном порядке!
                    playlist = shuffle(TRACKS);
                    localStorage.setItem('syndicate_playlist', JSON.stringify(playlist));
                    currentIndex = 0;
                }
                localStorage.setItem('syndicate_track_idx', currentIndex.toString());
                localStorage.setItem('syndicate_audio_time', '0');
                loadAndPlayCurrent(0);
            });

            // Сохраняем секунду воспроизведения перед уходом/переходом на другую страницу
            window.addEventListener('beforeunload', function() {
                if (!audio.paused && !isNaN(audio.currentTime)) {
                    localStorage.setItem('syndicate_audio_time', audio.currentTime.toString());
                }
            });

            // Кнопка включения/выключения звука
            toggleBtn.addEventListener('click', function(e) {
                e.stopPropagation();
                if (audio.paused) {
                    audio.play().then(() => {
                        localStorage.setItem('syndicate_audio_muted', 'false');
                        toggleBtn.textContent = '🔊';
                    }).catch(() => {});
                } else {
                    audio.pause();
                    localStorage.setItem('syndicate_audio_muted', 'true');
                    toggleBtn.textContent = '🔇';
                }
            });

            // Запуск при открытии страницы с восстановлением прогресса воспроизведения
            const savedTime = parseFloat(localStorage.getItem('syndicate_audio_time') || '0');
            loadAndPlayCurrent(savedTime);
        })();
    </script>

    </body>
    </html>
</#macro>