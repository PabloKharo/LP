
% step(  Input,          After Step  )
step([A, w, o, D, E], [A, o, w, D, E]).
step([w, B, o, D, E], [o, B, w, D, E]).
step([A, B, o, w, E], [A, B, w, o, E]).
step([A, B, o, D, w], [A, B, w, D, o]).

step([A, b, o, D, E], [A, o, b, D, E]).
step([b, B, o, D, E], [o, B, b, D, E]).
step([A, B, o, b, E], [A, B, b, o, E]).
step([A, B, o, D, b], [A, B, b, D, o]).

%move(        Input                   After Step        )
move([o, B, C, D, E, F, G], [A1, B1, C1, D,  E,  F,  G ]) :- step([x, x, o, B, C], [x,  x,  A1, B1, C1]).
move([A, o, C, D, E, F, G], [A1, B1, C1, D1, E,  F,  G ]) :- step([x, A, o, C, D], [x,  A1, B1, C1, D1]).
move([A, B, o, D, E, F, G], [A1, B1, C1, D1, E1, F,  G ]) :- step([A, B, o, D, E], [A1, B1, C1, D1, E1]).
move([A, B, C, o, E, F, G], [A,  B1, C1, D1, E1, F1, G ]) :- step([B, C, o, E, F], [B1, C1, D1, E1, F1]).
move([A, B, C, D, o, F, G], [A,  B,  C1, D1, E1, F1, G1]) :- step([C, D, o, F, G], [C1, D1, E1, F1, G1]).
move([A, B, C, D, E, o, G], [A,  B,  C,  D1, E1, F1, G1]) :- step([D, E, o, G, x], [D1, E1, F1, G1, x ]).
move([A, B, C, D, E, F, o], [A,  B,  C,  D,  E1, F1, G1]) :- step([E, F, o, x, x], [E1, F1, G1, x,  x ]).


next([X|T], [Y, X|T]):- move(X, Y), not(member(Y, [X|T])).


% поиск в глубину
depth([L|T], [L|T]) :- L = [b, b, b, o, w, w, w], !.
depth(L, Res) :- next(L, NewL), depth(NewL, Res). 

dep():- L = [w, w, w, o, b, b, b], depth([L], Path), write(Path), nl.


% поиск в ширину
width([[L|T]|_], [L|T]) :- L = [b, b, b, o, w, w, w].
width([Elem|Top], ResPath):- findall(X, next(Elem, X), Bottom), append(Top, Bottom, AllL), !, width(AllL, ResPath).
width([_|T], ResPath):- width(T, ResPath).

wid():- L = [w, w, w, o, b, b, b], width([[L]], Res), write(Res), nl.


% поиск в глубину с итерационным углублением
plus_one(1).
plus_one(M):- plus_one(N), M is N + 1.

depth([L|T], [L|T], _) :- L = [b, b, b, o, w, w, w].
depth(L, Res, N) :- N > 0, next(L, NewL), N1 is N-1, depth(NewL, Res, N1).

id_find(L, Res):- plus_one(N), depth([L], Res, N).

idfdep():- L = [w, w, w, o, b, b, b], id_find(L, Path), write(Path), nl.



