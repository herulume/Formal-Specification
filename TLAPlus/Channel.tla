------------------------------ MODULE Channel ------------------------------

EXTENDS Naturals
CONSTANT Data
VARIABLE chan

TypeInvariant == chan \in [val: Data, rdy: {0, 1}, ack:{0,1}]

Init == /\ TypeInvariant
        /\ chan.ack = chan.rdy

Send(d) == /\ chan.rdy = chan.ack
           /\ chan' = [chan EXCEPT !.val = d, !.rdy = 1 - @]

Rcv == /\ chan.rdy # chan.ack
       /\ chan' = [chan EXCEPT !.ack = 1 - @]

Next == (\E d \in Data : Send(d)) \/ Rcv

Spec == Init /\ [][Next]_chan


THEOREM Spec => []TypeInvariant
=============================================================================
\* Modification History
\* Last modified Wed Jan 08 11:19:13 WET 2020 by herulume
\* Created Wed Jan 08 10:26:40 WET 2020 by herulume
