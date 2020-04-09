-------------------------- MODULE MemoryInterface --------------------------

VARIABLE memInt

CONSTANTS Send(_, _, _, _), (* Send(p, d, memInt, memInt')
                             processor p sending value d to mem *)
          Reply(_, _, _, _),
          InitMemInt,
          Proc,
          Adr,
          Val

ASSUME \A p, d, miOld, miNew : /\ Send(p, d, miOld, miNew) \in BOOLEAN
                               /\ Reply(p, d, miOld, miNew) \in BOOLEAN
                               

MReq == [op: {"Rd"}, adr : Adr] \union [op: {"Wr"}, adr: Adr, val : Val]
        (* Set of all requests *)
        
NoVal == CHOOSE v : v \notin Val 
=============================================================================
\* Modification History
\* Last modified Wed Jan 08 12:21:47 WET 2020 by herulume
\* Created Wed Jan 08 12:13:43 WET 2020 by herulume
