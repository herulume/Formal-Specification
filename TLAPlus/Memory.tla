------------------------------- MODULE Memory -------------------------------

EXTENDS MemoryInterface

Inner(mem, ctl, buf) == INSTANCE InternalMemory

Spec == \EE mem, ctl, buf : Inner(mem, ctl, buf)!ISpec
=============================================================================
\* Modification History
\* Last modified Wed Jan 08 13:04:47 WET 2020 by herulume
\* Created Wed Jan 08 13:02:58 WET 2020 by herulume
