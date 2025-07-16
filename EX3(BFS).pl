edge(a, b).
% bfs_helper(Queue, Visited, ResultPath)
bfs_helper([], _, []). 
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(e, f).
edge(f, g).

% Since edges are bidirectional (undirected graph), define connection both ways
connected(X, Y) :- edge(X, Y).
connected(X, Y) :- edge(Y, X).

% BFS entry point: bfs(Start, Path)
bfs(Start, Path) :-
    bfs_helper([Start], [], Path).


bfs_helper([Current|RestQueue], Visited, [Current|Path]) :-
    member(Current, Visited),  
    bfs_helper(RestQueue, Visited, Path).

bfs_helper([Current|RestQueue], Visited, [Current|Path]) :-
    \+ member(Current, Visited),  
    findall(Neighbor,
            (connected(Current, Neighbor), \+ member(Neighbor, Visited), \+ member(Neighbor, RestQueue)),
            Neighbors),
    append(RestQueue, Neighbors, NewQueue),
    bfs_helper(NewQueue, [Current|Visited], Path).
