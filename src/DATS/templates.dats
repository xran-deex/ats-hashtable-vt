#include "./../HATS/includes.hats"
staload "libats/SATS/hashfun.sats"
staload "./../SATS/hashtbl_chain_vt.sats"

implement
equal_key_key<strptr>(k1,k2) = $UNSAFE.castvwtp1{string}(k1) = $UNSAFE.castvwtp1{string}(k2)

implement
copy_key<strptr>(k) = res where {
  val () = assertloc(strptr_isnot_null(k))
  val res = copy(k)
}
implement
free_key<strptr>(k) = free(k)
implement
hash_key<strptr> (str) = res where {
  val () = assertloc(strptr_isnot_null(str))
  val res = string_hash_multiplier (31UL, 618033989UL, $UNSAFE.strptr2string(str))
}
