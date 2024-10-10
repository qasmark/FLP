% Task 1
% a)
parent(bill, joe).
parent(sue, joe).
parent(joe, tammy).
parent(bill, ann).
parent(sue, ann).
parent(paul, jim).
parent(mary, jim).
parent(ann, bob).
parent(jim, bob).

male(bill).
male(joe).
male(paul).
male(jim).
male(bob).

female(sue).
female(ann).
female(mary).
female(tammy).

different(X, Y) :- X \= Y.

sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), different(X, Y).
brother(X, Y) :- parent(Z, X), parent(Z, Y), male(X), different(X, Y).

aunt(X, Y) :- sister(X, Z), parent(Z, Y).
cousin(X, Y) :- parent(Z, X), parent(W, Y), sister(Z, W).
cousin(X, Y) :- parent(Z, X), parent(W, Y), brother(Z, W).

% b) parent(X, bob), parent(Y, X), female(Y).
% c) parent(X, Y), parent(Y, Z), male(Z).
% d) sister(X, jim).
% e) aunt(ann, tammy).
% f) cousin(bob,tammy).

% Task 2
% a)
likes(ellen, reading).
likes(john, computers).
likes(john, badminton).
likes(john, photo).
likes(john, reading).
likes(leonard, badminton).
likes(eric, swimming).
likes(eric, reading).
likes(eric, chess).
likes(paul, swimming).

has_four_hobbies(Person) :- 
  setof(Hobby, likes(Person, Hobby), Hobbies),
    length(Hobbies, 4).

have_same_hobby(Person1, Person2) :-
  likes(Person1, Hobby),
  likes(Person2, Hobby),
  Person1 \= Person2.

% b) has_four_hobbies()
% c) likes(X, Hobby), likes(Y, Hobby), X \= Y.