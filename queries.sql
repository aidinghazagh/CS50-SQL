-- A user loging in (there would be hash checking instead of just checking for password)
SET @email = `test@example.com`;
SET @password = 123;
SELECT * FROM `users` WHERE `email` = LOWER(@email) AND `password` = @password;

-- Viewing a users posted slangs by their email
SET @email = `test@example.com`;
SELECT * FROM `slangs` WHERE `user_id` = (
    SELECT `id` FROM `id` WHERE `email` = LOWER(@email)
);

-- Viewing a users posted slangs by their name
SET @name = `Aidin Ghazagh`;
SELECT * FROM `slangs` WHERE `user_id` IN (
    SELECT `id` FROM `id` WHERE LOWER(`name`) = LOWER(@name)
);

-- See all available countries
SELECT `name` FROM `countries`;

-- See all available languages
SELECT `name` FROM `languages`;

-- See languages from a country
SET @country_name = `Iran`;
SELECT * FROM `languages` WHERE `country_id` = (
    SELECT `id` FROM `countries` WHERE LOWER(`name`) = LOWER(@country_name)
);

-- See all created categories
SELECT * FROM `categories`;

-- Search slangs by language affected by scores
SET @lang_name = `english`;
SELECT * FROM `slangs` WHERE `language_id` = (
    SELECT `id` FROM `languages` WHERE LOWER(`name`) = LOWER(@lang_name)
)ORDER BY `score`;

-- Search slangs by category affected by scores the names are all unique
SET @category_name = `street`;
SELECT * FROM `slangs` JOIN `slang_category_ids` ON `slangs`.`id` = `slang_category_ids`.`slang_id` WHERE `category_id` = (
    SELECT `id` FROM `categories` WHERE LOWER(`name`) = LOWER(@category_name)
) ORDER BY `score`;


--Performing a user account delete
SET @email = `test@example.com`;
DELETE FROM `slangs` WHERE `user_id` IN (
    SELECT `id` FROM `users` WHERE LOWER(`email`) = LOWER(@email)
);
DELETE FROM `users` WHERE LOWER(`email`) = LOWER(@email)

--Upvoting a slang post
SET @slang_id = 1;
BEGIN TRANSACTION;
UPDATE `slangs` SET `score` = `score` + 1 WHERE `id` = @slang_id;
UPDATE `users` SET `behavior` = `score` + 1 WHERE `id` = (
    SELECT `user_id` FROM `slangs` WHERE `id` = @slang_id
);
COMMIT;
--Downvoting a slang post
SET @slang_id = 1;
BEGIN TRANSACTION;
UPDATE `slangs` SET `score` = `score` - 1 WHERE `id` = @slang_id;
UPDATE `users` SET `behavior` = `score` - 1 WHERE `id` = (
    SELECT `user_id` FROM `slangs` WHERE `id` = @slang_id
);
COMMIT;
