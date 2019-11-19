:- use_module(compile_scfg).

:- op(1050, xfy, '--->').
:- op(1040, xfy, '//'   ).

s ---> np, vp // 1, 2.

np ---> [the], [horse], adj // [het], 1, [paard].
np ---> [the], [dog], adj // [de], 1, [hond].
np ---> [the], [cat], adj // [de], 1, [kat].
np ---> [the], [doctor], adj // [de], 1, [dokter].
np ---> [the], [man], adj // [de], 1, [man].
np ---> [the], [woman], adj // [de], 1, [vrouw].
np ---> [the], [pig], adj // [het], 1, [varken].
np ---> [the], [rooster], adj // [de], 1, [haan].
np ---> [the], [bear], adj // [de], 1, [beer].
np ---> [the], [creature], adj // [het], 1, [wezen].
np ---> [the], [butterfly], adj // [de], 1, [vlinder].

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

