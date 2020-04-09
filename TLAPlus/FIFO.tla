-------------------------------- MODULE FIFO --------------------------------

CONSTANT Message
VARIABLES in, out

Inner(q) == INSTANCE InnerFIFO
Spec == \EE q : Inner(q)!Spec
=============================================================================
\* Modification History
\* Last modified Wed Jan 08 11:42:02 WET 2020 by herulume
\* Created Wed Jan 08 11:41:10 WET 2020 by herulume
