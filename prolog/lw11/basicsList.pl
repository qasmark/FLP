% Task 3.1
trim([_ | T], L2) :-
    append(L2, [_], T).

% Task 3.2
first_last([First | Rest], [Last | NewRest]) :-
    append(Middle, [Last], Rest),
    append(Middle, [First], NewRest).

% Task 3.3
total([], 1).
total([H | T], N) :-
    total(T, N1),
    N is H * N1.

% Task 3.4
place(X, L, [X | L]).
place(X, [H | T], [H | R]) :-
    place(X, T, R).

% Task 3.5
double([], []).
double([H | T], [H, H | T2]) :-
    double(T, T2).

% Task 3.6
split(L1, L2, L3) :- 
    split_helper(L1, [], L2, [], L3).

split_helper([], EvenAcc, EvenRes, OddAcc, OddRes) :- 
    reverse(EvenAcc, EvenRes),
    OddRes = OddAcc.            
split_helper([H | T], EvenAcc, EvenRes, OddAcc, OddRes) :- 
    (   0 is H mod 2
    ->  split_helper(T, [H | EvenAcc], EvenRes, OddAcc, OddRes)
    ;   split_helper(T, EvenAcc, EvenRes, [H | OddAcc], OddRes)
    ).

% Task 3.7
repeat_back3(L1, L2) :-
    append([First | Middle], [Last], L1),
    append([Last, Last, Last | Middle], [First, First, First], L2).

% Task 3.8
combi([], L2, L2).
combi([H | T], [H2 | T2], [H, H2 | R]) :-
    combi(T, T2, R).
combi([H | T], [], [H | R]) :-
    combi(T, [], R).
