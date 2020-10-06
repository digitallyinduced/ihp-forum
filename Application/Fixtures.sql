

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.admins DISABLE TRIGGER ALL;



ALTER TABLE public.admins ENABLE TRIGGER ALL;


ALTER TABLE public.topics DISABLE TRIGGER ALL;

INSERT INTO public.topics (id, name, description, threads_count, last_activity_at) VALUES ('9de25c37-17ab-42c6-8cf2-b75c3869c4e2', 'Haskell Questions', 'General Haskell Questions', 0, '2020-08-15 12:02:56.332506+01');
INSERT INTO public.topics (id, name, description, threads_count, last_activity_at) VALUES ('b048709a-51f4-444b-a935-a3f9602de7b2', 'Database', 'Everything related to dealing with the database', 0, '2020-08-15 12:02:56.332714+01');
INSERT INTO public.topics (id, name, description, threads_count, last_activity_at) VALUES ('2ecba42e-225d-481c-9aef-63f77f3659ac', 'Nix', 'Dealing with Nix', 0, '2020-08-15 12:02:56.333124+01');
INSERT INTO public.topics (id, name, description, threads_count, last_activity_at) VALUES ('b3f690dd-6600-4460-8be7-be884e922aff', 'General', 'General questions regarding IHP', 0, '2020-09-22 16:33:05.006915+01');
INSERT INTO public.topics (id, name, description, threads_count, last_activity_at) VALUES ('accc3289-b706-4d68-9da8-c9e0d2c07dfe', 'IHP Roadmap', 'Discussing new features for IHP', 1, '2020-09-22 16:35:43.682455+01');


ALTER TABLE public.topics ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, name, email, github_name, password_hash, locked_at, failed_login_attempts) VALUES ('45563d80-6be3-4301-93b4-5b444e25805d', 'marc', 'marc@digitallyinduced.com', 'mpscholten', 'sha256|17|oq14JZR9h6ZT2uhpHp4Q+w==|F9HoYZA9n1qku0EFnJvUOt9+Pa6djHg5jsK56JJjgdI=', NULL, 0);
INSERT INTO public.users (id, name, email, github_name, password_hash, locked_at, failed_login_attempts) VALUES ('5ed92089-74f3-421f-abc0-423027d0449d', 'Marc', 'marc+2@digitallyinduced.com', 'mpscholten', '', NULL, 1);
INSERT INTO public.users (id, name, email, github_name, password_hash, locked_at, failed_login_attempts) VALUES ('e264e208-43af-4f92-a188-2d5726fdd3dd', 'Montmorency', 'lamberh@tcd.ie', 'Montmorency', 'sha256|17|vakQfL4IgAl+550Mq9CLmg==|7rjE2/oxkDfoCG1GAo4bt77LtMt7wcae5p46demP/jY=', NULL, 0);


ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.threads DISABLE TRIGGER ALL;

