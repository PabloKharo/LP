:- encoding(utf8).

member(Elem, [Elem|_]).
member(Elem, [_|Tail]) :- member(Elem, Tail).

not_member(_, []).
not_member(Elem, [Head|Tail]) :- Elem \= Head, not_member(Elem, Tail).

% Только один из родственников удовлетворяет условиям
onerelative(Ans, Y1, Y2) :- not_member(Y2, Ans), !, member(Y1, Ans).
onerelative(Ans, _, Y2) :- member(Y2, Ans).


% Генерал, полковник, майор, капитан и лейтенант
% Сапер, пехотинец, танкист, связист, артиллерист
% Горький, Ленинград, Киев, Свердловск
% У каждого из них есть сестра. И каждый из них женат на сестре своего однополчанина.

% [Профессия, звание, [Горький, Ленинград, Киев, Свердловск], профессия мужа сестры, профессия брата жены]
solve() :- Ans = [  [сапер, SaperRank, [_, _, _, _], SisterSaper, WifeSaper],
                    [пехотинец, PehotRank, [_, _, _, _], SisterPehot, WifePehot], 
                    [танкист, TankRank, [_, _, _, _], SisterTank, WifeTank], 
                    [связист, SvyzRank, [_, _, _, _], SisterSvyz, WifeSvyz], 
                    [артиллерист, ArtylRank, [_, _, _, _], SisterArtyl, WifeArtyl]    ],

% Все перестановки званий
permutation([генерал, полковник, майор, капитан, лейтенант], 
            [SaperRank, PehotRank, TankRank, SvyzRank, ArtylRank]),

% Связист не самый старший по званию.
SvyzRank \= генерал,

% Капитан никогда не служил в Горьком.
member([_, капитан, [false, _, _, _], _, _], Ans),

% Оба родственника пехотинца служили раньше в Ленинграде
member([SisterPehot, _, [_, true, _, _], _, пехотинец], Ans),
member([WifePehot, _, [_, true, _, _], пехотинец, _], Ans),

% Оба родственника танкиста служили раньше в Ленинграде.  
member([SisterTank, _, [_, true, _, _], _, танкист], Ans),
member([WifeTank, _, [_, true, _, _], танкист, _], Ans),

% Ни один родственник генерала в Ленинграде не был.
member([General, генерал, _, SisterGeneral, WifeGeneral], Ans), 
member([SisterGeneral, _, [_, false, _, _], _, General], Ans),
member([WifeGeneral, _, [_, false, _, _], General, _], Ans),

% Танкист служил в Киеве
member([танкист, _, [_, _, true, _], _, _], Ans), 

% Оба родственника танкиста служили в Киеве
member([SisterTank, _, [_, _, true, _], _, танкист], Ans),
member([WifeTank, _, [_, _, true, _], танкист, _], Ans),

% Лейтенант не служил в Киеве.
member([_, лейтенант, [_, _, false, _], _, _], Ans),

% Полковник служил в Свердловске 
member([_, полковник, [_, _, _, true], _, _], Ans),

% Оба родственника полковника служили в Свердловске.
member([Polkov, полковник, _, SisterPolkov, WifePolkov], Ans), 
member([SisterPolkov, _, [_, _, _, true], _, Polkov], Ans),
member([WifePolkov, _, [_, _, _, true], Polkov, _], Ans), 

% Танкист не служил в Свердловске. 
member([танкист, _, [_, _, _, false], _, _], Ans), 

% Только один из родственников танкиста служил в Свердловске.
onerelative(Ans, [SisterTank, _, [_, _, _, true], _, танкист], 
                [WifeTank, _, [_, _, _, true], танкист, _]), 

% Генерал служил в Горьком
member([_, генерал, [true, _, _, _], _, _], Ans),  

% Оба родственника генерала служили в Горьком
member([SisterGeneral, _, [true, _, _, _], _, General], Ans),
member([WifeGeneral, _, [true, _, _, _], General, _], Ans),

% Генерал в Свердловске не бывал.
member([_, генерал, [_, _, _, false], _, _], Ans),

% Артиллерист не служил ни в Горьком, ни в Киеве.
member([артиллерист, _, [false, _, false, _], _, _], Ans),

% Профессия мужа сестры не должна быть равна профессии брата жены
SisterSaper \= WifeSaper,
SisterPehot \= WifePehot,
SisterTank \= WifeTank,
SisterSvyz \= WifeSvyz,
SisterArtyl \= WifeArtyl,

% Вывод результатов
write(Ans), nl,
write("Сапер: "), write(SaperRank), nl,
write("Пехотинец: "), write(PehotRank), nl,
write("Танкист: "), write(TankRank), nl,
write("Связист: "), write(SvyzRank), nl,
write("Артиллерист: "), write(ArtylRank), nl.
