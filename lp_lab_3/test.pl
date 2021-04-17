%t1 - 8
%получает ласт элемент
%last_el([1,2,3], X). - X=3
%last_el([1,2,3], 3). - true
last_el([_|X], A):-last_el(X,A).
last_el([X], X).

%t1 - 9
%вычисляет факториал числа
%fact(4,X). - X=24
fact(1,1):-!.
fact(N,R):- N1 is N-1, fact(N1,R1), R is R1*N.

%t1 - 10
%next([1,3,2], 3, X). - X=2
%next([1,3,2], 2, X). - false
%next([1,3,2], 1, X). - X=3
next(L,X,Y):-append(_,[X,Y|_], L).

%t2 - 1
%test(X, [1,2]). - X=[]
%test(X, [1,2,3]). - X=3
test --> append([_,_]).

%t2 - 8
%проверяет что количество элементов списка нечетное
%not_even([1,2,3]). - true
%not_even([1,2]). - false
not_even([_]).
not_even([_,_|X]):-not_even(X).

%t2 - 9
%выводит n-ое число Фибоначи
%fib(4, F). - F=3
fib(1,1):-!.
fib(2,1):-!.
fib(N,F):-N1 is N-1, fib(N1,F1), N2 is N-2, fib(N2, F2), F is F1+F2.

%t2 - 10
%получает последний элемент списка при помощи append
%last([1,2,3], X). - X=3
last(L, S) :- append(_,[X],L), S=X, !.

%t3 - 8
%проверяет что элементы из 2-ого списка стоят на нечетных позициях 1 списка.
%p([1,2,3], [1,3]). - true
%p([1,2,3], [1,2]). - false
%выделяет в список элементы с нечетных позиций
%p([1,2,3], X). - X = [1,3]
p([X,_|T],[X|R]):-p(T,R).
p([],[]).
p([X],[X]).

%t3 - 9
%st(number,power, RES_VAR).
st(F,1,F):-!.
st(Y,N,X):-N1 is N-1, st(Y, N1, X1), X is X1*Y.

%t3 - 10
%next([1,3,2], 3, X). - X=2
%next([1,3,2], 2, X). - false
%next([1,3,2], 1, X). - X=3
next(L,X,Y):-append(_,[X,Y|_], L).

%t4 - 8
%проверят что количество элементов четное
%even([1,2]). - true
%even([1]). - false
even([]).
even([_,_|X]):-even(X).

%t4 - 9
%sum([1,3,4], X). - X=8
sum(L,N):-sum(L,0,N).
sum([X|T],S,N):-S1 is S+X, sum(T,S1,N).
sum([],N,N).

%t4 - 10
%получает из списка L 3 последних элемента в список S
%last3([1,2,3,4], X). - X=[2,3,4]
last3(L,S):-append(_,[X,Y,Z], L), S=[X,Y,Z],!.
