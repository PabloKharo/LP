:- encoding(utf8).
:- consult('dict.pl').

:- op(200, xfy, ':').

compare(List1, List2, Ph1, Ph2, Res):-
    an_phrase(Ph1, List1),
    an_phrase(Ph2, List2),
    Ph1 = Ph2, !,
    Res = yes.

compare(List1, List2, Ph1, Ph2, Res):-
    an_phrase(Ph1, List1),
    an_phrase(Ph2, List2), !,
    Res = no.

an_phrase(Res, [A,B,C,D,E]):-
    an_noun(Ag1, pad('именит'), A),
    an_union(B),
    an_noun(Ag2, pad('именит'), C),
    an_verb(Verb, zalog('актив'), D),
    an_noun(Obj, pad('винит'), E),
    Res =..[Verb, [agent(Ag1), agent(Ag2)], object(Obj)].

an_phrase(Res, [A,B,C,D,E]):-
    an_noun(Obj, pad('именит'), A),
    an_verb(Verb, zalog('пассив'), B),
    an_noun(Ag1, pad('творит'), C),
    an_union(D),
    an_noun(Ag2, pad('творит'), E),
    Res =..[Verb, [agent(Ag1), agent(Ag2)], object(Obj)].

an_noun(StartForm, Form, X):- nouns(L), find(X, StartForm, Form, L).
an_verb(StartForm, Form, X):- verbs(L), find(X, StartForm, Form, L).
an_union(X) :- unions(L), member(X, L).

find(X, StartForm, Form, L) :- member(Word, L), condition(X, StartForm, Form, Word).
condition(X, StartForm, Form, StartForm:Form:LForms) :- member(X, LForms).



