<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('capo.business.title')} | ${springMacroRequestContext.getMessage('role.capo.title')}" activeTab="racket">

    <div style="max-width: 950px; margin: 0 auto;">
        <div class="page-header-bar">
            <div>
                <h1 class="title-text"><@spring.message "capo.business.title"/></h1>
                <p class="subtitle-text"><@spring.message "capo.business.subtitle"/></p>
            </div>
        </div>

        <div class="capo-grid" style="display: grid; grid-template-columns: 1fr 1.2fr; gap: 2rem;">
            <!-- Левая колонка: Карточка Бизнеса -->
            <div style="background: var(--bg-card); border: var(--border-gold); padding: 2rem; position: relative; box-shadow: var(--box-shadow-card);">
                <h2 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.3rem; margin-bottom: 1.5rem; text-transform: uppercase;">
                    🏛 <@spring.message "capo.business.card_title"/>
                </h2>

                <#if business??>
                    <div class="info-label"><@spring.message "capo.business.name_label"/></div>
                    <div style="font-size: 1.3rem; color: var(--brass-gold); font-weight: bold; margin-bottom: 1.2rem; word-break: break-word;">
                        ${business.name}
                    </div>

                    <div class="info-label"><@spring.message "capo.business.type_label"/></div>
                    <div style="font-size: 1.1rem; color: var(--text-main); font-weight: bold; margin-bottom: 1.2rem; word-break: break-word;">
                        ${business.type}
                    </div>

                    <div class="info-label"><@spring.message "capo.business.revenue_label"/></div>
                    <div style="font-size: 1.3rem; color: #81C784; font-family: var(--font-heading); font-weight: bold; margin-bottom: 1.2rem;">
                        $${business.weeklyRevenue?string[",##0.00"]}
                    </div>

                    <div style="font-size: 0.8rem; color: var(--text-muted); line-height: 1.6; border-top: 1px solid rgba(197,160,89,0.2); padding-top: 1rem;">
                        <@spring.message "capo.business.rule_note"/>
                    </div>
                <#else>
                    <p style="color: #FF7777;"><@spring.message "capo.business.no_business"/></p>
                </#if>
            </div>

            <!-- Правая колонка: Форма сдачи дани -->
            <div style="background: var(--bg-card); border: var(--border-gold); padding: 2rem; position: relative; box-shadow: var(--box-shadow-card);">
                <h2 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.3rem; margin-bottom: 1.5rem; text-transform: uppercase;">
                    💰 <@spring.message "capo.business.tribute_title"/>
                </h2>

                <#if business??>
                    <form action="/capo/tribute" method="POST" id="tributeForm">
                        <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                        <input type="hidden" name="source" value="business"/>

                        <div class="form-group">
                            <label class="form-label" for="amount"><@spring.message "capo.business.amount_label"/></label>
                            <input type="number"
                                   step="0.01"
                                   min="100.00"
                                   name="amount"
                                   id="amount"
                                   class="form-input"
                                   placeholder="5000.00"
                                   value="${(tributeRequest.amount)!''}"
                                   onkeydown="if(event.key === '-' || event.key === '+' || event.key === 'e' || event.key === 'E') event.preventDefault();"
                                   oninput="if(this.value !== '' && this.value < 0) this.value = Math.abs(this.value);"
                                   required
                                   autofocus />
                        </div>

                        <!-- Интерактивный предпросмотр долей (JS) -->
                        <div class="calculator-preview" style="background: #121212; border: 1px dashed rgba(197, 160, 89, 0.3); padding: 1rem; margin: 1.2rem 0; display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; text-align: center;">
                            <div>
                                <div style="font-size: 0.72rem; text-transform: uppercase; color: var(--text-muted);"><@spring.message "capo.business.calc.treasury"/></div>
                                <div id="treasuryShare" style="font-family: var(--font-heading); font-size: 1.2rem; font-weight: bold; margin-top: 0.3rem; color: #81C784;">$0.00</div>
                            </div>
                            <div>
                                <div style="font-size: 0.72rem; text-transform: uppercase; color: var(--text-muted);"><@spring.message "capo.business.calc.capo"/></div>
                                <div id="capoShare" style="font-family: var(--font-heading); font-size: 1.2rem; font-weight: bold; margin-top: 0.3rem; color: var(--brass-gold);">$0.00</div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="description"><@spring.message "capo.business.desc_label"/></label>
                            <textarea name="description" id="description" rows="3" class="form-textarea" placeholder="<@spring.message 'capo.tribute.desc_placeholder'/>" style="resize: vertical;">${(tributeRequest.description)!''}</textarea>
                        </div>

                        <button type="submit" class="btn-submit"><@spring.message "capo.business.submit"/></button>
                    </form>
                <#else>
                    <div style="background: #121212; border: 1px solid rgba(255,119,119,0.3); padding: 1.5rem; text-align: center; color: var(--text-muted);">
                        <p style="color: #FF7777; margin-bottom: 0.5rem;">⛔ <@spring.message "capo.business.tribute_locked"/></p>
                    </div>
                </#if>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const amountInput = document.getElementById('amount');
            const treasuryShareEl = document.getElementById('treasuryShare');
            const capoShareEl = document.getElementById('capoShare');
            const tributeForm = document.getElementById('tributeForm');

            function updateShares() {
                if (!amountInput) return;
                const rawValue = parseFloat(amountInput.value);

                if (isNaN(rawValue) || rawValue <= 0) {
                    treasuryShareEl.innerText = '$0.00';
                    capoShareEl.innerText = '$0.00';
                    return;
                }

                const familyPart = (rawValue * 0.80).toFixed(2);
                const capoPart = (rawValue * 0.20).toFixed(2);

                treasuryShareEl.innerText = '$' + Number(familyPart).toLocaleString();
                capoShareEl.innerText = '$' + Number(capoPart).toLocaleString();
            }

            if (amountInput) {
                amountInput.addEventListener('input', updateShares);
                updateShares(); // Первоначальный расчет при перезагрузке с заполненным значением
            }

            if (tributeForm) {
                tributeForm.addEventListener('submit', function(event) {
                    const val = parseFloat(amountInput.value);
                    if (val < 100) {
                        alert("${springMacroRequestContext.getMessage('capo.tribute.js.min_alert')?js_string}");
                        event.preventDefault();
                        return;
                    }

                    const confirmTemplate = "${springMacroRequestContext.getMessage('capo.tribute.js.confirm')?js_string}";
                    const confirmed = confirm(confirmTemplate.replace('%s', (val * 0.80).toFixed(2)));
                    if (!confirmed) {
                        event.preventDefault();
                    }
                });
            }
        });
    </script>

</@layout.page_layout>