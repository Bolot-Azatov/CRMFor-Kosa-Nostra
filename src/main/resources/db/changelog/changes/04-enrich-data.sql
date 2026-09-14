--liquibase formatted sql

--changeset dev:04-enrich-data

-- =================================================================
-- 1. ДОПОЛНИТЕЛЬНЫЙ ЛИЧНЫЙ СОСТАВ СЕМЕЙ (ID: 18 - 32)
-- Все пароли: qwerty ($2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS)
-- =================================================================

-- --- СЕМЬЯ GAMBINO (Family ID: 1) ---
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio, bio_en) VALUES
                                                                                             (18, 'james_failla', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CAPO', 1,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuDz3knL61xpxDecah9PoB8CckxSE1PcNSJt3NfErS9g&s=10',
                                                                                              'Капо по кличке "Джимми Браун". Бессменный куратор синдиката по вывозу мусора и утилизации отходов в Большом Нью-Йорке.',
                                                                                              'Capo nicknamed "Jimmy Brown". Longtime overseer of the commercial waste and garbage hauling cartels across Greater New York.'),

                                                                                             (19, 'roy_demeo', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 1,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfGA9KYjEqJjvDEub2MZYNEh3EAOLcjgzOnkvlZ8I4kA&s=10',
                                                                                              'Хладнокровный солдат семьи и главарь печально известной бригады мясников с Флэтбуш-авеню. Эксперт по угонам автомобилей.',
                                                                                              'Cold-blooded soldier and leader of the notorious Flatbush butcher crew. Specialist in stolen luxury car syndicates and contract hits.'),

                                                                                             (20, 'ettore_zappi', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 1,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8EA9_c_QmuPC78fqzWCVSbyjZtHPEZI2OdfVQMas8YQ&s=10',
                                                                                              'Ветеран сицилийской старой гвардии, доверенное лицо Карло Гамбино по контролю за грузоперевозками и складами в Бруклине.',
                                                                                              'Old-school Sicilian veteran, trusted courier of Carlo Gambino coordinating freight trucking unions and waterfront warehouses in Brooklyn.');

-- --- СЕМЬЯ GENOVESE (Family ID: 2) ---
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio, bio_en) VALUES
                                                                                             (21, 'matthew_ianniello', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CAPO', 2,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlQSIWxGwfd-qHunElC55h6T-Cqe74gP0i28jxsFcxgw&s=10',
                                                                                              'Капо по кличке "Мэтти Лошадь". Контролирует барно-ресторанную индустрию, ночные клубы и индустрию развлечений Таймс-Сквер.',
                                                                                              'Capo nicknamed "Matty the Horse". Undisputed kingpin of Times Square hospitality, topless bars, and Midtown entertainment venues.'),

                                                                                             (22, 'frank_tieri', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 2,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxWkmdcfK46XpaGwWkM3xBphk74YiPHJoYcBEQqSXFbg&s=10',
                                                                                              'Солдат по кличке "Фунзи". Эксперт по хитроумному ростовщичеству и координатор бригад в Бронксе и округе Вестчестер.',
                                                                                              'Soldier nicknamed "Funzi". Cunning loan-sharking strategist coordinating Bronx extortion rings and Westchester bookmaking.'),

                                                                                             (23, 'venero_mangano', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 2,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_4tze0hvijk7KvoYGjCryjeTlRPYPCDtSXUkSKiTJsw&s=10',
                                                                                              'Боец "Бенни Яйца". Руководит операциями на рыбном рынке Фултон и координирует силовое давление на оконный картель.',
                                                                                              'Soldier "Benny Eggs". Ground operative at Fulton Fish Market and chief enforcer across Manhattan replacement window rackets.');

