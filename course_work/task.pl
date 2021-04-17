:- consult('res_family.pl').

% Предикаты child(ребенок, родитель), male(человек), female(человек)

% 3
sibling(X, Y) :- child(X, Z), child(Y, Z), male(Z), Y \= X.
cousin(X, Y) :- child(X, Z), sibling(Z, V), child(Y, V). 
secondcousin(X, Y) :- child(X, Z), cousin(Z, V), child(Y, V).

% 4

tie('brother', X, Y) :- sibling(X, Y), male(Y).
tie('sister', X, Y) :- sibling(X, Y), female(Y).

tie('son', X, Y) :- child(Y, X), male(Y).
tie('daughter', X, Y) :- child(Y, X), female(Y).

tie('father', X, Y) :- child(X, Y), male(Y).
tie('mother', X, Y) :- child(X, Y), female(Y).


next(X, Z) :- child(X,Z).
next(X, Z) :- child(Z,X).
next(X, Z) :- sibling(X, Z).

plus_one(1).
plus_one(M):- plus_one(N), (N < 12 -> M is N+1; !, fail).

search(Path, X, Y, N) :- N = 1, tie(A, X, Y), Path = [A].
search(Path, X, Y, N) :- N > 1, next(X, Z), N1 is N-1, search(Res, Z, Y, N1), tie(B, X, Z), append([B], Res, Path).

:- op(200, xfy, --->).
parse(X--->Z, [X|T]) :- parse(Z, T).
parse(X, [X]).

relative(Res, X, Y) :- var(Res), plus_one(N), search(L, X, Y, N), Y \= X, parse(Res, L).
relative(Res, X, Y) :- nonvar(Res), parse(Res, L), length(L, N), search(L, X, Y, N), Y \= X.

% 5

parseask(Type, Tie, X, Y) --> quest(Type), body(Type, Tie, X, Y), quessign.
quest(who) --> [who], [is].
quest(relation)  --> [what], word, ['between'].
quest(truefalse) --> [is].
quest(howmany)   --> [how], [many].
word --> [X], {member(X, [relationships, relations])}.
body(who, Tie, X, _)      --> name(Tie), [to], name(X).
body(relation, _, X, Y) --> name(X), [and], name(Y).
body(truefalse, Tie, X, Y)--> name(X), name(Tie), [to], name(Y).
body(howmany, Tie, X, _)  --> name(Tie), name(X), [has].
name(X) --> [Y], [X], {member(Y, [the, a])}, !.
name(X) --> [X].
quessign --> [?].

ans(who, Tie, X, _, Res) :- relative(Tie, X, Res).
ans(relation, _, X, Y, Res) :- relative(Res, Y, X).
ans(truefalse, Tie, X, Y, Res) :- (relative(Tie, Y, X) -> Res = yes; Res = no).
ans(howmany, Tie, X, _, Res) :- findall(Y, relative(Tie, X, Y), L), length(L, Res).

ask(L, Res) :- parseask(Type, Tie, X, Y, L, []), ans(Type, Tie, X, Y, Res).
