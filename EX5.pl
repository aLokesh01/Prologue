edge(a, b, 1).
edge(a, c, 3).
edge(b, d, 4).
edge(c, d, 1).
edge(d, e, 5).

heuristic(a, 7).
heuristic(b, 6).
heuristic(c, 2).
heuristic(d, 1).
heuristic(e, 0).

astar(Start, Goal, Path, Cost) :-
    astar_search([[Start, 0, 0, [Start]]], Goal, RevPath, Cost),
    reverse(RevPath, Path).

astar_search([[Goal, _, Cost, Path] | _], Goal, Path, Cost).
astar_search([[Node, G, _, Path] | Rest], Goal, FinalPath, Cost) :-
    findall([Next, G1, F1, [Next | Path]],
            (edge(Node, Next, C),
             \+ member(Next, Path),
             G1 is G + C,
             heuristic(Next, H),
             F1 is G1 + H),
            Children),
    append(Rest, Children, NewQueue),
    prepare_pairs(NewQueue, Pairs),
    keysort(Pairs, SortedPairs),
    extract_states(SortedPairs, SortedQueue),
    astar_search(SortedQueue, Goal, FinalPath, Cost).

    prepare_pairs([], []).
    prepare_pairs([[Node, G, F, Path] | Rest], [F-[Node, G, F, Path] | Pairs]) :-
    prepare_pairs(Rest, Pairs).

   extract_states([], []).
   extract_states([_-State | Rest], [State | States]) :-
   extract_states(Rest, States).
