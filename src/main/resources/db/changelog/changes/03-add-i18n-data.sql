--liquibase formatted sql

--changeset dev:03-add-i18n-columns-and-data

-- 1. Добавляем колонки для английских переводов статей
ALTER TABLE articles ADD COLUMN title_en VARCHAR(255);
ALTER TABLE articles ADD COLUMN content_en TEXT;

-- 2. Добавляем колонку для английской биографии участников
ALTER TABLE users ADD COLUMN bio_en TEXT;

-- 3. Добавляем колонку для русского типа бизнеса
ALTER TABLE businesses ADD COLUMN type_ru VARCHAR(100);

-- =================================================================
-- НАПОЛНЕНИЕ ДАННЫМИ: АНГЛИЙСКИЙ ПЕРЕВОД СТАТЕЙ СИНДИКАТА
-- =================================================================
UPDATE articles SET
                    title_en = 'Establishment of the 1931 Commission',
                    content_en = 'In 1931, following the Castellammarese War, Charles "Lucky" Luciano formed the Commission — the governing body of the American Cosa Nostra. The title of Capo di tutti i capi was permanently abolished, and New York was equally divided among the Five Families on equal footing.'
WHERE id = 1;

UPDATE articles SET
                    title_en = 'The Code of Omertà and Syndicate Governance',
                    content_en = 'Power within the families is built upon absolute subordination: the Don makes supreme strategic directives, the Consigliere acts as counselor and keeper of books, Caporegimes manage designated territories and rackets remitting 80% of earnings to the treasury, while Soldiers provide armed security.'
WHERE id = 2;

UPDATE articles SET
                    title_en = 'Gambino Family: Lords of the Docks and Brooklyn',
                    content_en = 'The Gambino family is one of the most populous and affluent clans in New York. Under Carlo Gambino''s command, the syndicate secured absolute control over freight trucking unions, Brooklyn waterfront docks, the Garment District, and the Manhattan construction cartel.'
WHERE id = 3;

UPDATE articles SET
                    title_en = 'Genovese Family: The "Ivy League" of the Underworld',
                    content_en = 'The Genovese family earned the reputation as the most disciplined and secretive syndicate. Vito Genovese and his successors consolidated control over the Fulton Fish Market, Harlem loan-sharking, and Wall Street securities manipulation.'
WHERE id = 4;

UPDATE articles SET
                    title_en = 'Lucchese Family: Labor Unions and Idlewild Airport',
                    content_en = 'The Lucchese clan, steered by Tommy "Three-Finger Brown" Lucchese, centered its power on the total domination of the garment industry, trucking unions, and logistics around the emerging Idlewild Airport (now JFK).'
WHERE id = 5;

UPDATE articles SET
                    title_en = 'Bonanno Family: Sicilian Traditions and Canadian Lines',
                    content_en = 'Joseph "Joe Bananas" Bonanno cultivated a tightly-knit clan following strict Sicilian heritage. The family maintains monopolies on food distribution, bakeries, olive oil import channels, and international supply chains.'
WHERE id = 6;

UPDATE articles SET
                    title_en = 'Colombo Family: Olive Oil, Gambling, and Brooklyn',
                    content_en = 'Originally founded by Joe Profaci as a food import enterprise, the Colombo family rapidly expanded into underground casino dens in South Brooklyn, high-interest loan sharking, and waterfront warehouses.'
WHERE id = 7;

-- =================================================================
-- АНГЛИЙСКИЙ ПЕРЕВОД БИОГРАФИЙ КЛЮЧЕВЫХ УЧАСТНИКОВ
-- =================================================================
UPDATE users SET bio_en = 'Boss of the Gambino family. Shrewd and calculated strategist, architect of the Commission.' WHERE id = 1;
UPDATE users SET bio_en = 'Right hand to Carlo Gambino, financial advisor and overseer of Queens gaming operations.' WHERE id = 2;
UPDATE users SET bio_en = 'Influential and ruthless Capo nicknamed "Neil", controlling Manhattan waterfront docks.' WHERE id = 3;
UPDATE users SET bio_en = 'Business-minded soldier overseeing wholesale meat trade and construction labor unions.' WHERE id = 4;

UPDATE users SET bio_en = 'Boss of the Genovese family. Powerful, ruthless, and ambitious syndicate leader.' WHERE id = 5;
UPDATE users SET bio_en = 'Veteran Consigliere "Big Mike", one of New York''s most powerful shadow kingmakers.' WHERE id = 6;
UPDATE users SET bio_en = 'Capo known as "Fat Tony", controlling numbers rackets and extortion in East Harlem.' WHERE id = 7;
UPDATE users SET bio_en = 'Soldier nicknamed "The Chin", muscle and covert enforcer for special family tasks.' WHERE id = 8;

UPDATE users SET bio_en = 'Boss of the Lucchese family ("Three-Finger Brown"). Master of alliances and Garment District rackets.' WHERE id = 9;
UPDATE users SET bio_en = 'Consigliere of the Lucchese clan, financier of plastering and construction cartels.' WHERE id = 10;
UPDATE users SET bio_en = 'Capo nicknamed "Tony Ducks", master of evading subpoenas and controlling unions.' WHERE id = 11;

UPDATE users SET bio_en = 'Boss of the Bonanno family ("Joe Bananas"). Zealous guardian of old Sicilian traditions.' WHERE id = 12;
UPDATE users SET bio_en = 'Senior Consigliere, seasoned diplomat and labor negotiator in Brooklyn.' WHERE id = 13;
UPDATE users SET bio_en = 'Fierce Capo with a trademark cigar, controlling import networks and distribution.' WHERE id = 14;

UPDATE users SET bio_en = 'Founder of the Colombo family. Olive oil magnate and traditional feudal Don.' WHERE id = 15;
UPDATE users SET bio_en = 'Chief Consigliere nicknamed "Evil Eye", trusted right hand and brother-in-law to Profaci.' WHERE id = 16;
UPDATE users SET bio_en = 'Daring young Capo nicknamed "The Snake", leader of Harlem enforcement operations.' WHERE id = 17;

-- =================================================================
-- РУССКИЙ ПЕРЕВОД ОТРАСЛЕЙ БИЗНЕСА
-- =================================================================
UPDATE businesses SET type_ru = 'Портовые доки и грузоперевозки' WHERE id = 1;
UPDATE businesses SET type_ru = 'Оптовый рыбный рынок' WHERE id = 2;
UPDATE businesses SET type_ru = 'Швейное производство и профсоюзы' WHERE id = 3;
UPDATE businesses SET type_ru = 'Пекарни и импорт масла' WHERE id = 4;
UPDATE businesses SET type_ru = 'Подпольное игорное заведение' WHERE id = 5;