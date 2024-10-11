% Task Task 5.1
/*
- Волк не может оставаться с козлом без контроля фермера
- Коза не может оставаться с капустой без контроля фермера

Не совсем понятно, надо ли писать код вопросов, но я просто рассуждал по коду модуля FWGC.pl
a) Фермер последовательно перевозит козла волка, затем капутсу
   1. Перевозит козла на другой берег
   2. Возвращается на исходный берег
   3. Перевозит волка на другой берег
   4. Возвращается за козлом
   Task 5. Перевозит капусту на другой берег
   6. Возвращается за козлом и перевозит его на другой берег
   
b) Фермер перевозит всех на другой берег, но возвращается сам в конце:
   1. Перевозит козла на другой берег
   2. Возвращается на исходный берег
   3. Перевозит волка на другой берег
   4. Возвращается за козлом
   Task 5. Перевозит капусту на другой берег
   6. Возвращается за козлом и перевозит его на другой берег

c) Фермер перевозит волка и козла, а капуста уже на том берегу:
   - Это состояние невозможно, так как волк не может оставаться с козлом без контроля фермера. Происходит отсечение

d) Фермер перевозит волка и козла, оставляя капусту на исходном берегу:
   - Это состояние невозможно, так как волк не может оставаться с козлом без контроля фермера. Происходит отсечение

e) Фермер перевозит волка и капусту, а козёл уже ждёт на том берегу:
   - Это состояние невозможно, так как волк и козел не могут оставаться вместе на одном берегу. Происходит отсечение
*/

% Rooms
% Сделал комнату а без окон, соединяется только с комнатой b, потому что на картинке её нет.
connected(a, b).
connected(b, a).
connected(b, c).
connected(c, b).
connected(b, e).
connected(e, b).
connected(c, d).
connected(d, c).
connected(d, e).
connected(e, d).
connected(d, h).
connected(h, d).
connected(h, f).
connected(f, h).
connected(f, e).
connected(e, f).
connected(e, j).
connected(j, e).
connected(i, f).
connected(f, i).
connected(i, j).
connected(j, i).
connected(k, i).
connected(i, k).
connected(k, l).
connected(l, k).
connected(l, j).
connected(j, l).
connected(j, g).
connected(g, j).

% Поиск в ширину для пути от Start к Goal
bfs([[Goal | Path] | _], Goal, [Goal | Path]). % если Goal найден, возвращаем путь
bfs([[Current | Path] | Rest], Goal, Result) :- % проверяем текущую комнату
    findall(Next, (connected(Current, Next), \+ member(Next, [Current | Path])), NextRooms),
    addToQueue(NextRooms, [Current | Path], NewPaths),
    append(Rest, NewPaths, NewFrontier), % добавляем новые пути в очередь
    bfs(NewFrontier, Goal, Result).

addToQueue([], _, []). % Если нет новых комнат, возвращаем пустой список
addToQueue([Next | Rest], Path, [[Next, Path] | NewPaths]) :- 
    addToQueue(Rest, Path, NewPaths).

% Task 5.2 # 1 Напечатать список комнат, через которые лежит путь к комнате G, выбранный Прологом.
path2(Start, Path) :- 
    bfs([[Start]], g, RevPath),
    reverse(RevPath, Path).  % Разворачиваем, чтобы получить правильный порядок пути

% Task 5.3 #1 При входе в комнату X печатать "entering room X".
path3(X) :-
    format('entering room ~w~n', [X]).

% Task 5.4 #1 посчитать и напечатать количество комнат, через которые надо пройти к G.
path4(Start, Count) :-
    path2(Start, Path),
    flatten(Path, FlatPath), % предикат упрощения подсписков в один список
    list_to_set(FlatPath, UniqueRooms),
    length(UniqueRooms, Count).

% Task 5.5 #1 Пройти к комнате L ,не входя в комнату E.
path5(Start, Path) :- 
    bfs([[Start]], l, PathNoE),
    \+ member(e, PathNoE). % E не должно быть в пути

% Task 5.6 #1 Найти и напечатать все возможные пути из комнаты А  в комнату L.
path6(Start, End, Path) :- 
    findall(Path, path(Start, End, [Start], Path), AllPaths),
    printAllPaths(AllPaths).

% Вспомогательный предикат для поиска одного пути
path(Start, End, Visited, [End | Visited]) :- 
    connected(Start, End).  % Если есть прямая связь

path(Start, End, Visited, Path) :-
    connected(Start, Next),
    Next \= End,
    \+ member(Next, Visited),  % Проверяем, что комната еще не посеезна
    path(Next, End, [Next | Visited], Path).

printAllPaths([]).

printAllPaths([Path | Rest]) :-
    reverse(Path, CorrectPath),  
    format('Path: ~w~n', [CorrectPath]),
    printAllPaths(Rest).

% Task 5.7 #2  В некоторых комнатах есть окна. Например, в комнате H их целых три.  Надо посчитать количество окон в комнатах, 
% через которые лежит путь  к комнате L.
windows(h, 3).
windows(a, 0).
windows(b, 1).
windows(c, 1).
windows(d, 0).
windows(e, 0).
windows(f, 1).
windows(g, 0).
windows(i, 1).
windows(j, 1).
windows(k, 1).
windows(l, 1).

path7(Room, Count) :-
    % Это говнокод, но я обещаю его когда-нибудь переписать, однако он работает! Вы не сомневайтесь
    bfs([[Room]], l, RevPath),
    reverse(RevPath, RevPathReversed),
    flatten(RevPathReversed, FlatPathReversed),
    reverse(FlatPathReversed, FlatPath),
    append(FlatPath, [l], FinalPath),
    traverseRooms(FinalPath),
    findall(W, (member(X, FinalPath), windows(X, W)), Windows),
    sumlist(Windows, RawCount),
    Count is max(RawCount - 1, 0).

traverseRooms([l|Rest]) :- !, traverseRooms(Rest).
traverseRooms([]).
traverseRooms([Room | Rest]) :-
    path3(Room),
    traverseRooms(Rest).

% Task 5.8 #2  Найти самый короткий путь к комнате L, используя assert и retract. 
% Идея состоит в следующем: надо задать заведомо самый длинный путь way(М), а затем, 
% перебирая все возможные пути к L, заменять way(M) на более короткий,используя при этом assert и retract.
path8(Start, ShortestPath) :-
    assert(way([1000, []])),
    findPathsToL(Start),
    retract(way([Length, Path])), % получаем кратчайший путь
    flatten(Path, FlatPath), % убираем список спиков
    exclude(=(l), FlatPath, CleanPath),  % Удаляем все вхождения l из пути, потому что рефакторить логику я сейчас не в состоянии
    reverse(CleanPath, CleanPathReversed),
    append(CleanPathReversed, [l], ShortestPath).

% Находим все пути к L
findPathsToL(Start) :-
    bfs([[Start]], l, RevPath),  
    reverse(RevPath, Path),     
    append(Path, [l], FinalPath), 
    length(FinalPath, Length),
    updatheShortestPath([Length, FinalPath]). % обновляем кратчайший путь    

updatheShortestPath([Length, Path]) :-
    way([CurrentLength, _]), 
    Length < CurrentLength,
    retract(way([CurrentLength, _])),
    assert(way([Length, Path])).  
updatheShortestPath(_).  % Если не короче, ничего не делаем

% Task 5.9 #2  Сделать то же, что в пункте 5.8, но без assert и retract.

% Task 5.10 #4 Найти кратчайший путь, проходящий через все комнаты с кладом