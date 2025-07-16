% Goal State
canget(state(_, _, _, has)).

% Climb action: if monkey and box are in the same position and monkey is on the floor
canget(state(P, onfloor, P, hasnot)) :-
climb,
canget(state(P, onbox, P, has)).

% Push action: move box while the monkey is on the floor and pushing it
canget(state(P1, onfloor, P1, hasnot)) :-
push(P1, P2),
canget(state(P2, onfloor, P2, hasnot)).

% Move action: move monkey alone (not pushing box)
canget(state(P1, onfloor, P2, hasnot)) :-
move(P1, P3),
canget(state(P3, onfloor, P2, hasnot)).

% Actions: move, push, climb
move(atdoor, atwindow).
move(atwindow, atdoor).
move(atdoor, atmiddle).
move(atmiddle, atdoor).
move(atwindow, atmiddle).
move(atmiddle, atwindow).
push(atdoor, atwindow).
push(atwindow, atdoor).
push(atdoor, atmiddle).
push(atmiddle, atdoor).
push(atwindow, atmiddle).
push(atmiddle, atwindow).
climb. % No conditions here – assumed always possible when preconditions are met