:- module(compile_scfg,[generate/2]).

:- use_module(library(lists)).

:- op(1050, xfy, '--->').
:- op(1040, xfy, '//'   ).


generate(L1,L2) :-
    length(L1,_),
    user:s(L1,[],L2,[]).

generate_all:-
    generate(L,M), format("~w ~w~n",[L,M]), fail.

compile_rule((M ---> L // R), Rule) :-
    compile_cat(M,A0,A,B0,B,Goal),
    compile_left(L,A0,A,BodyList),
    compile_right(R,B0,B,BodyList),
    predicate(BodyList,Goal,Rule).

predicate([],Goal,Goal).
predicate([H|T],Goal,(Goal:-Body)) :-
   body(T,H,Body).

body([],H,H).
body([H|T],N,(N,Body)):-
    body(T,H,Body).

compile_cat_or_term([H|T],A0,A,R0,R) :-
    !,
    lists:append([H|T],A,A0),
    R0 = R.
compile_cat_or_term([],A0,A,R0,R) :-
    !,
    A0 = A,
    R0 = R.
compile_cat_or_term(M,A0,A,[Goal|T],T):-
    compile_cat(M,A0,A,_,_,Goal).

compile_cat(M,A0,A,B0,B,Goal) :-
    M =.. [Fun|Args],
    lists:append(Args,[A0,A,B0,B],NewArgs),
    Goal =.. [Fun|NewArgs].

compile_left((H,T),A0,A,Result):-
    !,
    compile_cat_or_term(H,A0,A1,Result,Tail),
    compile_left(T,A1,A,Tail).
compile_left(H,A0,A,Result):-
    compile_cat_or_term(H,A0,A,Result,[]).


compile_right((H,T),B0,B,List) :-
    !,
    compile_right_cat_or_term(H,B0,B1,List),
    compile_right(T,B1,B,List).

compile_right(H,B0,B,List) :-
    compile_right_cat_or_term(H,B0,B,List).

compile_right_cat_or_term([H|T],A0,A,_) :-
    !,
    lists:append([H|T],A,A0).
compile_right_cat_or_term([],A0,A,_) :-
    !,
    A0 = A.
compile_right_cat_or_term(Int,A0,A,Rule) :-
    integer(Int),
    nth1(Int,Rule,Cat),
    Cat =.. [_|Args],
    lists:append(_,[A0,A],Args).

user:term_expansion(Rule,Goal) :-
    compile_rule(Rule,Goal).


