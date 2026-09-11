--liquibase formatted sql

--changeset dev:02-insert-initial-data

-- =================================================================
-- 1. СЕМЬИ (5 СЕМЕЙ НЬЮ-ЙОРКА)
-- =================================================================
INSERT INTO families (id, name, treasury_balance) VALUES
(1, 'Gambino', 250000.00),
(2, 'Genovese', 310000.00),
(3, 'Lucchese', 180000.00),
(4, 'Bonanno', 150000.00),
(5, 'Colombo', 120000.00);

-- =================================================================
-- 2. УЧАСТНИКИ СЕМЕЙ (Пароль для всех: password123)
-- Hash: $2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK
-- =================================================================

-- Семья Gambino
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
(1, 'carlo_gambino', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'BOSS', 1, 'https://images.example.com/gambino.jpg', 'Босс семьи Гамбино. Хитрый и рассудительный стратег.'),
(2, 'joseph_biondo', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CONSIGLIERE', 1, 'https://images.example.com/biondo.jpg', 'Правая рука Карло Гамбино, советник по финансовым вопросам.'),
(3, 'aniello_dellacroce', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CAPO', 1, 'https://images.example.com/dellacroce.jpg', 'Влиятельный капо, контролирующий порты Манхэттена.'),
(4, 'paul_castellano', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'SOLDIER', 1, 'https://images.example.com/castellano.jpg', 'Преданный солдат семьи, занимается белыми воротничками.');

-- Семья Genovese
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
(5, 'vito_genovese', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'BOSS', 2, 'https://images.example.com/genovese.jpg', 'Босс семьи Дженовезе. Жестокий и амбициозный лидер.'),
(6, 'michele_miranda', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CONSIGLIERE', 2, 'https://images.example.com/miranda.jpg', 'Опытный консильери семьи Дженовезе.'),
(7, 'anthony_salerno', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CAPO', 2, 'https://images.example.com/salerno.jpg', 'Капо по кличке "Толстый Тони", держит рэкет в Гарлеме.'),
(8, 'vincent_gigante', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'SOLDIER', 2, 'https://images.example.com/gigante.jpg', 'Боец семьи, силовой исполнитель специальных поручений.');

-- Семья Lucchese
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
(9, 'tommy_lucchese', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'BOSS', 3, 'https://images.example.com/lucchese.jpg', 'Босс семьи Луккезе. Мастер закулисных альянсов.'),
(10, 'vincenzo_rao', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CONSIGLIERE', 3, 'https://images.example.com/rao.jpg', 'Консильери семьи Луккезе, юрист и медиатор.'),
(11, 'anthony_corallo', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CAPO', 3, 'https://images.example.com/corallo.jpg', 'Капо по кличке "Утка", держит профсоюзы грузоперевозок.');

-- Семья Bonanno
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
(12, 'joseph_bonanno', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'BOSS', 4, 'https://images.example.com/bonanno.jpg', 'Босс семьи Бонанно по кличке "Джо Бананас".'),
(13, 'john_tartamella', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CONSIGLIERE', 4, 'https://images.example.com/tartamella.jpg', 'Старый консильери семьи Бонанно.'),
(14, 'carmine_galante', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CAPO', 4, 'https://images.example.com/galante.jpg', 'Агрессивный капо, контролирующий импорт и распределение.');

-- Семья Colombo
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
(15, 'joe_profaci', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'BOSS', 5, 'https://images.example.com/profaci.jpg', 'Основатель семьи Профачи (позже Коломбо). Оливковый король.'),
(16, 'joseph_magliocco', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CONSIGLIERE', 5, 'https://images.example.com/magliocco.jpg', 'Консильери семьи Коломбо/Профачи.'),
(17, 'carmine_persico', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CAPO', 5, 'https://images.example.com/persico.jpg', 'Молодой и дерзкий капо по кличке "Змея".');

-- =================================================================
-- 3. БИЗНЕСЫ (СВЯЗАННЫЕ С КАПО)
-- =================================================================
INSERT INTO businesses (id, name, type, weekly_revenue, capo_id, family_id) VALUES
(1, 'Brooklyn Docks Union', 'Docks & Freight', 45000.00, 3, 1),
(2, 'Fulton Fish Market', 'Wholesale Market', 60000.00, 7, 2),
(3, 'Garment District Apparel', 'Textile & Labor', 35000.00, 11, 3),
(4, 'Brooklyn Bakeries & Import', 'Food & Olive Oil', 28000.00, 14, 4),
(5, 'South Brooklyn Gambling Den', 'Underground Casino', 32000.00, 17, 5);

-- =================================================================
-- 4. ДИПЛОМАТИЯ МЕЖДУ СЕМЬЯМИ (10 ПАР)
-- =================================================================
INSERT INTO family_relations (id, family_1_id, family_2_id, status, initiator_family_id) VALUES
                                                                                             (1, 1, 2, 'PEACE', NULL),
                                                                                             (2, 1, 3, 'PEACE', NULL),
                                                                                             (3, 1, 4, 'WAR', NULL),
                                                                                             (4, 1, 5, 'PEACE', NULL),
                                                                                             (5, 2, 3, 'PEACE', NULL),
                                                                                             (6, 2, 4, 'PENDING_PEACE', 2),
                                                                                             (7, 2, 5, 'PEACE', NULL),
                                                                                             (8, 3, 4, 'PEACE', NULL),
                                                                                             (9, 3, 5, 'PEACE', NULL),
                                                                                             (10, 4, 5, 'PEACE', NULL);

-- =================================================================
-- 5. ИСТОРИЧЕСКИЕ СТАТЬИ (ОБЩИЕ + ВСЕ 5 СЕМЕЙ НЬЮ-ЙОРКА)
-- =================================================================
INSERT INTO articles (id, title, content, is_public, family_id) VALUES
                                                                    (1, 'Образование Комиссии 1931 года',
                                                                     'В 1931 году после Кастелламмарской войны Чарльз «Лаки» Лучано сформировал Комиссию — руководящий совет американской Коза Ностры. Было упразднено звание Capo di tutti i capi, а Нью-Йорк окончательно разделен между Пятью Семьями на равноправных началах.',
                                                                     TRUE, NULL),

                                                                    (2, 'Кодекс Омерты и структура Синдиката',
                                                                     'Власть в семьях строится на абсолютной субординации: Дон принимает глобальные решения, Консильери выступает советником и хранителем книг, Капореджиме управляют закрепленными районами и бизнесами, отдавая 80% выручки в казну, а Солдаты обеспечивают силовую защиту.',
                                                                     TRUE, NULL),

                                                                    (3, 'Семья Gambino: Владыки доков и Бруклина',
                                                                     'Семья Гамбино — один из самых многочисленных и богатых кланов Нью-Йорка. Под руководством Карло Гамбино организация взяла под контроль профсоюзы грузоперевозок, портовые доки Бруклина, Garment District и строительный картель Манхэттена.',
                                                                     TRUE, 1),

                                                                    (4, 'Семья Genovese: «Лига Плюща» преступного мира',
                                                                     'Семья Дженовезе заслужила репутацию самого дисциплинированного и скрытного синдиката. Вито Дженовезе и его преемники установили контроль над рыбным рынком Фултон, рэкетом в Гарлеме, а также финансовыми махинациями на Уолл-стрит.',
                                                                     TRUE, 2),

                                                                    (5, 'Семья Lucchese: Профсоюзы и аэропорты',
                                                                     'Семья Луккезе, ведомая Томми «Трехпалым» Луккезе, сделала ставку на абсолютный контроль легкой промышленности, рэкет швейных фабрик и логистику зарождающегося аэропорта Айдлуайлд (ныне JFK).',
                                                                     TRUE, 3),

                                                                    (6, 'Семья Bonanno: Сицилийские традиции и канадский след',
                                                                     'Джозеф «Джо Бананас» Бонанно создал клан, строго следующий сицилийским родовым традициям. Семья удерживает монополию на дистрибуцию продовольствия, пекарни, импорт оливкового масла и международные цепочки поставок.',
                                                                     TRUE, 4),

                                                                    (7, 'Семья Colombo: Нефть, азарт и Бруклин',
                                                                     'Изначально созданная Джо Профачи как империя по импорту продуктов, семья Коломбо быстро распространила влияние на подпольные игорные дома Южного Бруклина, ростовщичество и портовые склады.',
                                                                     TRUE, 5);

ALTER TABLE families ALTER COLUMN id RESTART WITH 6;
ALTER TABLE users ALTER COLUMN id RESTART WITH 18;
ALTER TABLE businesses ALTER COLUMN id RESTART WITH 6;
ALTER TABLE family_relations ALTER COLUMN id RESTART WITH 11;
ALTER TABLE articles ALTER COLUMN id RESTART WITH 8;