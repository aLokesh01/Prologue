%facts
father(john,peter).
father(john,mary).
mother(jane,peter).
mother(jane,mary).
spouse(john,jane).

%rules
parent(X,Y):-father(X,Y).
parent(X,Y):-mother(X,Y).
sibling(X,Y):-father(F,X),father(F,Y),mother(M,X),mother(M,Y),X\=Y.