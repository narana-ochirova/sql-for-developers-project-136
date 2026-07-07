CREATE TABLE lessons (
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
cource_id bigint REFERENCES courses(id),
name VARCHAR(255),
content TEXT NOT NULL,
video_url TEXT NOT NULL,
position INTEGER,
created_at date,
updated_at date,
deleted_at date default NULL);

CREATE TABLE courses (
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
name VARCHAR(255),
description TEXT  NOT NULL,
created_at date,
updated_at date,
deleted_at date default NULL
);

CREATE TABLE modules(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
name VARCHAR(255),
description TEXT  NOT NULL,
created_at date,
updated_at date,
deleted_at date default null);

CREATE TABLE program_modules (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id bigint REFERENCES programs(id),
    module_id bigint REFERENCES modules(id)
);
CREATE TABLE course_modules (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id bigint REFERENCES courses(id),
    module_id bigint REFERENCES modules(id)
);

CREATE TABLE programs
(id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
module_id bigint  REFERENCES modules(id),
name VARCHAR(255),
price numeric(10,2) NOT NULL,
program_type VARCHAR(255),
created_at date,
updated_at date);

CREATE TABLE users(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
teaching_group_id bigint REFERENCES teaching_groups(id),
name VARCHAR(255),
role VARCHAR(50) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL,
password_hash VARCHAR(255) NOT NULL,
link_study_group TEXT,
created_at date,
update_at date,
deleted_at date default null
);

CREATE TABLE teaching_groups(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
slug VARCHAR(50) UNIQUE NOT NULL,
created_at date,
updated_at date
);

CREATE TYPE status_enrollment AS ENUM('active', 'pending', 'cancelled', 'completed');

CREATE TABLE enrollments(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
user_id bigint REFERENCES users (id),
program_id bigint REFERENCES programs(id),
curerent_status_enrollment status_enrollment,
created_at date,
updated_at date
);

CREATE TYPE payment_status AS ENUM('pending','paid','failed','refunded');

CREATE TABLE payments
(id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
enrollment_id bigint REFERENCES enrollments(id),
payment_amount numeric(10,2),
current_payment_status payment_status,
payment_date date,
created_at date,
updated_at date
);

CREATE TYPE status_program_completion AS ENUM('active', 'completed', 'pending', 'cancelled');
CREATE TABLE program_completions(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
user_id bigint REFERENCES users (id),
program_id bigint REFERENCES programs(id),
begin_program date,
end_program date,
created_at date,
updated_at date
);

CREATE TABLE certificates(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
user_id bigint REFERENCES users (id),
program_id bigint REFERENCES programs(id),
certificat_url TEXT NOT NULL,
issue_date date,
created_at date,
updated_at date
);

CREATE TABLE quizzes(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
lesson_id bigint REFERENCES lessons(id),
name_quiz VARCHAR(255),
content_quiz TEXT,
parent_id bigint REFERENCES quizzes(id) ON DELETE CASCADE,
created_at date,
updated_at date
);

CREATE TABLE exercises(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
lesson_id bigint REFERENCES lessons(id),
name_exercise VARCHAR(255),
exercise_url TEXT,
created_at date,
updated_at date
);

CREATE TABLE discussions(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
lesson_id bigint REFERENCES lessons(id),
discussion TEXT,
parent_id bigint REFERENCES discussions(id) ON DELETE CASCADE,
created_at date,
updated_at date
);

CREATE TYPE title_status AS ENUM ('created', 'in moderation', 'published', 'archived');
CREATE TABLE blog(
id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
student_id bigint REFERENCES users(id),
title VARCHAR(255),
current_title_status title_status,
created_at date,
updated_at date
);