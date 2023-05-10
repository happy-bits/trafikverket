
/*
Students have names. 

Courses have titles.

A student can attend many courses. 

Some students don't attend any course.

A course can have many students.

Some courses are empty of students.
*/

create table student(
	id int primary key,
	name varchar(50)
);

create table course(
	id int primary key,
	title varchar(50)
);

create table attend(
	student_id int references student(id),
	course_id int references course(id),
	primary key(student_id, course_id)
);

insert into student values
	(1, 'Anna'),
	(2, 'Maria'),		
	(3, 'Lisa');	
	
insert into course values
	(100, 'JavaScript'),
	(101, 'Astronomy');
	
insert into attend values
	(3, 100),
	(3, 101),
	(1, 100);
	
select * from student;
select * from course;

select student.name, course.title
from student join attend on student.id = attend.student_id
join course on attend.course_id = course.id;

/*

The last query will output:

"Lisa"	"JavaScript" 
"Lisa"	"Astronomy"
"Anna"	"JavaScript"

*/