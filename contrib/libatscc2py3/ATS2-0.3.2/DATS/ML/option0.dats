(* ****** ****** *)
(*
** For writing ATS code
** that translates into Python3
*)
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_ML_"
#define
ATS_STATIC_PREFIX "_ats2pypre_ML_option0_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../../basics_py.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/ML/option0.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/ML/option0.dats"
//
(* ****** ****** *)

(* end of [option0.dats] *)
