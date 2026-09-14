<!-- src/main/resources/templates/boss/members.ftlh -->
<#import "/spring.ftl" as spring/>
<#import "../layout/layout.ftlh" as layout/>

<@layout.page_layout title="Кадровый Учет | Дон" activeTab="capos">

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; border-bottom: 1px solid rgba(197,160,89,0.2); padding-bottom: 1rem;">
        <div>
            <h1 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 2rem; margin: 0;">Состав и Кадры Семьи</h1>
            <p style="color: var(--text-muted); font-size: 0.85rem; text-transform: uppercase;">Послужной список бойцов и присвоение званий</p>
        </div>
        <a href="/boss" style="color: var(--brass-gold); text-decoration: none; font-family: 'Cinzel', serif;">← В Кабинет Дона</a>
    </div>

    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 2rem;">
        <!-- Список бойцов -->
        <div>
            <table style="width: 100%; border-collapse: collapse; background: var(--bg-card); border: var(--border-gold);">
                <thead>
                <tr style="background: var(--burgundy-dark); color: var(--brass-gold); font-family: 'Cinzel', serif; text-align: left;">
                    <th style="padding: 0.8rem;">ID</th>
                    <th style="padding: 0.8rem;">Псевдоним</th>
                    <th style="padding: 0.8rem;">Ранг</th>
                    <th style="padding: 0.8rem;">Действие</th>
                </tr>
                </thead>
                <tbody>
                <#list members as m>
                    <tr style="border-bottom: 1px solid rgba(197,160,89,0.15);">
                        <td style="padding: 0.8rem;">#${m.id}</td>
                        <td style="padding: 0.8rem; font-weight: bold; color: var(--text-main);">
                            <a href="/profile/${m.id}" style="color: inherit; text-decoration: none;">${m.username}</a>
                        </td>
                        <td style="padding: 0.8rem;">
                            <span style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 0.8rem;">${m.role}</span>
                        </td>
                        <td style="padding: 0.8rem;">
                            <button onclick="selectUserForRole(${m.id}, '${m.username}')" style="background: transparent; border: 1px solid var(--brass-gold); color: var(--brass-gold); padding: 0.2rem 0.6rem; font-size: 0.75rem; cursor: pointer;">
                                Выбрать
                            </button>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>

        <!-- Форма смены роли -->
        <div style="background: var(--bg-card); border: var(--border-gold); padding: 1.8rem; height: fit-content;">
            <h3 style="font-family: 'Cinzel', serif; color: var(--brass-gold); font-size: 1.1rem; text-transform: uppercase; margin-bottom: 1.2rem;">
                🎖 Присвоение звания
            </h3>
            <form action="/boss/members/assign" method="POST">
                <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>

                <div style="margin-bottom: 1rem;">
                    <label style="display:block; font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; margin-bottom: 0.3rem;">ID Бойца *</label>
                    <input type="number"
                           id="targetUserId"
                           name="userId"
                           min="1"
                           step="1"
                           onkeydown="if(event.key === '-' || event.key === '+' || event.key === 'e' || event.key === 'E') event.preventDefault();"
                           oninput="if(this.value !== '' && this.value < 1) this.value = Math.abs(this.value) || 1;"
                           placeholder="1"
                           style="width: 100%; padding: 0.7rem; background: #121212; border: var(--border-gold); color: var(--text-main);"
                           required />
                </div>

                <div style="margin-bottom: 1.5rem;">
                    <label style="display:block; font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; margin-bottom: 0.3rem;">Новое звание *</label>
                    <select name="newRole" style="width: 100%; padding: 0.7rem; background: #121212; border: var(--border-gold); color: var(--text-main);" required>
                        <option value="SOLDIER">Солдат (Soldier)</option>
                        <option value="CAPO">Капореджиме (Capo)</option>
                        <option value="CONSIGLIERE">Консильери (Consigliere - макс. 1)</option>
                    </select>
                </div>

                <button type="submit" style="width: 100%; padding: 0.8rem; background: linear-gradient(180deg, var(--brass-gold) 0%, #8C6D33 100%); color: #0A0A0A; border: none; font-family: 'Cinzel', serif; font-weight: bold; cursor: pointer; text-transform: uppercase;">
                    Издать приказ
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