/**
 * http://alloy4fun.inesctec.pt/Pdvipvrpr5hg7JKbs
 * First-order logic revision exercises based on a simple model of a 
 * classroom management system.
 * 
 * The model has 5 unary predicates (sets), Person, Student, Teacher,
 * Group and Class, Student and Teacher a sub-set of Person. There are 
 * two binary predicates, Tutors a sub-set of Person x Person, and 
 * Teaches a sub-set of Person x Teaches. There is also a ternary 
 * predicate Groups, sub-set of Class x Person x Group.
 *
 * Solve the following exercises using only Alloy's first-order 
 * logic:
 *	- terms 't' are variables
 *	- atomic formulas are either term comparisons 't1 = t2' and 
 * 't1 != t2' or n-ary predicate tests 't1 -> ... -> tn in P' and 
 * 't1 -> ... -> tn not in P'
 *	- formulas are composed by 
 *		- Boolean connectives 'not', 'and', 'or' and 'implies'
 *		- quantifications 'all' and 'some' over unary predicates
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
  all x : Person | x in Student
}

/* There are no teachers. */
pred inv2 {
  all x : Person | x not in Teacher
}

/* No person is both a student and a teacher. */
pred inv3 {
  all x : Person | x in Student implies x not in Teacher
}

/* No person is neither a student nor a teacher. */
pred inv4 {
  all x : Person | x in Student or x in Teacher
}

/* There are classes assigned to teachers. */
pred inv5 {
  some x : Teacher, y : Class | x->y in Teaches
}

/* Every teacher has classes assigned. */
pred inv6 {
  all x : Teacher | some y : Class | x->y in Teaches
}

/* Every class has teachers assigned. */
pred inv7 {
  all y : Class | some x : Teacher | x->y in Teaches
}

/* Teachers are assigned at most one class. */
pred inv8 {
  all x : Teacher, y,z : Class | x->y in Teaches and x->z in Teaches implies y=z
}

/* No class has more than a teacher assigned. */
pred inv9 {
  all x : Class, y,z : Teacher | y->x in Teaches and z->x in Teaches implies y=z
}

/* For every class, every student has a group assigned. */
pred inv10 {
  all x : Class, y : Student | some z : Group | x->y->z in Groups
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
  all x : Class | (some y : Person, z : Group | x->y->z in Groups) implies some v : Teacher | v->x in Teaches
}

/* Each teacher is responsible for some groups. */
pred inv12 {
  all x : Teacher | some y : Class, z : Group, v : Person | x->y in Teaches and y->v->z in Groups 
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
  all x, y : Person | x->y in Tutors implies x in Teacher and y in Student
}

/* Every student in a class is at least tutored by the teachers
 * assigned to that class. */
pred inv14 {
  all x, v : Person, y : Class | (some z : Group | y->x->z in Groups) and v->y in Teaches implies v->x in Tutors
}

/* Assuming a universe of 3 persons, the tutoring chain of every
 * person eventually reaches a Teacher. */
pred inv15 {

}
