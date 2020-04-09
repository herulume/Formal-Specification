----------------------------- MODULE hourclock -----------------------------

EXTENDS Naturals
VARIABLE hr

HCini == hr \in (1 .. 12)
HCnxt == hr' = IF hr # 12 THEN hr + 1 ELSE 1
HC == HCini /\ [HCnxt]_hr

 \* THEOREM HC => []HCini
 
=============================================================================
\* Modification History
\* Last modified Wed Jan 08 12:17:38 WET 2020 by herulume
\* Created Tue Jan 07 17:56:46 WET 2020 by herulume