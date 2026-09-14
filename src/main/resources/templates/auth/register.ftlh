<#import "/spring.ftl" as spring/>
<#assign bioPlaceholder = springMacroRequestContext.getMessage('auth.register.bio.placeholder')>
<!DOCTYPE html>
<html lang="${springMacroRequestContext.locale.language!'ru'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><@spring.message "auth.register.title"/> | Cosa Nostra</title>

    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='7' fill='%233D0C02' stroke='%23C5A059' stroke-width='1.5'/%3E%3Cg transform='translate(4, 4)' stroke='%23FFFFFF' stroke-width='2' fill='none' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M12 3v18'/%3E%3Cpath d='M7 21h10'/%3E%3Cpath d='M3 7h18'/%3E%3Cpath d='M2 15l3-8 3 8a3 3 0 0 1-6 0z' fill='%23FFFFFF' fill-opacity='0.3'/%3E%3Cpath d='M16 15l3-8 3 8a3 3 0 0 1-6 0z' fill='%23FFFFFF' fill-opacity='0.3'/%3E%3C/g%3E%3C/svg%3E">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;800;900&family=Courier+Prime:wght@400;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="landing-page">

<@spring.bind "registerRequest"/>

<div class="speakeasy-card wide">
    <div style="display: flex; justify-content: flex-end; margin-bottom: 0.5rem;">
        <div class="lang-switch">
            <a href="?lang=ru" class="lang-btn <#if (springMacroRequestContext.locale.language == 'ru')!true>active</#if>">RU</a>
            <span class="lang-divider">/</span>
            <a href="?lang=en" class="lang-btn <#if (springMacroRequestContext.locale.language == 'en')!false>active</#if>">EN</a>
        </div>
    </div>

    <div class="logo-emblem">📜</div>

    <h1 class="brand-title"><@spring.message "auth.register.title"/></h1>
    <p class="brand-subtitle"><@spring.message "auth.register.subtitle"/></p>

    <form action="/register" method="POST">
        <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

        <div class="form-row">
            <div class="form-group">
                <label for="username" class="form-label"><@spring.message "auth.register.username"/></label>
                <@spring.formInput "registerRequest.username" 'id="username" class="form-input" placeholder="Frank_Pentangeli" maxlength="150" required' />
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>

            <div class="form-group">
                <label for="password" class="form-label"><@spring.message "auth.register.password"/></label>
                <@spring.formPasswordInput "registerRequest.password" 'id="password" class="form-input" placeholder="••••••••" maxlength="100" required' />
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="familyName" class="form-label"><@spring.message "auth.register.family"/></label>
                <select id="familyName" name="familyName" class="form-select" required>
                    <option value="" disabled <#if !(registerRequest.familyName)??>selected</#if>>
                        <@spring.message "auth.register.select_family"/>
                    </option>
                    <#if families??>
                        <#list families as f>
                            <option value="${f.name}" <#if (registerRequest.familyName!'') == f.name>selected</#if>>
                                <@spring.message "family.other.family_prefix"/> ${f.name}
                            </option>
                        </#list>
                    </#if>
                </select>
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>

            <div class="form-group">
                <label for="photoUrl" class="form-label"><@spring.message "auth.register.photo_url"/></label>
                <@spring.formInput "registerRequest.photoUrl" 'id="photoUrl" class="form-input" placeholder="https://domain.com/photo.jpg"' />
                <span class="field-error"><@spring.showErrors "<br>"/></span>
            </div>
        </div>

        <div class="form-group">
            <label for="bio" class="form-label"><@spring.message "auth.register.bio"/></label>
            <@spring.formTextarea "registerRequest.bio" 'id="bio" class="form-textarea" placeholder="' + bioPlaceholder + '" maxlength="2500" required style="min-height: 90px; resize: vertical;"' />
            <span class="field-error"><@spring.showErrors "<br>"/></span>
        </div>

        <button type="submit" class="btn-submit" style="margin-top: 1rem;"><@spring.message "auth.register.submit"/></button>
    </form>

    <div style="margin-top: 1.5rem; text-align: center; display: flex; flex-direction: column; gap: 0.6rem; font-size: 0.82rem;">
        <a href="/login"><@spring.message "auth.register.already_member"/></a>
        <a href="/" style="color: var(--text-muted);"><@spring.message "auth.login.to_home"/></a>
    </div>
</div>

</body>
</html>