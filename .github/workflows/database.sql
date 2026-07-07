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
