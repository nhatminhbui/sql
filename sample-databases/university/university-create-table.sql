create table majors (
    major_id char(2) primary key,
    major varchar(32) not null
)

create table time_slots (
    time_slot_id char(2) primary key,
    weekday varchar(9) not null,
    start_time time not null,
    end_time time not null
)

create table buildings (
    building_code char(3) primary key,
    building_name varchar(64) not null
)

create table classrooms (
    classroom_id varchar(5) primary key,
    building_code char(3) references buildings,
    capacity smallint not null
)

create table departments (
    dept_name varchar(45) primary key
)

create table staff (
    staff_id varchar(8) primary key,
    staff_first_name varchar(32) not null,
    staff_last_name varchar(32) not null,
    staff_street_address varchar(64) not null,
    staff_city varchar(32) not null,
    salary numeric(8, 2) check (salary >= 50000) not null,
    staff_position varchar(32) not null,
    hired_date date not null
)

CREATE TABLE students (
    student_id char(10) primary key,
    stud_first_name varchar(32) not null,
    stud_last_name varchar(32) not null,
    stud_gender char(1) not null,
    stud_birthdate date,
    stud_street_address varchar(64),
    stud_city varchar(32),
    stud_phone_number varchar(12) not null,
    major_id char(2) references majors
)

create table faculty (
    staff_id varchar(8) references staff,
    title varchar(32),
    dept_name varchar(45) references departments,
    unique(staff_id)
)

create table courses (
    course_code varchar(10) primary key,
    course_title varchar(64) not null,
    credits smallint not null check (credits > 0),
    dept_name varchar(45) references departments
)

create table prerequisites (
    course_id varchar(10) references courses,
    prereq_id varchar(10) references courses
)

create table classes (
    classid varchar(10) primary key,
    course_code varchar(10) references courses,
    classroom_id varchar(5) references classrooms,
    semester varchar(6) check (semester in ('Spring', 'Fall', 'Summer')),
    class_year smallint not null check (class_year >= 1700 and class_year <= 2100),
    time_slot_id char(2) references time_slots
)

create table faculty_classes (
    staff_id varchar(8) references faculty(staff_id),
    class_id varchar(10) references classes
)

create table enrollment (
    student_id char(10) references students,
    class_id varchar(10) references classes,
    stud_class_status varchar(7) check (stud_class_status in ('Passed', 'Failed', 'Ongoing')),
    grade numeric(3, 2)
)



