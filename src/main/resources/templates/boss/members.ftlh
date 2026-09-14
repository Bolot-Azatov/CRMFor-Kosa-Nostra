<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="${springMacroRequestContext.getMessage('boss.members.title')} | ${springMacroRequestContext.getMessage('role.boss.badge')}" activeTab="capos">

    <div class="page-header-bar">
        <div>
            <h1 class="title-text"><@spring.message "boss.members.title"/></h1>
            <p class="subtitle-text"><@spring.message "boss.members.subtitle"/></p>
        </div>
        <a href="/boss" style="font-family: var(--font-heading);"><@spring.message "boss.back_to_hq"/></a>
    </div>

    <div class="boss-members-grid">
        <!-- Список бойцов -->
        <div class="table-responsive">
            <table class="speakeasy-table">
                <thead>
                <tr>
                    <th><@spring.message "boss.members.table.id"/></th>
                    <th><@spring.message "boss.members.table.alias"/></th>
                    <th><@spring.message "boss.members.table.rank"/></th>
                    <th><@spring.message "boss.members.table.action"/></th>
                </tr>
                </thead>
                <tbody>
                <#list members as m>
                    <tr>
                        <td>#${m.id}</td>
                        <td style="font-weight: bold;">
                            <a href="/profile/${m.id}">${m.username}</a>
                        </td>
                        <td>
                            <span style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 0.8rem;">${m.role}</span>
                        </td>
                        <td>
                            <button type="button" onclick="selectUserForRole(${m.id}, '${m.username}')" class="btn-action" style="padding: 0.25rem 0.6rem; font-size: 0.75rem;">
                                <@spring.message "boss.members.btn.select"/>
                            </button>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>

        <!-- Форма смены роли -->
        <div style="background: var(--bg-card); border: var(--border-gold); padding: 1.8rem; height: fit-content; box-shadow: var(--box-shadow-card);">
            <h3 style="font-family: var(--font-heading); color: var(--brass-gold); font-size: 1.1rem; text-transform: uppercase; margin-bottom: 1.2rem;">
                🎖 <@spring.message "boss.members.assign_rank.title"/>
            </h3>
            <form action="/boss/members/assign" method="POST">
                <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

                <div class="form-group">
                    <label class="form-label"><@spring.message "boss.members.target_id"/></label>
                    <input type="number"
                           id="targetUserId"
                           name="userId"
                           min="1"
                           step="1"
                           placeholder="1"
                           onkeydown="if(event.key === '-' || event.key === '+' || event.key === 'e' || event.key === 'E') event.preventDefault();"
                           oninput="if(this.value !== '' && this.value < 1) this.value = Math.abs(this.value) || 1;"
                           class="form-input"
                           required />
                </div>

                <div class="form-group">
                    <label class="form-label"><@spring.message "boss.members.new_rank"/></label>
                    <select name="newRole" class="form-select" required>
                        <option value="SOLDIER"><@spring.message "role.soldier.title"/> (Soldier)</option>
                        <option value="CAPO"><@spring.message "role.capo.title"/> (Capo)</option>
                        <option value="CONSIGLIERE"><@spring.message "role.consigliere.title"/> (Consigliere)</option>
                    </select>
                </div>

                <button type="submit" class="btn-submit">
                    <@spring.message "boss.members.btn.order"/>
                </button>
            </form>
        </div>
    </div>

    <script>
        function selectUserForRole(id, name) {
            document.getElementById('targetUserId').value = id;
        }
    </script>

</@layout.page_layout>