----------------------------- MODULE InnerFIFO -----------------------------

EXTENDS Naturals, Sequences
CONSTANT Message
VARIABLES in, out, q

InChan == INSTANCE Channel WITH Data <- Message, chan <- in
OutChan == INSTANCE Channel WITH Data <- Message, chan <- out

Init == /\ InChan!Init
        /\ OutChan!Init
        /\ q = <<>>
        
TypeInvariant == /\ InChan!TypeInvariant
                 /\ OutChan!TypeInvariant
                 /\ q \in Seq(Message)
                 
SSend(msg) == /\ InChan!Send(msg) (* Send msg on channel in *)
              /\ UNCHANGED << out, q >>

BufRcv == /\ InChan!Rcv (* Rcv message from channel in *)
          /\ q' = Append(q, in.val) (* append it to tail of q*)
          /\ UNCHANGED out
          
          
BufSend == /\ q # <<>>
           /\ OutChan!Send(Head(q))
           /\ q' = Tail(q)
           /\ UNCHANGED in
           
RRcv == /\ OutChan!Rcv
        /\ UNCHANGED << in, q >>

SysNext == BufRcv \/ BufSend
EnvNext == RRcv \/ \E msg \in Message : SSend(msg)
Next == SysNext \/ EnvNext
        
Spec == Init /\ [][Next]_<<in, out, q>>

THEOREM Spec => []TypeInvariant
=============================================================================
\* Modification History
\* Last modified Wed Jan 08 12:03:15 WET 2020 by herulume
\* Created Wed Jan 08 11:19:04 WET 2020 by herulume