-- --- СЕМЬЯ LUCCHESE (Family ID: 3) ---
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio, bio_en) VALUES
                                                                                             (24, 'paul_vario', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CAPO', 3,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgp-jrFfymkPlAq_icOcyzlNOVE8lnRrrAKvy1b1BPvA&s=10',
                                                                                              'Грозный капо из Бруклина. Полновластный хозяин логистических терминалов и грузовых авиалиний аэропорта Айдлуайлд (JFK).',
                                                                                              'Formidable Brooklyn Capo. Undisputed overlord of air cargo hijackings and logistics unions surrounding Idlewild (JFK) Airport.'),

                                                                                             (25, 'salvatore_santoro', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 3,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa8_nxFzAt471gtmb_aZAbQ07pNVFFZcPNFSOF6_trsA&s=10',
                                                                                              'Солдат по прозвищу "Том Микс". Контролирует подпольные тотализаторы в Гарлеме и профсоюзы водителей грузовиков.',
                                                                                              'Soldier known as "Tom Mix". Mastermind of East Harlem numbers banks and Teamsters union influence peddling.'),

                                                                                             (26, 'christopher_furnari', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 3,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_6W2Ahr6Ekx9YtdcBUO9hgKjyv71WJhR7C6VhiIXSsw&s=10',
                                                                                              'Боец по кличке "Кристи Тик". Хозяин нелегального игорного клуба в Астории, специалист по разрешению спорных конфликтов.',
                                                                                              'Soldier nicknamed "Christie Tick". Operator of premier illegal card rooms in Astoria and skilled syndicate mediator.');

-- --- СЕМЬЯ BONANNO (Family ID: 4) ---
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio, bio_en) VALUES
                                                                                             (27, 'philip_rastelli', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CAPO', 4,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5pI_4wCcmM4zrejpaxz7_VB8754iSgabnNp9X7soOxA&s',
                                                                                              'Капо по прозвищу "Расти". Владелец сети коммерческих пекарен и оператор кассовых аппаратов в Квинсе и Гринпойнте.',
                                                                                              'Capo known as "Rusty". Ruler of Queens lunch wagon concessions, bakery syndicates, and Greenpoint loan operations.'),

                                                                                             (28, 'alphonse_indelicato', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 4,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzXLmwByBahFjrgSwFlWj-eowclcwQmskj5UxuEqMUVg&s',
                                                                                              'Солдат по прозвищу "Сонни Ред". Выдающийся стрелок и жесткий лидер бригады из Нижнего Манхэттена.',
                                                                                              'Soldier known as "Sonny Red". Fierce street commander and enforcer heading Lower East Side distribution cells.'),

                                                                                             (29, 'cesare_bonventre', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 4,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtW3tQ5eia6tTS1bimk4pCcz8WwnpRcB78iEmi4NfQ4Q&s=10',
                                                                                              'Молодой сицилийский солдат из клана "зипов". Предан традициям Кастелламмаре, обеспечивает безопасность штаба Бонанно.',
                                                                                              'Young Sicilian soldier from the "Zips" faction. Fiercely loyal to Castellammare traditions, bodyguard for senior leadership.');

-- --- СЕМЬЯ COLOMBO (Family ID: 5) ---
INSERT INTO users (id, username, password_hash, role, family_id, photo_url, bio, bio_en) VALUES
                                                                                             (30, 'joe_gallo', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'CAPO', 5,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQggHskBCEp5v002PtZbsRXnLm0KtdLCfiBd3P1omLKMg&s=10',
                                                                                              'Капо по кличке "Бешеный Джо". Импульсивный бунтарь из Ред-Хук, держащий в страхе ростовщиков и автоматы с музыкальными боксами.',
                                                                                              'Capo nicknamed "Crazy Joe". Charismatic renegade based in Red Hook, running jukebox distribution and loan-sharking cells.'),

                                                                                             (31, 'john_franzese', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 5,
                                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5W1RdJslwCl1DXDPnQI8mYMb13_fYj0vLr3JD6ciNrw&s=10',
                                                                                              'Легендарный солдат "Сонни" Франзезе. Несокрушимый сборщик дани и теневой инвестор звукозаписывающих студий.',
                                                                                              'Legendary soldier "Sonny" Franzese. Iron-willed tribute collector, nightlife financier, and Long Island loanshark.'),

                                                                                             (32, 'nicholas_bianco', '$2a$12$on/8hD.t/h6GPu5Gdt.khunNPmf3C.5H6FCBjOYTAA8g.MDJ.1MVS', 'SOLDIER', 5,
                                                                                              'https://www.courant.com/wp-content/uploads/migration/2021/02/26/ZJRBVOLGYBGPZEDLQBTLZ22T3I.jpg?w=620',
                                                                                              'Дисциплинированный солдат бруклинской команды, доверенное лицо Профачи в операциях с оптовой торговлей оливковым маслом.',
                                                                                              'Disciplined Brooklyn crew soldier, trusted lieutenant handling olive oil import logistics and wholesale food distribution.');

