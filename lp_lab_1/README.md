# Отчет по лабораторной работе №1
## Работа со списками и реляционным представлением данных
## по курсу "Логическое программирование"

### студент: Харьков П.А.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение

Программируя на императивных языках, мы привыкли, что чаще всего храним данные в массивах: в них элементы хранятся последовательно и получить доступ к каждом из элементов можно получить с помощью индекса (номера этого элемента в последовательности). Но в языке Пролог списки представляют собой структуру, состоящую из "головы" - текущего элемента и "хвоста" - присоединенного списка. Получить доступ к N-ому элементу можно лишь пройдясь по всем элементам до него. 
Похожая структура есть и в императивных языка. Она называется "связным списком" и представляет собой структуру, где каждый элемент хранит свое значение и указатель на следующий элемент. Есть несколько реализаций "связного списка", к примеру, однонаправленный и двунаправленный. В языке Пролог список - однонаправленный, так как итерироваться по нему можно только в одном направление. В императивных языках существуют и двунаправленные списки, то есть каждый элемент еще хранит указатель на предыдущий элемент и итерироваьтся можно и с конца.

## Задание 1.1: Предикат обработки списка
 
`addtomylist(Elem, N, List, ResList)` - Добавляет элемент Elem на позицию N в список List. Результатом вставки, если она является успешной, является ResList.

Примеры использования:
```prolog
?- addtomylist(10, 2, [1], L).
L = [1, 10] .
?- addtomylist(10, 2, [1,2,3], L). 
L = [1, 10, 2, 3] .
?- addtomylist(X, 2, [1,2,3], [1,4,2,3]).  
X = 4;
```

Реализация с помощью стандратного предиката `append`:
```prolog
append([], List2, List2).
append([Head|Tail], List2, [Head|TailResult]):-
   append(Tail, List2, TailResult).

addtolist(Elem, 1, [Head|Tail], ResL) :- append([Elem], [Head], NewL), append(NewL, Tail, ResL).

addtolist(Elem, N, [Head|Tail], ResL) :- N > 1, N1 is N-1, 
   addtolist(Elem, N1, Tail, L), append([Head], L, ResL).
```

С помощью рекурсии доходим до нужной позии и с помощью стандарнтного предиката `append` вставляем элемент в список на эту позицию.

Реализация с помощью своего предиката:
```prolog
addtomylist(Elem, 1, [Head|Tail], ResL) :- Tail \= [], ResL = [Elem, Head|Tail].
addtomylist(Elem, 1, [], ResL) :- ResL = [Elem]. % если добавлять в конец

addtomylist(Elem, N, [Head|Tail], ResL) :- N > 1, N1 is N-1, 
   addtomylist(Elem, N1, Tail, L), ResL = [Head|L].
```

Предикат идет с помощью рекурсии по списку, вычитая каждый раз из позиции, в которую надо вставить единицу. Если нужная позиция будет равна 1, то вставляем наш элемент перед "головой" и "хвостом". Затем рекурсивно добавляем в результирующий список "головы" предыдущих элементов.

## Задание 1.2: Предикат обработки числового списка

`mycheck(L)` - Проверяет список на арифметическую прогрессию

Примеры использования:
```prolog
?- mycheck([1,2,3,4]).
true ;
?- mycheck([1,2,10,4]). 
false.
24 ?- mycheck([1]).        
true ;
```

Реализация с помощью стандратного предиката `sublist`:
```prolog
makeOri([X],X,_,_).
makeOri([H|Tail],H,Q,N) :- N>1, M is N-1, X is H+Q, makeOri(Tail,X,Q,M).

sublist([], _).
sublist([X|T1],[X|T2] ) :- sublist(T1, T2).

check(L) :- L = [_]. % частный случай
check(L) :- L = [_, _]. % частный случай
check([Head1, Head2|Tail]) :- X is Head2 - Head1, length([Head1, Head2|Tail], N), makeOri(OriList, Head1, X, N), 
      length(OriList, N), sublist([Head1, Head2|Tail], OriList).
```

Сначала создается список, с орифметической прогрессией, равной разности первых двух элементов, а затем полученный список с правильной арифметической прогрессией сравнивается с веденным списком.

Реализация с помощью своего предиката:
```prolog
checkOr([Head1, Head2|Tail], X) :- Y is Head2 - Head1, X = Y, Tail \= [], checkOr([Head2|Tail], X). 
checkOr([Head1, Head2|Tail], X) :- Y is Head2 - Head1, X = Y, Tail = [].

mycheck(L) :- L = [_]. % частный случай
mycheck(L) :- L = [_, _]. % частный случай
mycheck([Head1, Head2|Tail]) :- X is Head2 - Head1, checkOr([Head2|Tail], X).
```

Предикат вычисляет разность первых двух элементов, затем вызывает предикат checkOr, передавая все элементы, кроме первого и разность первых двух элементов. checkOr проверяет, равна ли разность двух элементов с разностью первых двух, если нет, то возвращает fail, если да и есть в списке больше 2 элементов, то рекурсивно вызывает себя, передавая "хвост" для текущей "головы".


