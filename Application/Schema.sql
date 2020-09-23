CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE threads (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    user_id UUID NOT NULL,
    topic_id UUID NOT NULL
);
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    github_name TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
CREATE TABLE comments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    thread_id UUID NOT NULL,
    user_id UUID NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
CREATE TABLE topics (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    description TEXT DEFAULT '' NOT NULL,
    threads_count INT DEFAULT 0 NOT NULL,
    last_activity_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
CREATE TYPE badges AS ENUM ('ihp_contributor', 'ihp_sticker_owner', 'di_team', 'di_partner', 'forum_samaritan');
CREATE TABLE user_badges (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    badge badges NOT NULL,
    UNIQUE (user_id, badge)
);
ALTER TABLE threads ADD CONSTRAINT threads_ref_topic_id FOREIGN KEY (topic_id) REFERENCES topics (id) ON DELETE NO ACTION;
ALTER TABLE threads ADD CONSTRAINT threads_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE comments ADD CONSTRAINT comments_ref_thread_id FOREIGN KEY (thread_id) REFERENCES threads (id) ON DELETE NO ACTION;
ALTER TABLE comments ADD CONSTRAINT comments_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE user_badges ADD CONSTRAINT user_badges_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;
