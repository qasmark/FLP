solution(FishOwner) :-
    Houses = [
        house(Nat1, Color1, Drink1, Smoke1, Pet1),
        house(Nat2, Color2, Drink2, Smoke2, Pet2),
        house(Nat3, Color3, Drink3, Smoke3, Pet3),
        house(Nat4, Color4, Drink4, Smoke4, Pet4),
        house(Nat5, Color5, Drink5, Smoke5, Pet5)
    ],

    %  1) Англичанин живет в красном доме
    member(house(englishman, red, _, _, _), Houses),

    %  2) Швед держит собак
    member(house(swedish, _, _, _, dogs), Houses),

    %  3) Датчанин пьет чай
    member(house(danish, _, tea, _, _), Houses),

    %  4) Зеленый дом слева от белого дома
    next_to(house(_, green, _, _, _), house(_, white, _, _, _), Houses),

    %  5) Хозяин зеленого дома пьет кофе
    member(house(_, green, coffee, _, _), Houses),

    %  6) Любитель Pall Mall содержит птиц
    member(house(_, _, _, pallMall, birds), Houses),

    %  7) Хозяин желтого дома курит Dunhill
    member(house(_, yellow, _, dunhill, _), Houses),

    %  8) В центральном доме предпочитают молоко
    Houses = [_, _, house(_, _, milk, _, _), _, _],

    %  9) Норвежец живет в первом доме
    Houses = [house(norwegian, _, _, _, _)|_],

    %  10) Курящий Blend живет рядом с хозяином кошек
    next_to(house(_, _, _, blend, _), house(_, _, _, _, cats), Houses),

    %  11) Хозяин лошадей живет рядом с тем, кто курит Dunhill
    next_to(house(_, _, _, _, horses), house(_, _, _, dunhill, _), Houses),

    %  12) Любитель пива курит Bluemasters
    member(house(_, _, beer, bluemasters, _), Houses),

    %  13) Немец курит Prince
    member(house(german, _, _, prince, _), Houses),

    %  14) Норвежец живет рядом с синим домом
    next_to(house(norwegian, _, _, _, _), house(_, blue, _, _, _), Houses),

    %  15) Курящий Blend живет рядом с тем, кто пьет воду
    next_to(house(_, _, _, blend, _), house(_, _, water, _, _), Houses),

    % кто держит рыбок
    member(house(FishOwner, _, _, _, fish), Houses).
    % Ответ: немец :)
    
next_to(X, Y, List) :-
    append(_, [X, Y|_], List);
    append(_, [Y, X|_], List).
