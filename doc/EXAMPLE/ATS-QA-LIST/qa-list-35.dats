(* ****** ****** *)
//
// HX-2013-06-14:
//
// ATS2 supports defined constants in patterns.
//
(* ****** ****** *)

#define GL_NO_ERROR 0x0
#define GL_INVALID_ENUM 0x0500
#define GL_INVALID_VALUE 0x0501
#define GL_INVALID_OPERATION 0x0502
#define GL_STACK_OVERFLOW 0x0503

(* ****** ****** *)

fn display_case
  (x: int): void = let
in
//
case+ x of
| GL_INVALID_ENUM => print("GL_INVALID_ENUM\n")
| GL_INVALID_VALUE => print("GL_INVALID_VALUE\n")
| GL_INVALID_OPERATION => print("GL_INVALID_OPERATION\n")
| GL_STACK_OVERFLOW => print("GL_STACK_OVERFLOW\n")
| _ => ()
//
end // end of [display_case]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [qa-list-35.dats] *)
