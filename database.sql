CREATE TABLE lessons (id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
name_lesson VARCHAR(255),
content_lesson TEXT NOT NULL,
video_url TEXT NOT NULL,
position bigint,created_at_lesson date,
updated_at_lesson date,
cource_url TEXT NOT NULL,
is_deleted BOOLEAN DEFAULT FALSE NOT NULL);

CREATE TABLE courses (id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
lesson_id bigint REFERENCES lessons(id),
name_cource VARCHAR(255),
content_cource TEXT  NOT NULL,
created_at_course date,
updated_at_course date);

CREATE TABLE modules(id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
course_id bigint REFERENCES courses(id),
name_module VARCHAR(255),
content_module TEXT  NOT NULL,
created_at_module date,
updated_at_module date);

CREATE TABLE programs(id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
module_id bigint  REFERENCES modules(id),
name_program VARCHAR(255),
cost_program numeric(10,2) NOT NULL,
type_program VARCHAR(255),
created_at_program date,
updated_at_program date);

CREATE TABLE users(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
user_name VARCHAR(255),
role_user VARCHAR(50) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL,
password_hash VARCHAR(255) NOT NULL,
link_study_group TEXT,
created_at_user date,
update_at_user date
);

CREATE TABLE teaching_groups(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
--user_id bigint REFERENCES users (id),
slug VARCHAR(50) UNIQUE NOT NULL,
created_at_group date,
updated_at_group date
);
ALTER TABLE teaching_groups ADD COLUMN user_id bigint REFERENCES users (id);
