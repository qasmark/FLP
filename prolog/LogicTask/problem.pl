surname(Surname) :-
    member(Surname, [kuznetsov, tokarev, slesarev, rezhikov]).

profession(Profession) :-
    member(Profession, [blacksmith, turner, locksmith, cutter]).

generateArrangement(Arrangement) :-
    profession(ProfA), profession(ProfB), profession(ProfC), profession(ProfD),
    is_set([ProfA, ProfB, ProfC, ProfD]),
    surname(SurA), surname(SurB), surname(SurC), surname(SurD),
    is_set([SurA, SurB, SurC, SurD]),
    Arrangement = [
        sits(SurA, ProfA),
        sits(SurB, ProfB),
        sits(SurC, ProfC),
        sits(SurD, ProfD)
    ].

rightLeft(Arrangement, Right, Left) :-
    Arrangement = [Right, Left, _, _];
    Arrangement = [_, Right, Left, _];
    Arrangement = [_, _, Right, Left];
    Arrangement = [Left, _, _, Right].

opposite(Arrangement, A, B) :-
    Arrangement = [A, _, B, _];
    Arrangement = [_, A, _, B];
    Arrangement = [B, _, A, _];
    Arrangement = [_, B, _, A].

% Напротив Кузнецова сидит слесарь
condition(1, Arrangement) :-
    opposite(Arrangement, sits(kuznetsov, _), sits(_, locksmith)).

% Напротив Резчикова сидит резчик
condition(2, Arrangement) :-
    opposite(Arrangement, sits(rezhikov, _), sits(_, cutter)).

% Справа от Слесарева сидит токарь
condition(3, Arrangement) :-
    rightLeft(Arrangement, sits(_, turner), sits(slesarev, _)).

% Никто не работает по своей фамилии
condition(4, Arrangement) :-
    \+ member(sits(slesarev, locksmith), Arrangement),
    \+ member(sits(kuznetsov, blacksmith), Arrangement),
    \+ member(sits(tokarev, turner), Arrangement),
    \+ member(sits(rezhikov, cutter), Arrangement).

% Кто сидит слева от кузнеца?
solve(Who) :-
    generateArrangement(Arrangement),
    condition(1, Arrangement),
    condition(2, Arrangement),
    condition(3, Arrangement),
    condition(4, Arrangement),
    rightLeft(Arrangement, sits(_, blacksmith), Who).
