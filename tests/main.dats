#include "../hashtable-vt.hats"

staload $HT

vtypedef pair2 = @(strptr,strptr)
fn print_pair2(i: !pair2): void = println!(i.0, ", ", i.1)
overload print with print_pair2

implement main(argc, argv) = 0 where {
    val ht = hashtbl_make_nil<strptr,List_vt(strptr)>(i2sz 10)
    val ht2 = hashtbl_make_nil<strptr,pair2>(i2sz 10)
    val-~None_vt() = hashtbl_insert_opt(ht2, copy("Blah"), @(copy "hello", copy "blah"))

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
    val k = copy("Blah")
    val-~Some_vt(v3) = hashtbl_takeout_opt(ht2, k)
    implement fprint_ref<strptr>(o,i) = print!(i)
    // implement fprint_ref<pair2>(o,i) = print!(i.0, ", ", i.1)
    val () = println!("key: ", name, ", value: ", v)
    val () = println!("key: ", name2, ", value: ", v2)
    val () = println!("key: ", k, ", value: ", v3)
    val-~None_vt() = hashtbl_insert_opt(ht2, k, v3)
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
    implement hashtbl_free$clear<strptr,pair2>(k,i) = () where {
        val () = strptr_free(k)
        val () = strptr_free(i.0)
        val () = strptr_free(i.1)
    }
    val () = hashtbl_free(ht)
    val () = hashtbl_free(ht2)
}
