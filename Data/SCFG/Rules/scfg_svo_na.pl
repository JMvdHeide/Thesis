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

