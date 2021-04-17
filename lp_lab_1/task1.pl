% Вставка элемента в список на указанную позицию
% с помощью стандартного предиката

append([], List2, List2).
append([Head|Tail], List2, [Head|TailResult]):-
   append(Tail, List2, TailResult).

addtolist(Elem, 1, [Head|Tail], ResL) :- append([Elem], [Head], NewL), append(NewL, Tail, ResL).

addtolist(Elem, N, [Head|Tail], ResL) :- N > 1, N1 is N-1, 
   addtolist(Elem, N1, Tail, L), append([Head], L, ResL).


% Вставка элемента в список на указанную позицию
% с помощью своего предиката

addtomylist(Elem, 1, [Head|Tail], ResL) :- Tail \= [], ResL = [Elem, Head|Tail].
addtomylist(Elem, 1, [], ResL) :- ResL = [Elem]. % если добавлять в конец

addtomylist(Elem, N, [Head|Tail], ResL) :- N > 1, N1 is N-1, 
   addtomylist(Elem, N1, Tail, L), ResL = [Head|L].



% Проверка списка на арифметическую прогрессию
% с помощью своего предиката

checkOr([Head1, Head2|Tail], X) :- Y is Head2 - Head1, X = Y, Tail \= [], checkOr([Head2|Tail], X). 
checkOr([Head1, Head2|Tail], X) :- Y is Head2 - Head1, X = Y, Tail = [].

mycheck(L) :- L = [_]. % частный случай
mycheck(L) :- L = [_, _]. % частный случай
mycheck([Head1, Head2|Tail]) :- X is Head2 - Head1, checkOr([Head2|Tail], X).


% Проверка списка на арифметическую прогрессию
% стандартного предиката
makeOri([X],X,_,_).
makeOri([H|Tail],H,Q,N) :- N>1, M is N-1, X is H+Q, makeOri(Tail,X,Q,M).

sublist([], _).
sublist([X|T1],[X|T2] ) :- sublist(T1, T2).

check(L) :- L = [_]. % частный случай
check(L) :- L = [_, _]. % частный случай
check([Head1, Head2|Tail]) :- X is Head2 - Head1, length([Head1, Head2|Tail], N), makeOri(OriList, Head1, X, N), 
      length(OriList, N), sublist([Head1, Head2|Tail], OriList).