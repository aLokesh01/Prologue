% Graph edges (directed)
edge(a, b).
edge(a, c).
edge(b, e).
edge(b, f).
edge(c, g).
edge(c, d).
edge(e, k).
edge(f, l).
edge(f, m).
edge(g, h).
edge(h, n).

% Treat graph as undirected (optional)
connected(X, Y) :- edge(X, Y).
connected(X, Y) :- edge(Y, X).

% Entry point for DFS
depthfirst([Start]) :-
    dfs([Start], []).

% DFS traversal
dfs([], _) :- !.
dfs([Node | Rest], Visited) :-
    \+ member(Node, Visited),        
    write(Node), write(' '),         
    findall(Neighbor,
            (connected(Node, Neighbor),
             \+ member(Neighbor, Visited)),
            Neighbors),              
    append(Neighbors, Rest, NewStack),   
    dfs(NewStack, [Node | Visited]).     
dfs([Node | Rest], Visited) :-
    member(Node, Visited),           
    dfs(Rest, Visited).
