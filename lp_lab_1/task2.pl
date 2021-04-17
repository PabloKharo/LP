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