## Задание 2: Реляционное представление данных

Главным преимуществом реляционного представления является ее простота: таблица интуитивно понятна человеку, так как наглядно описывает все поля каждой записи.
Недостатком реляционного представления можно назвать медленный доступ к данным, так как при худшей реализацией для того, чтобы получить нужное значение, необходимо проверить значения всех идущих до него элементов. Также этот метод не эффективен по памяти.

Примеры использования:
```prolog
?- write_members([101]).
101
[Безумников,Густобуквенникова,Мышин,Петровский,Сидоров]
?- write_average_mark([101,102]). 
Среднее значение для 101 группы: 3.9
Среднее значение для 102 группы: 3.7777777777777777
?- dont_pass().
Количество несдавших в группе 101: 2
Количество несдавших в группе 102: 4
Количество несдавших в группе 103: 3
Количество несдавших в группе 104: 4
```

Реализация:
```prolog
:- encoding(utf8).
:- consult('one.pl').

% Задание: Получить таблицу групп и средний балл по каждой из групп
write_groups_members() :- group_list(GroupL), write_members(GroupL).
write_groups_members() :- group_list(GroupL), write_average_mark(GroupL).

% Список групп
group(X) :- student(X, _). % необходим для setof().

group_list(List) :- setof(Group, group(Group), List).

% Ученики в группе
write_members([Group|Tail]) :- write(Group), nl, 
            setof(Stud, student(Group, Stud), L), 
            write(L), nl, nl, 
            write_members(Tail), fail.

% Средний балл по группе
write_average_mark([Group|Tail]) :- aver_mark(Group, Res), write("Среднее значение для "), 
            write(Group), write(" группы: "), write(Res), nl, 
            write_average_mark(Tail), fail.

aver_mark(Group, Res) :-  findall(Mark, (student(Group, Stud), grade(Stud, _, Mark)), L), 
            length(L, Length), sum_list(L, Sum), Res is (Sum / Length).


% Задание: Для каждого предмета получить список студентов, не сдавших экзамен (grade=2)

write_bad_marks() :- subject(X, Z), write(Z), nl, 
            bagof(Y, grade(Y, X, 2), L), 
            write(L), nl, nl, fail.

% Задание: Найти количество не сдавших студентов в каждой из групп

dont_pass() :- group_list(Group), write_dont_pass(Group).

has_bad_mark(Stud, Group) :- student(Group, Stud), grade(Stud, _, 2).

write_dont_pass([Head|Tail]) :- setof(Stud, has_bad_mark(Stud, Head), L), length(L, Len),
            write("Количество несдавших в группе "), write(Head), write(": "), write(Len),  nl, 
            write_dont_pass(Tail), fail.
```
Описание предикатов:
`write_groups_members()` - выводит на экран таблицу студентов каждой группы, а затем средний балл по группе.
Он реализован с помощью трех предикатов:
1. `group_list(GroupL)` - с помощью предиката setof ищет весь список групп, и определяет GroupL.
2. `write_members(GroupL)` - для каждой группы из списка групп с помощью предиката setof создает список студентов из группы и выводит список в консоль.
3. `write_average_mark(GroupL)` - для каждой группы из списка групп создает список оценок, считает сумму всех элементов списка и его длину, считает среднее значение всех оценок и выводит значение в консоль.

`write_bad_marks()` - для каждого предмета печатает список студентов, несдавших экзамен. Для каждого найденного предмета с помощью предиката bagof находится список несдавших этот экзамен, а затем выводится на экран.

`dont_pass()` - для каждой группы выводит число студентов, несдавших экзамены.
Он реализова с помощью двух предикатов:
1. `group_list(GroupL)` - с помощью предиката setof ищет весь список групп, и определяет GroupL.
2. `write_dont_pass([Head|Tail])` - для каждой группы с помощью предиката setof ищет список студентов, получивших 2, затем считает длину списка и выводит в консоль.

## Выводы

После использования императивных языков программирования, язык Пролог некоторое время был очень непривычен, так как писать на нем нужно не так, как я привык. Но после того, как начинаешь понимать, как все устроено в Прологе, то замечаешь, что решать на нем некоторые задачи гораздо проще, чем на императивных языках. Но также Пролог просто разивает мышление - возможно, именно благодаря этим лабораторным работам, в будущем я буду чаще находить нестандартные, но изящные решения задач.

Но я заметил, что иногда код на языке Пролог трудно читаем, а именно когда возможно много вариантов работы программы, то есть, существует много проверок объектов. К примеру, это заметно в решении 2 пункт 1 задания: там мне пришлось сначала считать разность двух элементов, затем проверять, равна ли эта разность предыдущей разности, а после, пустой ли "хвост". Из-за этого возникло очень много одиннакового кода, хотя, возможно, есть более элегантное решение.

