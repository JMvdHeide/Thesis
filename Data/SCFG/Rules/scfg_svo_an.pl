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

vp ---> [hears], np // [hoort], 1.
vp ---> [sees], np // [ziet], 1.
vp ---> [follows], np // [volgt], 1.
vp ---> [calls], np // [roept], 1.
vp ---> [hugs], np // [knuffelt], 1.
vp ---> [admires], np // [bewondert], 1.
vp ---> [hits], np // [slaat], 1.
vp ---> [pets], np // [aait], 1.
vp ---> [pushes], np // [duwt], 1.
vp ---> [teases], np // [plaagt], 1.
vp ---> [insults], np // [beledigt], 1.

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