-- =================================================================
-- 2. НОВЫЕ БИЗНЕСЫ И РЭКЕТЫ (ID: 6 - 17)
-- Включает как привязанные к новым Капо, так и свободные (capo_id = NULL)
-- =================================================================

-- GAMBINO (Family 1)
INSERT INTO businesses (id, name, type, type_ru, weekly_revenue, capo_id, family_id) VALUES
                                                                                         (6, 'Empire Waste Hauling Cartel', 'Waste Management', 'Вывоз мусора и утилизация', 55000.00, 18, 1),
                                                                                         (7, 'Midtown Construction Concrete', 'Construction Cartel', 'Строительный бетонный картель', 65000.00, NULL, 1);

-- GENOVESE (Family 2)
INSERT INTO businesses (id, name, type, type_ru, weekly_revenue, capo_id, family_id) VALUES
                                                                                         (8, 'Broadway Copacabana Lounge', 'Nightclubs & Entertainment', 'Ночные клубы и кабаре', 48000.00, 21, 2),
                                                                                         (9, 'Little Italy Espresso & Pastry', 'Hospitality & Protection', 'Рестораны и рэкет защиты', 22000.00, NULL, 2);

-- LUCCHESE (Family 3)
INSERT INTO businesses (id, name, type, type_ru, weekly_revenue, capo_id, family_id) VALUES
                                                                                         (10, 'Idlewild Air Cargo Terminal #4', 'Air Freight & Hijacking', 'Грузовой авиатерминал и логистика', 52000.00, 24, 3),
                                                                                         (11, 'Queens Plasterers Union Local', 'Labor Racketeering', 'Профсоюз строителей-штукатуров', 31000.00, NULL, 3);

-- BONANNO (Family 4)
INSERT INTO businesses (id, name, type, type_ru, weekly_revenue, capo_id, family_id) VALUES
                                                                                         (12, 'Castellammare Wholesale Bakery', 'Commercial Baking', 'Промышленная выпечка и хлеб', 29000.00, 27, 4),
                                                                                         (13, 'Montreal Express Import Line', 'Border Smuggling', 'Трансграничная контрабанда', 42000.00, NULL, 4);

-- COLOMBO (Family 5)
INSERT INTO businesses (id, name, type, type_ru, weekly_revenue, capo_id, family_id) VALUES
                                                                                         (14, 'Red Hook Jukebox & Coin Machines', 'Vending Machines', 'Игровые и музыкальные автоматы', 34000.00, 30, 5),
                                                                                         (15, 'Crown Heights Loan Office', 'Loan Sharking', 'Ростовщическая контора', 38000.00, NULL, 5);

-- ДОПОЛНИТЕЛЬНЫЕ НЕЗАКРЕПЛЕННЫЕ ТОЧКИ ДЛЯ БОССОВ
INSERT INTO businesses (id, name, type, type_ru, weekly_revenue, capo_id, family_id) VALUES
                                                                                         (16, 'Manhattan Garment Transport Union', 'Logistics & Trucking', 'Транспортная гильдия Garment', 41000.00, NULL, 1),
                                                                                         (17, 'Harlem Policy & Numbers Bank', 'Illegal Lotteries', 'Подпольная лотерея Гарлема', 37000.00, NULL, 2);

-- =================================================================
-- 3. АРХИВНЫЕ И АНАЛИТИЧЕСКИЕ СТАТЬИ (ID: 8 - 14)
-- =================================================================

-- Статья 8: Публичная / Общая
INSERT INTO articles (id, title, title_en, content, content_en, is_public, family_id) VALUES
    (8,
     'Апалачинский конклав 1957 года: Провал на холмах',
     'The 1957 Apalachin Summit: Disaster on the Hillside',
     '14 ноября 1957 года на загородном поместье Джозефа Барбары в поселке Апалачин (штат Нью-Йорк) состоялась чрезвычайная встреча свыше сотни боссов Синдиката со всех штатов США. Повестка включала раздел наркотрафика, последствия ликвидации Альберта Анастазии и признание новых лидеров кланов. Местный дорожный патруль заметил скопление роскошных кадиллаков и блокировал усадьбу. Десятки донов в дорогих пальто бежали через кукурузные поля и лес. Этот рейд навсегда разрушил утверждения ФБР о том, что "организованной преступности в США не существует".',
     'On November 14, 1957, at the rural estate of Joseph Barbara in Apalachin, New York, an emergency summit was convened with over one hundred syndicate leaders nationwide. The agenda centered on narcotics distribution, the fallout of Albert Anastasia''s assassination, and formal recognition of new family bosses. State troopers grew suspicious of the motorcade of luxury sedans and surrounded the compound. Dozens of dons in tailored overcoats fled through muddy woods and cornfields. The raid dealt a devastating blow to J. Edgar Hoover''s longstanding claim that a national mafia did not exist.',
     TRUE, NULL);

