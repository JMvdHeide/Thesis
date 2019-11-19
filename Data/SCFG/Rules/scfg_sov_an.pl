:- use_module(compile_scfg).

:- op(1050, xfy, '--->').
:- op(1040, xfy, '//'   ).

s ---> np, vp // 1, 2.

np ---> [the], adj, [horse] // [het], 1, [paard].
np ---> [the], adj, [dog] // [de], 1, [hond].
np ---> [the], adj, [cat] // [de], 1, [kat].
np ---> [the], adj, [doctor] // [de], 1, [dokter].
np ---> [the], adj, [man] // [de], 1, [man].
np ---> [the], adj, [woman] // [de], 1, [vrouw].
np ---> [the], adj, [pig] // [het], 1, [varken].
np ---> [the], adj, [rooster] // [de], 1, [haan].
np ---> [the], adj, [bear] // [de], 1, [beer].
np ---> [the], adj, [creature] // [het], 1, [wezen].
np ---> [the], adj, [butterfly] // [de], 1, [vlinder].

vp ---> np, [hears] // [hoort], 1.
vp ---> np, [sees] // [ziet], 1.
vp ---> np, [follows] // [volgt], 1.
vp ---> np, [calls] // [roept], 1.
vp ---> np, [hugs] // [knuffelt], 1.
vp ---> np, [admires] // [bewondert], 1.
vp ---> np, [hits] // [slaat], 1.
vp ---> np, [pets] // [aait], 1.
vp ---> np, [pushes] // [duwt], 1.
vp ---> np, [teases] // [plaagt], 1.
vp ---> np, [insults] // [beledigt], 1.

adj ---> [friendly] // [vriendelijke].
adj ---> [pretty] // [mooie].
adj ---> [big] // [grote].
adj ---> [nice] // [aardige].
adj ---> [little] // [kleine].
adj ---> [pale] // [bleke].
adj ---> [happy] // [blije].
adj ---> [angry] // [boze].
adj ---> [excited] // [opgewonden].
adj ---> [ugly] // [lelijke].
adj ---> [ignorant] // [onwetende].

