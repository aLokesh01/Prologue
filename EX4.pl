%Define heuristic values for each node
heuristic(a, 3).
heuristic(b, 5).
heuristic(c, 4).
heuristic(d, 6).
heuristic(e, 2).
heuristic(f, 1).

% Define graph connections (edges)
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).

% Hill Climbing Start Predicate
hill_climb(Start, Path) :-
    hill_climb_util(Start, [Start], RevPath),
    reverse(RevPath, Path).

% Base Case: No better neighbor
hill_climb_util(Current, Visited, Visited) :-
    findall(Neighbor,
        (edge(Current, Neighbor), \+ member(Neighbor, Visited)),
        Neighbors),
    \+ better_neighbor(Current, Neighbors, _).

% Recursive Step: Move to best neighbor
hill_climb_util(Current, Visited, Path) :-
    findall(Neighbor,
        (edge(Current, Neighbor), \+ member(Neighbor, Visited)),
        Neighbors),
    better_neighbor(Current, Neighbors, Best),
    hill_climb_util(Best, [Best|Visited], Path).

% Find better neighbor with highest heuristic value
better_neighbor(Current, Neighbors, BestNeighbor) :-
    heuristic(Current, H1),
    findall(HN-Node,
        (member(Node, Neighbors), heuristic(Node, HN), HN > H1),
        BetterList),
    BetterList \= [],
    keysort(BetterList, Sorted),
    reverse(Sorted, [_-BestNeighbor|_]).