-- Статья 9: Публичная / Общая
INSERT INTO articles (id, title, title_en, content, content_en, is_public, family_id) VALUES
    (9,
     'Французский связной: Марсельский транзит и опийные караваны',
     'The French Connection: The Marseilles-New York Pipeline',
     'К началу 1950-х годов синдикат выстроил самую изощренную систему импорта белого порошка в мире. Опий-сырец закупался на плантациях Турции и Ближнего Востока, переправлялся в подпольные лаборатории Марселя, а оттуда морскими судами доставлялся в порт Нью-Йорка. Ключевую роль в логистике играли сицилийские "зипы" и сговорчивые докеры клана Гамбино и Бонанно. Несмотря на формальный запрет Комиссии на торговлю зельем под страхом смертной казни, сверхприбыли в 1000% превратили этот маршрут в главную тайную статью доходов синдиката.',
     'By the early 1950s, the Syndicate established the most sophisticated contraband pipeline on the globe. Raw opium cultivated in Turkey and the Levant moved to clandestine chemical laboratories in Marseilles, France, before being smuggled into New York Harbor inside industrial freight. Trusted Sicilian envoys coordinated arrivals with sympathetic dock foremen from the Gambino and Bonanno families. Though the Commission officially imposed a death penalty on drug dealing to prevent federal scrutiny, profit margins exceeding 1000% proved utterly irresistible.',
     TRUE, NULL);

-- Статья 10: Публичная / Общая
INSERT INTO articles (id, title, title_en, content, content_en, is_public, family_id) VALUES
    (10,
     'Анатомия бетонного клуба: Монополия на фундаменты Манхэттена',
     'Anatomy of the Concrete Club: Manhattan High-Rise Monopoly',
     'Ни один небоскреб на Манхэттене не может подняться выше первого этажа без одобрения "Бетонного клуба". Картель состоит из глав ключевых семей, контролирующих поставки жидкого бетона на стройки стоимостью свыше 2 миллионов долларов. Через подставные компании и профсоюзные комитеты синдикат налагает 2%-ный негласный сбор на каждый кубометр заливки. Фирмы, отказывающиеся платить, сталкиваются с забастовками крановщиков, порчей арматуры и немедленным срывом сроков сдачи объектов.',
     'Not a single skyscraper in Manhattan rises above ground level without clearance from the Syndicate''s "Concrete Club". This cartel comprises the heads of the Five Families governing all structural concrete bids exceeding $2 million. Through front companies and compromised union delegates, a mandatory 2% surcharge is levied on every cubic yard poured. Independent developers resisting the tribute face wildcat strikes by crane operators, slashed hydraulic lines, and indefinite regulatory site shutdowns.',
     TRUE, NULL);

-- Статья 11: Закрытый архив Gambino (Family 1)
INSERT INTO articles (id, title, title_en, content, content_en, is_public, family_id) VALUES
    (11,
     'Дело #10-G: Теневой контроль вывоза мусора и Ассоциация перевозчиков',
     'File #10-G: Commercial Waste Cartels and Trade Waste Association',
     'Внутренний меморандум Дона. Семья Гамбино удерживает абсолютный картель над вывозом коммерческого мусора в Бруклине, Квинсе и на Лонг-Айленде через команду Джимми Брауна (Файлла). Город поделен на монопольные маршруты: если частный владелец ресторана или фабрики попытается сменить компанию по вывозу отходов, ни один другой перевозчик не примет заказ под угрозой сожжения мусоровозов. Доходность схемы превышает классический рэкет и гарантирует семье стабильный белый доход.',
     'Executive Syndicate Memo. The Gambino clan exercises total monopolistic dominion over commercial carting across Brooklyn, Queens, and Long Island under Jimmy Brown Failla. Municipal districts are carved into inviolable zones: should an enterprise attempt to hire competing disposal services, alternative trucks are torched on sight. The enterprise generates clean, recurring cash flows outperforming conventional extortion.',
     FALSE, 1);

