--------------------------- MODULE AsyncInterface ---------------------------

EXTENDS Naturals
CONSTANT Data
VARIABLES val, rdy, ack

TypeInvariant == /\ val \in Data
                 /\ rdy \in {0, 1}
                 /\ ack \in {0, 1}
                 
Init == /\ val \in Data
        /\ rdy \in {0, 1}
        /\ ack = rdy
        
Send == /\ rdy = ack
        /\ val' \in Data
        /\ rdy' = 1 - rdy
        /\ UNCHANGED ack
        
Rcv == /\ rdy # ack
       /\ ack' = 1 - ack
       /\ UNCHANGED << val, rdy >>
       
Next == Send \/ Rcv

Spec == Init /\ [][Next]_<< val, rdy, ack>>

THEOREM Spec => []TypeInvariant
=============================================================================
\* Modification History
\* Last modified Wed Jan 08 10:19:11 WET 2020 by herulume
\* Created Tue Jan 07 20:50:28 WET 2020 by herulume
