/* Task 4.1
Возьмем в качестве цели для объяснения следующий список:
[1, 2, 3, 2, 4]
Цель без отсечения:
Тогда, если мы уберем отсечение (то есть удалим ! в первом определении функции member)
?- member(X, [1, 2, 3, 2, 4]) результаты будут следующими:
X = 1 
X = 2
X = 2 
X = 3
X = 4
false

Т.о. без отсечения мы получаем все возможные решения для X

Цель с отсечением:
Для
?- member(X, [1, 2, 3, 2, 4]). результаты будут следующими:
X = 1
false (отсечение предотвращает поиск дальше)

Это красное отсечение по следующим причинам:
1) оно блокирует поиск всех остальных решений, как только будет найдено первое
2) все альтернативные решения игнорируются, даже если они существуют, что может привести к потере инфы
*/

% Task 4.2
% Последовательность реализована с помощью аккумулирующей рекурсии, что дает O(n) вместо O(2^n) при реализации без аккумулятора
fib(N, F) :-
    N > 0,
    fibAccHelper(N, 1, 1, F).

fib(N, _) :-
    N =< 0,
    write('error').

fibAccHelper(1, A, _, A) :- !. 
fibAccHelper(2, _, B, B) :- !.  
fibAccHelper(N, A, B, F) :-
    N > 2,
    N1 is N - 1,
    NewF is A + B,
    fibAccHelper(N1, B, NewF, F). 

% Task 4.3 
shellSort(List, Sorted) :-
    length(List, N),
    gapSeq(N, Gaps),
    shellSort(List, Gaps, Sorted).

gapSeq(N, Gaps) :-
    findall(Gap, gap(N, Gap), Gaps). % задаем последовательность промежутков из статьи на вики

gap(N, Gap) :-
    Gap is N // 2, 
    Gap > 0.

shellSort(List, [], Sorted) :-
    write(List).

shellSort(List, [Gap|Gaps], Sorted) :-
    performInsertionSort(List, Gap, TempSorted), % insertionSort в текущем gap
    shellSort(TempSorted, Gaps, Sorted).

performInsertionSort(List, Gap, Sorted) :-
    length(List, Length),
    performInsertionSort(List, Gap, 1, Length, Sorted). 

performInsertionSort(_, _, Current, Length, []) :-
    Current > Length, !.

performInsertionSort(List, Gap, Current, Length, [H|T]) :-
    index(Current, Gap, List, H),
    NewCurrent is Current + 1,
    performInsertionSort(List, Gap, NewCurrent, Length, T).

index(Current, Gap, List, H) :-
    Index is Current - 1,
    nth0(Index, List, H).

% Task 4.3.1
sort_3 :-
    write('list? '),
    read(List),
    shellSort(List, Sorted),
    write('answer: '),
    writeln(Sorted).

% Task 4.4.1
nativeSort([], []).
nativeSort(List, [Min|Sorted]) :-
    min_list(List, Min),
    select(Min, List, Rest),
    nativeSort(Rest, Sorted).

sort_4_1 :-
    write('list? '),
    read(List),
    nativeSort(List, Sorted),
    write('answer: '),
    writeln(Sorted).

% Task 4.4.2 
bubbleSort(List, Sorted) :-
    bubbleSortPass(List, Temp, Swapped),
    (
        Swapped -> bubbleSort(Temp, Sorted) 
        ; 
        Sorted = Temp
    ).

bubbleSortPass([X, Y | Rest], [Y | SortedRest], true) :-
    X > Y,
    bubbleSortPass([X | Rest], SortedRest, _).
bubbleSortPass([X, Y | Rest], [X | SortedRest], Swapped) :-
    X =< Y,
    bubbleSortPass([Y | Rest], SortedRest, Swapped).
bubbleSortPass([X], [X], false).
bubbleSortPass([], [], false).

sort_4_2 :-
    write('list? '),
    read(List),
    bubbleSort(List, Sorted),
    write('answer: '),
    writeln(Sorted).

% Task 4.4.3
insertionSort([], []).
insertionSort([H|T], Sorted) :-
    insertionSort(T, SortedTail),
    insert(H, SortedTail, Sorted).

insert(X, [], [X]).
insert(X, [Y|Rest], [X,Y|Rest]) :-
    X =< Y, !.
insert(X, [Y|Rest], [Y|SortedRest]) :-
    insert(X, Rest, SortedRest).

sort_4_3 :-
    write('list? '),
    read(List),
    insertionSort(List, Sorted),
    write('answer: '),
    writeln(Sorted).

% Task 4.4.4
quickSort([], []).
quickSort([Pivot|Rest], Sorted) :-
    partition(Rest, Pivot, Less, Greater),
    quickSort(Less, SortedLess),
    quickSort(Greater, SortedGreater),
    append(SortedLess, [Pivot|SortedGreater], Sorted).

partition([], _, [], []).
partition([H|T], Pivot, [H|Less], Greater) :-
    H =< Pivot,
    partition(T, Pivot, Less, Greater).
partition([H|T], Pivot, Less, [H|Greater]) :-
    H > Pivot,
    partition(T, Pivot, Less, Greater).

sort_4_4 :-
    write('list? '),
    read(List),
    quickSort(List, Sorted),
    write('answer: '),
    writeln(Sorted).

% Task 4.5
common(L1, L2, L3) :-
    append(L1, L2, L),
    list_to_set(L, Set),
    shellSort(Set, L3).

% Task 4.7
most_oft(List, X) :-
    frequency(List, FreqList), % чписка частот каждого элемента в изначальном списке
    maxFreq(FreqList, MaxFreq), 
    findall(Item, member(Item-MaxFreq, FreqList), Items), % поиск всех элементов с заданной частотой
    (
        Items = [SingleItem] -> X = SingleItem 
        ;
        X = Items
    ).


frequency([], []).
frequency([H|T], [H-F|FreqList]) :-
    count(H, [H|T], F), 
    removeAll(H, T, NewList), % очистка всех вхождений H из хвоитса
    frequency(NewList, FreqList). % рекурсивно продолжаем для остальноог списка

count(_, [], 0). % чисто мапка на слово : частота
count(X, [X|T], N) :-
    count(X, T, N1),
    N is N1 + 1.
count(X, [Y|T], N) :-
    X \= Y,
    count(X, T, N).

removeAll(_, [], []). % удаелние всех вхождений элмеента из списка, чтобы получить ответ
removeAll(X, [X|T], R) :-
    removeAll(X, T, R).
removeAll(X, [Y|T], [Y|R]) :-
    X \= Y,
    removeAll(X, T, R).

maxFreq([_-F], F). % страж: если один элемент в списке, возвращеам его частоту
maxFreq([_-F|T], MaxFreq) :-
    maxFreq(T, RestMaxFreq),
    MaxFreq is max(F, RestMaxFreq).
