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
    sort(List, Sorted). % если нет промежутков, сортировка

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
    bubbleSortPass(List, Sorted, _).

bubbleSortPass([], [], _).

bubbleSortPass([X], [X], _).

bubbleSortPass([X, Y|Rest], [Y, X|SortedRest], Swapped) :-
    X > Y, 
    !,
    bubbleSortPass([X|Rest], SortedRest, true).

bubbleSortPass([X|Rest], [X|SortedRest], Swapped) :-
    bubbleSortPass(Rest, SortedRest, Swapped).

sort_4_2 :-
    write('list? '),
    read(List),
    bubbleSort(List, Sorted),
    write('answer: '),
    writeln(Sorted).
