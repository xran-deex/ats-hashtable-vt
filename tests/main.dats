#include "../hashtable-vt.hats"

staload $HT
staload $LM

implement main(argc, argv) = 0 where {
    val ht = hashtbl_make_nil<strptr,List_vt(strptr)>(i2sz 10)

    val name = copy("Bob")
    val nick = copy("Robert")
    val nick2 = copy("Robert2")
    val name2 = copy("Bob2")
    val nick3 = copy("Robert3")
    val ls = list_vt_cons(nick, list_vt_nil())
    val ls = list_vt_cons(nick2, ls)
    val ls2 = list_vt_cons(nick3, list_vt_nil())

    val-~None_vt() = hashtbl_insert_opt(ht, copy(name), ls)
    val-~None_vt() = hashtbl_insert_opt(ht, copy(name2), ls2)
    val-~Some_vt(v) = hashtbl_takeout_opt(ht, name)
    val-~Some_vt(v2) = hashtbl_takeout_opt(ht, name2)
    implement fprint_ref<strptr>(o,i) = print!(i)
    val () = println!("key: ", name, ", value: ", v)
    val () = println!("key: ", name2, ", value: ", v2)
    val () = free(name)
    val () = free(name2)
    vtypedef pair = (strptr,List_vt(strptr))
    implement gclear_ref<pair>(i) = () where {
        val () = strptr_free(i.0)
        val () = list_vt_freelin(i.1)
    }
    implement gclear_ref<strptr>(i) = free(i)
    val () = list_vt_freelin(v)
    val () = list_vt_freelin(v2)

    implement hashtbl_free$clear<strptr,List_vt(strptr)>(k,i) = () where {
        val () = strptr_free(k)
        val () = list_vt_freelin(i)
    }
    val () = hashtbl_free(ht)
}
