DROP TABLE IF EXISTS blogs CASCADE;
DROP TABLE IF EXISTS discussions CASCADE;
DROP TABLE IF EXISTS exercises CASCADE;
DROP TABLE IF EXISTS certificates CASCADE;
DROP TABLE IF EXISTS program_completions CASCADE;
DROP TABLE IF EXISTS course_modules CASCADE;
DROP TABLE IF EXISTS program_modules CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS enrollments CASCADE;
DROP TABLE IF EXISTS quizzes CASCADE;
DROP TABLE IF EXISTS lessons CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS teaching_groups CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS programs CASCADE;
DROP TABLE IF EXISTS modules CASCADE;
DROP TYPE IF EXISTS status_enrollment CASCADE;
DROP TYPE IF EXISTS payment_status CASCADE;
DROP TYPE IF EXISTS status_program_completion CASCADE;
DROP TYPE IF EXISTS title_status CASCADE;

CREATE TABLE modules (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP DEFAULT NULL
);
CREATE TABLE programs (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    price INTEGER,
    program_type VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE courses (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP DEFAULT NULL
);
CREATE TABLE teaching_groups (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE users (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    teaching_group_id bigint REFERENCES teaching_groups(id),
    name VARCHAR(255),
    role VARCHAR(50),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP DEFAULT NULL
);
CREATE TABLE lessons (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id bigint REFERENCES courses(id),
    name VARCHAR(255),
    content TEXT,
    video_url VARCHAR(255),
    position INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP DEFAULT NULL
);
CREATE TABLE quizzes (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint REFERENCES lessons(id),
    name VARCHAR(255),
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TYPE status_enrollment AS ENUM('active', 'pending', 'cancelled', 'completed');
CREATE TABLE enrollments (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES users(id),
    program_id bigint REFERENCES programs(id),
    status status_enrollment,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TYPE payment_status AS ENUM('pending', 'paid', 'failed', 'refunded');
CREATE TABLE payments (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id bigint REFERENCES enrollments(id),
    amount numeric(10,2),
    status payment_status,
    paid_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE program_modules (
    program_id bigint REFERENCES programs(id),
    module_id bigint REFERENCES modules(id),
	 PRIMARY KEY (program_id, module_id) 
);

CREATE TABLE course_modules (
    course_id bigint REFERENCES courses(id),
    module_id bigint REFERENCES modules(id),
	PRIMARY KEY (course_id, module_id)
);

CREATE TYPE status_program_completion AS ENUM('active', 'completed', 'pending', 'cancelled');
CREATE TABLE program_completions (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES users(id),
    program_id bigint REFERENCES programs(id),
	status status_program_completion,
	started_at TIMESTAMP, 
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE certificates (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES users(id),
    program_id bigint REFERENCES programs(id),
    url TEXT NOT NULL,
    issued_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE exercises (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint REFERENCES lessons(id),
    name VARCHAR(255),
    url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE discussions (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint REFERENCES lessons(id),
    text TEXT,
    user_id bigint REFERENCES discussions(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE title_status AS ENUM ('created', 'in moderation', 'published', 'archived');
CREATE TABLE blogs (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES users(id),
    name VARCHAR(255),
	content TEXT NOT NULL,
    status title_status,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);