INSERT INTO public.threads (id, title, body, created_at, user_id, topic_id) VALUES ('1df1fb5a-b592-4716-9c68-b82527623a3b', 'generated fromField instance wrong for Enum containing some characters', 'I have an enum with one possible value being "Tillgänglig"
The generated code for instanceFromField is
fromField field (Just "Tillg\228nglig") = pure Tillgänglig
However entering it in a form and submitting it is stored as
"Tillg\195\164nglig"

If I change the fromField instance to that it works as expected. However changing the InputValue instance to that instead displays "TillgÃ¤nglig".

It appears there is some inconsistent encoding.', '2020-08-15 09:20:08.802497+01', '5ed92089-74f3-421f-abc0-423027d0449d', 'b3f690dd-6600-4460-8be7-be884e922aff');
INSERT INTO public.threads (id, title, body, created_at, user_id, topic_id) VALUES ('fe8e4512-5ea8-4dc5-b98f-8837568daddc', 'Show hint for using single ticks in SQL TEXT default value', 'When you are creating a TEXT field inside of the schema builder and want to assign a default value to it you need to frame it in single ticks for it to work. This is normal SQL Syntax but it would be better to have a hint displayed there.', '2020-08-15 09:22:04.095079+01', '5ed92089-74f3-421f-abc0-423027d0449d', 'b3f690dd-6600-4460-8be7-be884e922aff');
INSERT INTO public.threads (id, title, body, created_at, user_id, topic_id) VALUES ('ff4d038f-b6ae-4eb2-ac9c-412980070f40', 'test', 'test', '2020-08-15 12:05:29.092513+01', '45563d80-6be3-4301-93b4-5b444e25805d', 'b3f690dd-6600-4460-8be7-be884e922aff');
INSERT INTO public.threads (id, title, body, created_at, user_id, topic_id) VALUES ('dfd71387-7982-48ec-a4f3-0fa3d4ef9a82', 'The Badges', 'I wonder if the badges works yet?', '2020-09-22 16:35:43.681846+01', 'e264e208-43af-4f92-a188-2d5726fdd3dd', 'accc3289-b706-4d68-9da8-c9e0d2c07dfe');


ALTER TABLE public.threads ENABLE TRIGGER ALL;


ALTER TABLE public.comments DISABLE TRIGGER ALL;

INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('8afb4d0f-da24-4b68-8cdb-3381e57956b1', '1df1fb5a-b592-4716-9c68-b82527623a3b', '5ed92089-74f3-421f-abc0-423027d0449d', 'test', '2020-08-15 10:10:46.008091+01');
INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('ee45309a-23f3-427f-b598-71c4baf37f01', '1df1fb5a-b592-4716-9c68-b82527623a3b', '5ed92089-74f3-421f-abc0-423027d0449d', 'test', '2020-08-15 10:11:22.618672+01');
INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('4481798b-8f13-4a25-bc8c-5a1486545806', '1df1fb5a-b592-4716-9c68-b82527623a3b', '5ed92089-74f3-421f-abc0-423027d0449d', 'test', '2020-08-15 10:17:33.544905+01');
INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('c769ea2d-1bc8-4443-95a4-2e2ad8c86e78', '1df1fb5a-b592-4716-9c68-b82527623a3b', '45563d80-6be3-4301-93b4-5b444e25805d', 'asd', '2020-08-15 11:22:12.205081+01');
INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('20f9eaa8-090b-4eb7-a38f-425cb41bfd5c', '1df1fb5a-b592-4716-9c68-b82527623a3b', '45563d80-6be3-4301-93b4-5b444e25805d', 'asd', '2020-08-15 11:22:56.576882+01');
INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('eff2cad7-a1bd-4a8c-8723-225103a5e3e3', '1df1fb5a-b592-4716-9c68-b82527623a3b', 'e264e208-43af-4f92-a188-2d5726fdd3dd', 'We don''t need no stinking badges!', '2020-09-22 16:33:05.003508+01');


ALTER TABLE public.comments ENABLE TRIGGER ALL;


ALTER TABLE public.user_badges DISABLE TRIGGER ALL;

INSERT INTO public.user_badges (id, user_id, badge) VALUES ('eb72f9ee-21e7-4f10-af6e-c0f757676774', 'e264e208-43af-4f92-a188-2d5726fdd3dd', 'ihp_sticker_owner');
INSERT INTO public.user_badges (id, user_id, badge) VALUES ('d1bc00d7-32d6-4d45-81a4-6125cf3c0cb8', '5ed92089-74f3-421f-abc0-423027d0449d', 'di_team');
INSERT INTO public.user_badges (id, user_id, badge) VALUES ('e40f7ade-8615-4ce4-aaa0-f144e9451a9a', '5ed92089-74f3-421f-abc0-423027d0449d', 'ihp_sticker_owner');


ALTER TABLE public.user_badges ENABLE TRIGGER ALL;


