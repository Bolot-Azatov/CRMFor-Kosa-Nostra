<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('capo.tribute.title')} | Cosa Nostra" activeTab="racket">

    <div style="max-width: 680px; margin: 0 auto;">

        <div style="background: var(--bg-card); border: var(--border-gold); padding: clamp(1.5rem, 4vw, 2.8rem); position: relative; box-shadow: 0 4px 30px rgba(0, 0, 0, 0.9), inset 0 0 20px rgba(61, 12, 2, 0.4);">

            <!-- Печать банковского ордера -->
            <div class="file-stamp" style="border: 2px dashed var(--brass-gold); color: var(--brass-gold); top: 1.5rem; right: 1.5rem;">
                <@spring.message "capo.tribute.stamp"/>
            </div>

            <h1 style="font-family: var(--font-heading); font-size: clamp(1.6rem, 4vw, 2rem); font-weight: 800; color: var(--brass-gold); letter-spacing: 2px; text-transform: uppercase; margin-bottom: 0.4rem;">
                <@spring.message "capo.tribute.title"/>
            </h1>
            <p style="color: var(--text-muted); font-size: 0.82rem; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 2rem; border-bottom: 1px solid rgba(197, 160, 89, 0.2); padding-bottom: 0.8rem;">
                <@spring.message "capo.tribute.subtitle"/>
            </p>

            <div style="font-size: 0.82rem; color: var(--text-muted); line-height: 1.6; border-left: 3px solid var(--brass-gold); padding-left: 1rem; margin-bottom: 1.5rem; background: rgba(197,160,89,0.04); padding-top: 0.5rem; padding-bottom: 0.5rem;">
                <@spring.message "capo.tribute.rule_alert"/>
            </div>

            <form action="/capo/tribute" method="POST" id="tributeForm">
                <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

                <div class="form-group">
                    <label for="amountInput" class="form-label"><@spring.message "capo.tribute.amount_label"/></label>
                    <input type="number"
                           step="0.01"
                           min="100.00"
                           id="amountInput"
                           name="amount"
                           class="form-input"
                           placeholder="1000.00"
                           onkeydown="if(event.key === '-' || event.key === '+' || event.key === 'e' || event.key === 'E') event.preventDefault();"
                           oninput="if(this.value !== '' && this.value < 0) this.value = Math.abs(this.value);"
                           required
                           autofocus />
                </div>

                <!-- Блок расчета долей -->
                <div class="ledger-preview" style="background: #121212; border: 1px dashed rgba(197, 160, 89, 0.35); padding: 1.2rem; margin: 1.5rem 0; display: grid; grid-template-columns: 1fr 1fr; gap: 1.2rem; text-align: center;">
                    <div>
                        <div style="font-size: 0.72rem; text-transform: uppercase; color: var(--text-muted); letter-spacing: 1px;"><@spring.message "capo.tribute.calc.treasury"/></div>
                        <div id="treasuryPreview" style="font-family: var(--font-heading); font-size: 1.3rem; font-weight: bold; margin-top: 0.4rem; color: #81C784;">$0.00</div>
                    </div>
                    <div>
                        <div style="font-size: 0.72rem; text-transform: uppercase; color: var(--text-muted); letter-spacing: 1px;"><@spring.message "capo.tribute.calc.capo"/></div>
                        <div id="capoPreview" style="font-family: var(--font-heading); font-size: 1.3rem; font-weight: bold; margin-top: 0.4rem; color: var(--brass-gold);">$0.00</div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="description" class="form-label"><@spring.message "capo.tribute.desc_label"/></label>
                    <textarea id="description"
                              name="description"
                              rows="3"
                              class="form-textarea"
                              placeholder="${springMacroRequestContext.getMessage('capo.tribute.desc_placeholder')}"
                              style="resize: vertical;"></textarea>
                </div>

                <button type="submit" class="btn-submit" id="submitBtn"><@spring.message "capo.tribute.submit"/></button>
            </form>

            <a href="/capo/business" style="display: inline-block; margin-top: 1.5rem; font-family: var(--font-heading); font-size: 0.82rem; letter-spacing: 1px; text-transform: uppercase;">
                <@spring.message "capo.tribute.back_to_biz"/>
            </a>
        </div>

    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const amountInput = document.getElementById('amountInput');
            const treasuryPreview = document.getElementById('treasuryPreview');
            const capoPreview = document.getElementById('capoPreview');
            const tributeForm = document.getElementById('tributeForm');

            amountInput.addEventListener('input', function(event) {
                const raw = parseFloat(event.target.value);

                if (isNaN(raw) || raw <= 0) {
                    treasuryPreview.innerText = '$0.00';
                    capoPreview.innerText = '$0.00';
                    return;
                }

                const treasuryPart = (raw * 0.80).toFixed(2);
                const capoPart = (raw * 0.20).toFixed(2);

                treasuryPreview.innerText = '$' + Number(treasuryPart).toLocaleString(undefined, {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                });
                capoPreview.innerText = '$' + Number(capoPart).toLocaleString(undefined, {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                });
            });

            tributeForm.addEventListener('submit', function(event) {
                const val = parseFloat(amountInput.value);
                if (val < 100) {
                    alert("${springMacroRequestContext.getMessage('capo.tribute.js.min_alert')}");
                    event.preventDefault();
                    return;
                }

                const confirmTemplate = "${springMacroRequestContext.getMessage('capo.tribute.js.confirm')}";
                const confirmed = confirm(confirmTemplate.replace('%s', (val * 0.80).toFixed(2)));
                if (!confirmed) {
                    event.preventDefault();
                }
            });
        });
    </script>

</@layout.page_layout>