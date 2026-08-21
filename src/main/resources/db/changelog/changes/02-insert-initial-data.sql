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
(2, 'joseph_biondo', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'COUNSELOR', 1, 'https://images.example.com/biondo.jpg', 'Правая рука Карло Гамбино, советник по финансовым вопросам.'),
(3, 'aniello_dellacroce', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CAPO', 1, 'https://images.example.com/dellacroce.jpg', 'Влиятельный капо, контролирующий порты Манхэттена.'),
(4, 'paul_castellano', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'SOLDIER', 1, 'https://images.example.com/castellano.jpg', 'Преданный солдат семьи, занимается белыми воротничками.');

-- Семья Genovese
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
(5, 'vito_genovese', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'BOSS', 2, 'https://images.example.com/genovese.jpg', 'Босс семьи Дженовезе. Жестокий и амбициозный лидер.'),
(6, 'michele_miranda', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'COUNSELOR', 2, 'https://images.example.com/miranda.jpg', 'Опытный консильери семьи Дженовезе.'),
(7, 'anthony_salerno', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CAPO', 2, 'https://images.example.com/salerno.jpg', 'Капо по кличке "Толстый Тони", держит рэкет в Гарлеме.'),
(8, 'vincent_gigante', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'SOLDIER', 2, 'https://images.example.com/gigante.jpg', 'Боец семьи, силовой исполнитель специальных поручений.');

-- Семья Lucchese
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
(9, 'tommy_lucchese', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'BOSS', 3, 'https://images.example.com/lucchese.jpg', 'Босс семьи Луккезе. Мастер закулисных альянсов.'),
(10, 'vincenzo_rao', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'COUNSELOR', 3, 'https://images.example.com/rao.jpg', 'Консильери семьи Луккезе, юрист и медиатор.'),
(11, 'anthony_corallo', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CAPO', 3, 'https://images.example.com/corallo.jpg', 'Капо по кличке "Утка", держит профсоюзы грузоперевозок.');

-- Семья Bonanno
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
(12, 'joseph_bonanno', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'BOSS', 4, 'https://images.example.com/bonanno.jpg', 'Босс семьи Бонанно по кличке "Джо Бананас".'),
(13, 'john_tartamella', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'COUNSELOR', 4, 'https://images.example.com/tartamella.jpg', 'Старый консильери семьи Бонанно.'),
(14, 'carmine_galante', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'CAPO', 4, 'https://images.example.com/galante.jpg', 'Агрессивный капо, контролирующий импорт и распределение.');

-- Семья Colombo
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio) VALUES
(15, 'joe_profaci', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'BOSS', 5, 'https://images.example.com/profaci.jpg', 'Основатель семьи Профачи (позже Коломбо). Оливковый король.'),
(16, 'joseph_magliocco', '$2a$12$k16E8hqINj/u.sB4MPKH3uXqBM1Zr3uBepxXP/bXwiqJ4lT56AiIK', 'COUNSELOR', 5, 'https://images.example.com/magliocco.jpg', 'Консильери семьи Коломбо/Профачи.'),
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
INSERT INTO family_relations (id, family_1_id, family_2_id, status) VALUES
(1, 1, 2, 'PEACE'),
(2, 1, 3, 'PEACE'),
(3, 1, 4, 'WAR'),
(4, 1, 5, 'PEACE'),
(5, 2, 3, 'PEACE'),
(6, 2, 4, 'PENDING_PEACE'),
(7, 2, 5, 'PEACE'),
(8, 3, 4, 'PEACE'),
(9, 3, 5, 'PEACE'),
(10, 4, 5, 'PEACE');

-- =================================================================
-- 5. ИСТОРИЧЕСКИЕ СТАТЬИ
-- =================================================================
INSERT INTO articles (id, title, content, is_public, family_id) VALUES
(1, 'Образование Комиссии 1931 года', 'В 1931 году Чарльз "Лаки" Лучано сформировал Комиссию — управляющий орган американской Мафии, заменивший должность "Босса всех боссов" на коллегиальный совет лидеров Пяти Семей Нью-Йорка.', TRUE, NULL),
(2, 'Пять Семей Нью-Йорка', 'Коза Ностра в Нью-Йорке разделена на пять главных семей: Гамбино, Дженовезе, Луккезе, Бонанно и Коломбо. Каждая семья имеет четкую иерархию: Босс, Консильери, Подбосс, Капо и Солдаты.', TRUE, NULL),
(3, 'История семьи Gambino', 'Семья Гамбино — одна из самых мощных организаций. Основана на контроле портов, текстильной промышленности и строительного сектора Нью-Йорка.', FALSE, 1),
(4, 'Хроника семьи Genovese', 'Семья Дженовезе известна как "Айви Лига" мафии за свою скрытность и высочайший уровень дисциплины. Контролирует Уолл-Стрит и Набережную.', FALSE, 2);


ALTER TABLE families ALTER COLUMN id RESTART WITH 6;
ALTER TABLE users ALTER COLUMN id RESTART WITH 18;
ALTER TABLE businesses ALTER COLUMN id RESTART WITH 6;
ALTER TABLE family_relations ALTER COLUMN id RESTART WITH 11;
ALTER TABLE articles ALTER COLUMN id RESTART WITH 5;