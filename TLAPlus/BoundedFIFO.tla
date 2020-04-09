---------------------------- MODULE BoundedFIFO ----------------------------

EXTENDS Naturals, Sequences
VARIABLES in, out
CONSTANTS Message, N

ASSUME (N \in Nat) /\ (N > 0)

Inner(q) == INSTANCE InnerFIFO

BNext(q) == /\ Inner(q)!Next
            /\ Inner(q)!BufRcv => Len(q) < N

Spec == \EE q : Inner(q)!Init /\ [][BNext(q)]_<< in, out, q>>
=============================================================================
\* Modification History
\* Last modified Wed Jan 08 11:54:32 WET 2020 by herulume
\* Created Wed Jan 08 11:51:48 WET 2020 by herulume
