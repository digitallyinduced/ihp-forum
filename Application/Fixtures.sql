

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

ALTER TABLE public.topics DISABLE TRIGGER ALL;

INSERT INTO public.topics (id, name, description, threads_count, last_activity_at) VALUES ('b3f690dd-6600-4460-8be7-be884e922aff', 'General', 'General questions regarding IHP', 0, '2020-08-15 13:02:56.331976+02');
INSERT INTO public.topics (id, name, description, threads_count, last_activity_at) VALUES ('9de25c37-17ab-42c6-8cf2-b75c3869c4e2', 'Haskell Questions', 'General Haskell Questions', 0, '2020-08-15 13:02:56.332506+02');
INSERT INTO public.topics (id, name, description, threads_count, last_activity_at) VALUES ('b048709a-51f4-444b-a935-a3f9602de7b2', 'Database', 'Everything related to dealing with the database', 0, '2020-08-15 13:02:56.332714+02');
INSERT INTO public.topics (id, name, description, threads_count, last_activity_at) VALUES ('accc3289-b706-4d68-9da8-c9e0d2c07dfe', 'IHP Roadmap', 'Discussing new features for IHP', 0, '2020-08-15 13:02:56.332922+02');
INSERT INTO public.topics (id, name, description, threads_count, last_activity_at) VALUES ('2ecba42e-225d-481c-9aef-63f77f3659ac', 'Nix', 'Dealing with Nix', 0, '2020-08-15 13:02:56.333124+02');


ALTER TABLE public.topics ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, name, email, github_name, password_hash, locked_at, failed_login_attempts) VALUES ('45563d80-6be3-4301-93b4-5b444e25805d', 'marc', 'marc@digitallyinduced.com', 'mpscholten', 'sha256|17|oq14JZR9h6ZT2uhpHp4Q+w==|F9HoYZA9n1qku0EFnJvUOt9+Pa6djHg5jsK56JJjgdI=', NULL, 0);
INSERT INTO public.users (id, name, email, github_name, password_hash, locked_at, failed_login_attempts) VALUES ('5ed92089-74f3-421f-abc0-423027d0449d', 'Marc', 'marc+2@digitallyinduced.com', 'mpscholten', '', NULL, 1);


ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.threads DISABLE TRIGGER ALL;

INSERT INTO public.threads (id, title, body, created_at, user_id, topic_id) VALUES ('1df1fb5a-b592-4716-9c68-b82527623a3b', 'generated fromField instance wrong for Enum containing some characters', 'I have an enum with one possible value being "Tillgänglig"
The generated code for instanceFromField is
fromField field (Just "Tillg\228nglig") = pure Tillgänglig
However entering it in a form and submitting it is stored as
"Tillg\195\164nglig"

If I change the fromField instance to that it works as expected. However changing the InputValue instance to that instead displays "TillgÃ¤nglig".

It appears there is some inconsistent encoding.', '2020-08-15 10:20:08.802497+02', '5ed92089-74f3-421f-abc0-423027d0449d', 'b3f690dd-6600-4460-8be7-be884e922aff');
INSERT INTO public.threads (id, title, body, created_at, user_id, topic_id) VALUES ('fe8e4512-5ea8-4dc5-b98f-8837568daddc', 'Show hint for using single ticks in SQL TEXT default value', 'When you are creating a TEXT field inside of the schema builder and want to assign a default value to it you need to frame it in single ticks for it to work. This is normal SQL Syntax but it would be better to have a hint displayed there.', '2020-08-15 10:22:04.095079+02', '5ed92089-74f3-421f-abc0-423027d0449d', 'b3f690dd-6600-4460-8be7-be884e922aff');
INSERT INTO public.threads (id, title, body, created_at, user_id, topic_id) VALUES ('ff4d038f-b6ae-4eb2-ac9c-412980070f40', 'test', 'test', '2020-08-15 13:05:29.092513+02', '45563d80-6be3-4301-93b4-5b444e25805d', 'b3f690dd-6600-4460-8be7-be884e922aff');


ALTER TABLE public.threads ENABLE TRIGGER ALL;


ALTER TABLE public.comments DISABLE TRIGGER ALL;

INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('8afb4d0f-da24-4b68-8cdb-3381e57956b1', '1df1fb5a-b592-4716-9c68-b82527623a3b', '5ed92089-74f3-421f-abc0-423027d0449d', 'test', '2020-08-15 11:10:46.008091+02');
INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('ee45309a-23f3-427f-b598-71c4baf37f01', '1df1fb5a-b592-4716-9c68-b82527623a3b', '5ed92089-74f3-421f-abc0-423027d0449d', 'test', '2020-08-15 11:11:22.618672+02');
INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('4481798b-8f13-4a25-bc8c-5a1486545806', '1df1fb5a-b592-4716-9c68-b82527623a3b', '5ed92089-74f3-421f-abc0-423027d0449d', 'test', '2020-08-15 11:17:33.544905+02');
INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('c769ea2d-1bc8-4443-95a4-2e2ad8c86e78', '1df1fb5a-b592-4716-9c68-b82527623a3b', '45563d80-6be3-4301-93b4-5b444e25805d', 'asd', '2020-08-15 12:22:12.205081+02');
INSERT INTO public.comments (id, thread_id, user_id, body, created_at) VALUES ('20f9eaa8-090b-4eb7-a38f-425cb41bfd5c', '1df1fb5a-b592-4716-9c68-b82527623a3b', '45563d80-6be3-4301-93b4-5b444e25805d', 'asd', '2020-08-15 12:22:56.576882+02');


ALTER TABLE public.comments ENABLE TRIGGER ALL;


