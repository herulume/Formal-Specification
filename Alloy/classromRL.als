/**
 * http://alloy4fun.inesctec.pt/i5u2pjKJt6Bz227QT
 * Relational logic revision exercises based on a simple model of a 
 * classroom management system.
 * 
 * The model has 5 unary predicates (sets), Person, Student, Teacher,
 * Group and Class, Student and Teacher a sub-set of Person. There are 
 * two binary predicates, Tutors a sub-set of Person x Person, and 
 * Teaches a sub-set of Person x Teaches. There is also a ternary 
 * predicate Groups, sub-set of Class x Person x Group.
 *
 * Solve the following exercises using Alloy's relational logic, which
 * extends first-order logic with:
 *	- expression comparisons 'e1 in e2' and 'e1 = e2'
 *	- expression multiplicity tests 'some e', 'lone e', 'no e' and 'one e'
 *	- binary relational operators '.', '->', '&', '+', '-', ':>' and '<:' 
 *	- unary relational operators '~', '^' and '*'
 *	- definition of relations by comprehension
 **/

/* The registered persons. */
sig Person  {
	/* Each person tutors a set of persons. */
	Tutors : set Person,
	/* Each person teaches a set of classes. */
	Teaches : set Class
}

/* The registered groups. */
sig Group {}

/* The registered classes. */
sig Class  {
	/* Each class has a set of persons assigned to a group. */
	Groups : Person -> Group
}

/* Some persons are teachers. */
sig Teacher in Person  {}

/* Some persons are students. */
sig Student in Person  {}

/* Every person is a student. */
pred inv1 {
  Person in Student
}

/* There are no teachers. */
pred inv2 {
  no Teacher
}

/* No person is both a student and a teacher. */
pred inv3 {
  no Student & Teacher
}

/* No person is neither a student nor a teacher. */
pred inv4 {
  Person in Student + Teacher
}

/* There are some classes assigned to teachers. */
pred inv5 {
  some Teacher.Teaches
}

/* Every teacher has classes assigned. */
pred inv6 {
  Teacher in Teaches.Class
}

/* Every class has teachers assigned. */
pred inv7 {
  Class in Teacher.Teaches
}

/* Teachers are assigned at most one class. */
pred inv8 {
  ~(Teacher <: Teaches).(Teacher <: Teaches) in iden
}

/* No class has more than a teacher assigned. */
pred inv9 {
  (Teacher <: Teaches).~(Teacher <: Teaches) in iden
}

/* For every class, every student has a group assigned. */
pred inv10 {
  all s : Student, c : Class | some s.(c.Groups)
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
  all c : Class | (some c.Groups) implies some Teacher & Teaches.c
}

/* Each teacher is responsible for some groups. */
pred inv12 {
  all t : Teacher | some (t.Teaches).Groups
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
  Tutors in Teacher <: Tutors :> Student
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Student, t : Teacher, c : Class | some s.(c.Groups) and some (t<:Teaches).c implies some (t<:Tutors).s
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
  all s : Person | some (^Tutors.s & Teacher)
}