-- Статья 12: Закрытый архив Genovese (Family 2)
INSERT INTO articles (id, title, title_en, content, content_en, is_public, family_id) VALUES
    (12,
     'Дело #12-GEN: Ночная жизнь Бродвея и теневые кассы Таймс-Сквер',
     'File #12-GEN: Broadway Nightlife and the Times Square Shadow Ledger',
     'Секретный отчет Консильери Миранды. Бригада Мэтти Ианньелло полностью подчинила себе индустрию ночных клубов, баров и кабаре в районе 42-й улицы. Доходы формируются из трех источников: продажа неучтенного алкоголя в обход акцизных сборов, контроль гардеробов и музыкальных аппаратов, а также отчисления от частных ростовщических ссуд владельцам заведений. Вся наличность еженедельно аккумулируется в ставке Дона Дженовезе.',
     'Confidential Report for Consigliere Miranda. Matthew Ianniello''s crew maintains an iron grasp over Midtown nightspots, jazz rooms, and cabaret halls along 42nd Street. Revenues derive from untaxed liquor distribution, vending concessions, and high-interest loans fronted to club proprietors. Cash is bundled weekly and routed directly to Don Genovese''s war room.',
     FALSE, 2);

-- Статья 13: Закрытый архив Lucchese (Family 3)
INSERT INTO articles (id, title, title_en, content, content_en, is_public, family_id) VALUES
    (13,
     'Дело #14-LUC: Логистический узел Айдлуайлд и воздушные грабежи',
     'File #14-LUC: Idlewild Air Cargo Operations and Ramp Logistics',
     'Донесение Тому Луккезе по операциям в Квинсе. Международный аэропорт Айдлуайлд стал главным источником наличности и дефицитных импортных товаров для семьи. Капо Пол Варио внедрил доверенных диспетчеров и грузчиков в компании Air France, Lufthansa и Pan Am. Отслеживаются партии швейцарских часов, валюты и французской парфюмерии, после чего фургоны бесследно исчезают прямо со взлетно-посадочных полос под прикрытием купленной службы безопасности.',
     'Dispatch to Tommy Lucchese on Queens logistics. Idlewild International Airport has emerged as the family''s primary treasury driver. Capo Paul Vario embedded syndicate expediters inside Air France, Lufthansa, and Pan Am freight terminals. Consignments of uncut diamonds, Swiss watches, and untraceable banknotes are systematically diverted with total complicity from airport security.',
     FALSE, 3);

-- Статья 14: Закрытый архив Bonanno (Family 4)
INSERT INTO articles (id, title, title_en, content, content_en, is_public, family_id) VALUES
    (14,
     'Дело #15-BON: Сицилийская кровь и канадский коридор Монреаля',
     'File #15-BON: The Montreal Corridor and Old-World Traditions',
     'Стратегический протокол клана Бонанно. В отличие от других семей, разбавленных американизированными кадрами, Джо Бонанно опирается исключительно на прямых выходцев из Кастелламмаре-дель-Гольфо. Установлен негласный союз с монреальской ячейкой Вито Риццуто. Канадская ветвь обеспечивает чистые финансовые проводки через офшорные европейские банки и хранение стратегического запаса оружия синдиката на случай общегородской войны.',
     'Strategic Protocol of the Bonanno family. Unlike neighboring syndicates diluting bloodlines with Americanized recruits, Joe Bonanno maintains strict adherence to Castellammarese lineage. A formal alliance binds the clan with the Montreal branch under Vito Rizzuto, supplying clean ledger clearance through Swiss accounts and armory staging grounds in the event of syndicate-wide hostilities.',
     FALSE, 4);

-- =================================================================
-- 4. ОБНОВЛЕНИЕ СЧЕТЧИКОВ АВТОИНКРЕМЕНТА H2 ДЛЯ ДАЛЬНЕЙШИХ ВСТАВОК
-- =================================================================
ALTER TABLE users ALTER COLUMN id RESTART WITH 33;
ALTER TABLE businesses ALTER COLUMN id RESTART WITH 18;
ALTER TABLE articles ALTER COLUMN id RESTART WITH 15;