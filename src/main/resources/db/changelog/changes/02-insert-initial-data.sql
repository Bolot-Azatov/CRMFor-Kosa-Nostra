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
-- 2. УЧАСТНИКИ СЕМЕЙ (Пароль для всех: qwerty)
-- Hash: $2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS
-- =================================================================

-- 1. Семья Gambino
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
                                                                                     (1, 'carlo_gambino', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'BOSS', 1,
                                                                                      'https://upload.wikimedia.org/wikipedia/commons/6/62/Carlo_Gambino.jpg',
                                                                                      'Босс семьи Гамбино. Хитрый и рассудительный стратег, архитектор Комиссии.'),
                                                                                     (2, 'joseph_biondo', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CONSIGLIERE', 1,
                                                                                      'https://upload.wikimedia.org/wikipedia/commons/7/73/BiondoMugshot38.png',
                                                                                      'Правая рука Карло Гамбино, советник по финансовым вопросам и азартным играм в Квинсе.'),
                                                                                     (3, 'aniello_dellacroce', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CAPO', 1,
                                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToR5_RlQD4NXn5ChaV1oYYWtYyyNwNvKpYYFJ4x9S6XQ&s=10',
                                                                                      'Влиятельный и беспощадный капо по кличке "Нил", контролирующий порты Манхэттена.'),
                                                                                     (4, 'paul_castellano', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 1,
                                                                                      'https://upload.wikimedia.org/wikipedia/commons/f/f7/Castellanomug.jpg',
                                                                                      'Деловой боец семьи, курирует оптовую торговлю мясом и профсоюзы строителей.');

-- 2. Семья Genovese
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
                                                                                     (5, 'vito_genovese', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'BOSS', 2,
                                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGAEdzxoIXHP91ESBOXomuYTqqwG9BKGeyoULhxNFDsA&s=10',
                                                                                      'Босс семьи Дженовезе. Жестокий, властный и амбициозный лидер синдиката.'),
                                                                                     (6, 'michele_miranda', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CONSIGLIERE', 2,
                                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREsrggI44bYjUHGaIwTMgGghRsdX8mY3Hay7o3HfaieQ&s=10',
                                                                                      'Опытный консильери "Большой Майк", один из серых кардиналов Нью-Йорка.'),
                                                                                     (7, 'anthony_salerno', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CAPO', 2,
                                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO8jF0eo-mytMvRvfmXIPImkhQMJqTDAq0VuSXs_1OUQ&s=10',
                                                                                      'Капо по кличке "Толстый Тони", держит подпольные лотереи и рэкет в Восточном Гарлеме.'),
                                                                                     (8, 'vincent_gigante', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 2,
                                                                                      'https://upload.wikimedia.org/wikipedia/commons/0/09/Vincent_Gigante_%28mugshot%2C_1960%29.jpg',
                                                                                      'Боец по кличке "Подбородок", силовой исполнитель специальных поручений семьи.');

-- 3. Семья Lucchese
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
                                                                                     (9, 'tommy_lucchese', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'BOSS', 3,
                                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKNMSTgDkIsF3uNQeYBnRyQS4LqZn6FIpuSBJKi5C1vQ&s=10',
                                                                                      'Босс семьи Луккезе по кличке "Трехпалый Томми". Мастер закулисных союзов и рэкета Garment District.'),
                                                                                     (10, 'vincenzo_rao', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CONSIGLIERE', 3,
                                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqmq_ZTAOag1t21vzmLCaoft5L3lh3Q4kQTGMrh9Ob-w&s=10',
                                                                                      'Консильери семьи Луккезе, теневой финансист строительных и штукатурных корпораций.'),
                                                                                     (11, 'anthony_corallo', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CAPO', 3,
                                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwmLur7PWTJ3BURwyg8gSa0228gMRTrtcbwCZHh4DhQg&s=10',
                                                                                      'Капо по кличке "Тони Утка", виртуозно уклоняющийся от повесток и держащий профсоюзы.');

-- 4. Семья Bonanno
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
                                                                                     (12, 'joseph_bonanno', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'BOSS', 4,
                                                                                      'https://upload.wikimedia.org/wikipedia/commons/9/94/Joseph_Bonanno_%28cropped%29.jpg',
                                                                                      'Босс семьи Бонанно ("Джо Бананас"). Ревнитель древних сицилийских традиций.'),
                                                                                     (13, 'john_tartamella', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CONSIGLIERE', 4,
                                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYSeRbFna--VYRgu6xinP5abIN19q_pkl8GRykRSa9eQ&s=10',
                                                                                      'Старейший консильери семьи, мудрый советник и профсоюзный деятель Бруклина.'),
                                                                                     (14, 'carmine_galante', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CAPO', 4,
                                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNhVOwCD0Ujgdv1LkUcs7_vCUqxRc9tvB0UAhRSqksyw&s=10',
                                                                                      'Свирепый капо с неизменной сигарой, контролирующий импорт и сеть распределения.');

-- 5. Семья Colombo
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
                                                                                     (15, 'joe_profaci', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'BOSS', 5,
                                                                                      'https://upload.wikimedia.org/wikipedia/commons/9/9e/Joseph_Profaci_NYWTS.jpg',
                                                                                      'Основатель семьи Профачи/Коломбо. Монополист оливкового масла и традиционный феодал.'),
                                                                                     (16, 'joseph_magliocco', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CONSIGLIERE', 5,
                                                                                      'https://upload.wikimedia.org/wikipedia/commons/d/d5/Joe_Magliocco.jpg',
                                                                                      'Шеф-консильери по кличке "Дурной Глаз", правая рука и шурин Джо Профачи.'),
                                                                                     (17, 'carmine_persico', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CAPO', 5,
                                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBYTtzDAbe9x1XksOk-fdkFvB0qw_XQuhMsIbvYXZKAQ&s=10',
                                                                                      'Дерзкий и опасный молодой капо по кличке "Змея", лидер гарлемских операций.');
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