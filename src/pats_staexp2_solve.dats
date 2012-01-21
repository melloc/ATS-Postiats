(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: October, 2011
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload LAB = "pats_label.sats"
overload compare with $LAB.compare_label_label
staload STAMP = "pats_stamp.sats"
overload compare with $STAMP.compare_stamp_stamp

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_staexp2_error.sats"

(* ****** ****** *)

staload "pats_trans3_env.sats"

(* ****** ****** *)

staload "pats_staexp2_solve.sats"

(* ****** ****** *)

implement
label_equal_solve_err
  (loc0, l1, l2, err) =
  if compare (l1, l2) = 0 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_label_equal (loc0, l1, l2))
  in
    // nothing
  end // end of [if]
// end of [label_equal_solve_err]

implement
stamp_equal_solve_err
  (loc0, s1, s2, err) =
  if compare (s1, s2) = 0 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_stamp_equal (loc0, s1, s2))
  in
    // nothing
  end // end of [if]
// end of [stamp_equal_solve_err]

(* ****** ****** *)

implement
funclo_equal_solve_err
  (loc0, fc1, fc2, err) =
  if fc1 = fc2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_funclo_equal (loc0, fc1, fc2))
  in
    // nothing
  end // end of [if]
// end of [funclo_equal_solve_err]

(* ****** ****** *)

implement
clokind_equal_solve_err
  (loc0, knd1, knd2, err) =
  if knd1 = knd2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_clokind_equal (loc0, knd1, knd2))
  in
    // nothing
  end // end of [if]
// end of [clokind_equal_solve_err]

(* ****** ****** *)

implement
linearity_equal_solve_err
  (loc0, lin1, lin2, err) =
  if lin1 = lin2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_linearity_equal (loc0, lin1, lin2))
  in
    // nothing
  end // end of [if]
// end of [linearity_equal_solve_err]

(* ****** ****** *)

implement
pfarity_equal_solve
  (loc0, npf1, npf2) = err where {
  var err: int = 0
  val () = pfarity_equal_solve_err (loc0, npf1, npf2, err)
} // end of [pfarity_equal_solve]

implement
pfarity_equal_solve_err
  (loc0, npf1, npf2, err) =
  if npf1 = npf2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_pfarity_equal (loc0, npf1, npf2))
  in
    // nothing
  end // end of [if]
// end of [pfarity_equal_solve_err]

(* ****** ****** *)

implement
tyreckind_equal_solve_err
  (loc0, knd1, knd2, err) =
  if knd1 = knd2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_tyreckind_equal (loc0, knd1, knd2))
  in
    // nothing
  end // end of [if]
// end of [tyreckind_equal_solve_err]

(* ****** ****** *)

implement
refval_equal_solve_err
  (loc0, knd1, knd2, err) =
  if knd1 = knd2 then () else let
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_refval_equal (loc0, knd1, knd2))
  in
    // nothing
  end // end of [if]
// end of [refval_equal_solve_err]

(* ****** ****** *)

extern
fun s2Var_merge_szexp_err (
  loc: location, s2V1: s2Var, s2ze2: s2zexp, err: &int
) : void // end of [s2Var_merge_szexp_err]
implement
s2Var_merge_szexp_err
  (loc0, s2V1, s2ze2, err) = let
  val s2ze1 = s2Var_get_szexp (s2V1)
  val s2ze12 = s2zexp_merge (s2ze1, s2ze2)
  val () = if s2zexp_is_bot (s2ze12) then {
    val () = err := err + 1
    val () = the_staerrlst_add (STAERR_s2zexp_merge (loc0, s2ze1, s2ze2))
  } // end of [val]
in
  s2Var_set_szexp (s2V1, s2ze12)
end // end of [s2Var_merge_szexp_err]

(* ****** ****** *)

extern
fun s2hnf_tyleq_solve_lbs_err (
  loc0: location, lbs: s2VarBoundlst, s2f: s2hnf, err: &int
) : void // end of [s2hnf_tyleq_solve_lbs_err]
extern
fun s2hnf_tyleq_solve_ubs_err (
  loc0: location, s2f: s2hnf, ubs: s2VarBoundlst, err: &int
) : void // end of [s2hnf_tyleq_solve_ubs_err]

(* ****** ****** *)

extern
fun s2hnf_equal_solve_lVar_err (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V1: s2Var, err: &int
) : void // end of [s2hnf_equal_solve_lVar_err]
implement
s2hnf_equal_solve_lVar_err
  (loc0, s2f1, s2f2, s2V1, err) = let
  val s2e2 = s2hnf2exp (s2f2)
  val isimp = s2exp_is_impredicative (s2e2)
  val () = if isimp then {
    val s2ze2 = s2zexp_make_s2exp (s2e2)
    val () = s2Var_merge_szexp_err (loc0, s2V1, s2ze2, err)
  } // end of [val]
  val () = s2Var_set_link (s2V1, Some s2e2)
  val () = if isimp then {
    val lbs = s2Var_get_lbs (s2V1)
    val () = s2hnf_tyleq_solve_lbs_err (loc0, lbs, s2f2, err)
    val ubs = s2Var_get_ubs (s2V1)
    val () = s2hnf_tyleq_solve_ubs_err (loc0, s2f2, ubs, err)
  } // end of [val]
in
  // nothing  
end // end of [s2hnf_equal_solve_lVar_err]

extern
fun s2hnf_equal_solve_rVar_err (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V2: s2Var, err: &int
) : void // end of [s2hnf_equal_solve_rVar_err]
implement
s2hnf_equal_solve_rVar_err
  (loc0, s2f1, s2f2, s2V2, err) = let
  val s2e1 = s2hnf2exp (s2f1)
  val isimp = s2exp_is_impredicative (s2e1)
  val () = if isimp then {
    val s2ze1 = s2zexp_make_s2exp (s2e1)
    val () = s2Var_merge_szexp_err (loc0, s2V2, s2ze1, err)
  } // end of [val]
  val () = s2Var_set_link (s2V2, Some s2e1)
  val () = if isimp then {
    val lbs = s2Var_get_lbs (s2V2)
    val () = s2hnf_tyleq_solve_lbs_err (loc0, lbs, s2f1, err)
    val ubs = s2Var_get_ubs (s2V2)
    val () = s2hnf_tyleq_solve_ubs_err (loc0, s2f1, ubs, err)
  } // end of [val]
in
  // nothing
end // end of [s2hnf_equal_solve_rVar_err]

(* ****** ****** *)

extern
fun s2hnf_equal_solve
  (loc: location, s2f1: s2hnf, s2f2: s2hnf): int(*err*)
// end of [s2hnf_equal_solve]
and s2hnf_equal_solve_err
  (loc: location, s2f1: s2hnf, s2f2: s2hnf, err: &int): void
// end of [s2hnf_equal_solve_err]

extern
fun s2hnf_tyleq_solve
  (loc: location, s2f1: s2hnf, s2f2: s2hnf): int(*err*)
// end of [s2hnf_tyleq_solve]
and s2hnf_tyleq_solve_err
  (loc: location, s2f1: s2hnf, s2f2: s2hnf, err: &int): void
// end of [s2hnf_tyleq_solve]

(* ****** ****** *)

implement
s2hnf_equal_solve
  (loc0, s2f10, s2f20) = err where {
  var err: int = 0
  val () = s2hnf_equal_solve_err (loc0, s2f10, s2f20, err)
} // end of [s2hnf_equal_solve]

implement
s2exp_equal_solve
  (loc0, s2e10, s2e20) = err where {
  var err: int = 0
  val () = s2exp_equal_solve_err (loc0, s2e10, s2e20, err)
} // end of [s2exp_equal_solve]

(* ****** ****** *)

implement
s2hnf_equal_solve_err
  (loc0, s2f10, s2f20, err) = let
//
val err0 = err
val s2e10 = s2hnf2exp (s2f10)
and s2e20 = s2hnf2exp (s2f20)
val s2en10 = s2e10.s2exp_node and s2en20 = s2e20.s2exp_node
// (*
val () = (
  print "s2hnf_equal_solve_err: s2e10 = "; print_s2exp s2e10; print_newline ()
) // end of [val]
val () = (
  print "s2hnf_equal_solve_err: s2e20 = "; print_s2exp s2e20; print_newline ()
) // end of [val]
val () = (
  print "s2hnf_equal_solve_err: err0 = "; print err0; print_newline ()
) // end of [val]
// *)
val () = case+
  (s2en10, s2en20) of
//
| (S2EVar s2V1, _) => (
  case+ s2en20 of
  | S2EVar s2V2 when s2V1 = s2V2 => ()
  | _ => s2hnf_equal_solve_lVar_err (loc0, s2f10, s2f20, s2V1, err)
  ) // end of [S2EVar, _]
| (_, S2EVar s2V2) =>
    s2hnf_equal_solve_rVar_err (loc0, s2f10, s2f20, s2V2, err)
  // end of [_, S2EVar]
//
| (S2Einvar s2e11, _) => let
    val s2f11 = s2exp2hnf (s2e11) in
    s2hnf_equal_solve_err (loc0, s2f11, s2f20, err)
  end // end of [S2Einvar, _]
| (_, S2Einvar s2e21) => let
    val s2f21 = s2exp2hnf (s2e21) in
    s2hnf_equal_solve_err (loc0, s2f10, s2f21, err)
  end // end of [_, S2Einvar]
//
| (_, _) when s2hnf_syneq (s2f10, s2f20) => ()
| (_, _) => trans3_env_add_eqeq (loc0, s2e10, s2e20)
(*
| (_, _) => (err := err + 1)
*)
// end of [val]
//
val () = if err > err0 then
  the_staerrlst_add (STAERR_s2exp_equal (loc0, s2e10, s2e20))
// end of [val]
in
  // nothing
end // end of [s2hnf_equal_solve_err]

implement
s2exp_equal_solve_err
  (loc0, s2e10, s2e20, err) = let
//
val err0 = err
val s2f10 = s2exp2hnf (s2e10)
and s2f20 = s2exp2hnf (s2e20)
//
in
  s2hnf_equal_solve_err (loc0, s2f10, s2f20, err)
end // end of [s2exp_equal_solve_err]

(* ****** ****** *)

implement
s2explst_equal_solve_err
  (loc0, s2es1, s2es2, err) = let
in
//
case+ s2es1 of
| list_cons (s2e1, s2es1) => (
  case+ s2es2 of
  | list_cons (s2e2, s2es2) => let
      val () = s2exp_equal_solve_err (loc0, s2e1, s2e2, err)
    in
      s2explst_equal_solve_err (loc0, s2es1, s2es2, err)
    end // end of [list_cons]
  | list_nil () => 1
  ) // end of [list_cons]
| list_nil () => (
  case+ s2es2 of
  | list_cons _ => ~1 | list_nil () => 0
  ) // end of [list_nil]
//
end // end of [s2explst_equal_solve_err]

(* ****** ****** *)

extern
fun s2hnf_tyleq_solve_lVar_err (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V1: s2Var, err: &int
) : void // end of [s2hnf_tyleq_solve_lVar_err]
implement
s2hnf_tyleq_solve_lVar_err
  (loc0, s2f1, s2f2, s2V1, err) = let
  val s2e2 = s2hnf2exp (s2f2)
//
  val s2ze2 = s2zexp_make_s2exp (s2e2)
  val () = s2Var_merge_szexp_err (loc0, s2V1, s2ze2, err)
//
  val lbs = s2Var_get_lbs (s2V1)
  val () = s2hnf_tyleq_solve_lbs_err (loc0, lbs, s2f2, err)
//
  val ub = s2VarBound_make (loc0, s2e2)
  val ubs = s2Var_get_ubs (s2V1)
  val () = s2Var_set_ubs (s2V1, list_cons (ub, ubs))
//
in
  // nothing
end // end of [s2hnf_tyleq_solve_lVar_err]

extern
fun s2hnf_tyleq_solve_rVar_err (
  loc: location
, s2f1: s2hnf, s2f2: s2hnf, s2V2: s2Var, err: &int
) : void // end of [s2hnf_tyleq_solve_rVar_err]
implement
s2hnf_tyleq_solve_rVar_err
  (loc0, s2f1, s2f2, s2V2, err) = let
  val s2e1 = s2hnf2exp (s2f1)
//
  val s2ze1 = s2zexp_make_s2exp (s2e1)
  val () = s2Var_merge_szexp_err (loc0, s2V2, s2ze1, err)
//
  val ubs = s2Var_get_ubs (s2V2)
  val () = s2hnf_tyleq_solve_ubs_err (loc0, s2f1, ubs, err)
//
  val lb = s2VarBound_make (loc0, s2e1)
  val lbs = s2Var_get_lbs (s2V2)
  val () = s2Var_set_lbs (s2V2, list_cons (lb, lbs))
//
in
  // nothing
end // end of [s2hnf_tyleq_solve_rVar_err]

(* ****** ****** *)

implement
s2hnf_tyleq_solve
  (loc0, s2f10, s2f20) = err where {
  var err: int = 0
  val () = s2hnf_tyleq_solve_err (loc0, s2f10, s2f20, err)
} // end of [s2hnf_tyleq_solve]

implement
s2exp_tyleq_solve
  (loc0, s2e10, s2e20) = err where {
  var err: int = 0
  val () = s2exp_tyleq_solve_err (loc0, s2e10, s2e20, err)
} // end of [s2exp_tyleq_solve]

(* ****** ****** *)

implement
s2hnf_tyleq_solve_err
  (loc0, s2f10, s2f20, err) = let
//
val err0 = err
val s2e10 = s2hnf2exp (s2f10)
and s2e20 = s2hnf2exp (s2f20)
val s2en10 = s2e10.s2exp_node and s2en20 = s2e20.s2exp_node
// (*
val () = (
  print "s2hnf_tyleq_solve_err: s2f10 = "; print_s2exp s2e10; print_newline ()
) // end of [val]
val () = (
  print "s2hnf_tyleq_solve_err: s2f20 = "; print_s2exp s2e20; print_newline ()
) // end of [val]
val () = (
  print "s2hnf_tyleq_solve_err: err0 = "; print err0; print_newline ()
) // end of [val]
// *)
//
val () = case+
  (s2en10, s2en20) of
| (_, S2EVar s2V2) =>
    s2hnf_tyleq_solve_rVar_err (loc0, s2f10, s2f20, s2V2, err)
  // end of [_, S2EVar]
| (S2EVar s2V1, _) =>
    s2hnf_tyleq_solve_lVar_err (loc0, s2f10, s2f20, s2V1, err)
  // end of [S2EVar, _]
//
| (S2Einvar s2e11, _) => let
    val s2f11 = s2exp2hnf (s2e11) in
    s2hnf_tyleq_solve_err (loc0, s2f11, s2f20, err)
  end // end of [S2Einvar, _]
| (_, S2Einvar s2e21) => let
    val s2f21 = s2exp2hnf (s2e21)
    val s2e21 = s2hnf2exp (s2f21)
  in
    case+ s2e21.s2exp_node of
    | S2EVar s2V2 =>
        s2hnf_equal_solve_rVar_err (loc0, s2f10, s2f21, s2V2, err)
    | _ => s2hnf_tyleq_solve_err (loc0, s2f10, s2f21, err)
  end // end of [_, S2Einvar]
//
| (S2Eapp (s2e1_fun, s2es1_arg), _) => (
  case+ s2en20 of
  | S2Ecst s2c2 => (
    case+ (
      s2e1_fun.s2exp_node
    ) of // [case]
    | S2Ecst s2c1 =>
        if s2cst_subeq (s2c1, s2c2) then () else (err := err + 1)
      // end of [S2Ecst]
    | _ => (err := err + 1)
    ) // end of [S2Ecst]
  | S2Eapp (s2e2_fun, s2es2_arg) => (
    case+ (
      s2e1_fun.s2exp_node
    , s2e2_fun.s2exp_node
    ) of // [case]
    | (S2Ecst s2c1, S2Ecst s2c2) => let
        val subeq = s2cst_subeq (s2c1, s2c2)
      in
        if subeq then let
          val- list_cons (argsrts, _) = s2cst_get_argsrtss (s2c1) in
          s2explst_tyleq_solve_argsrtlst_err (loc0, argsrts, s2es1_arg, s2es2_arg, err)
        end else (err := err + 1)
      end // end of [S2Ecst, S2Ecst]
    | (_, _) => let // HX: sound but incomplete!
        val () = s2exp_equal_solve_err (loc0, s2e1_fun, s2e2_fun, err)
        val errlen = s2explst_equal_solve_err (loc0, s2es1_arg, s2es2_arg, err)
      in
        // nothing
      end // end of [_, _]
    ) // end of [S2Eapp]
  | _ => (err := err + 1)
  ) // end of [S2Eapp, _]
| (S2Etyrec (knd1, npf1, ls2es1), _) => (
  case+ s2en20 of
  | S2Etyrec (knd2, npf2, ls2es2) => let
      val () =
        tyreckind_equal_solve_err (loc0, knd1, knd2, err)
      // end of [val]
      val () = pfarity_equal_solve_err (loc0, npf1, npf2, err)
    in
      labs2explst_tyleq_solve_err (loc0, ls2es1, ls2es2, err)
    end // end of [S2Etyrec]
  | _ => (err := err + 1)
  ) // end of [S2Etyrec]
| (_, _) when s2hnf_syneq (s2f10, s2f20) => ()
| (_, _) => (err := err + 1)
// end of [val]
//
val () = if err > err0 then
  the_staerrlst_add (STAERR_s2exp_tyleq (loc0, s2e10, s2e20))
// end of [val]
in
  // nothing
end // end of [s2hnf_tyleq_solve_err]

implement
s2exp_tyleq_solve_err
  (loc0, s2e10, s2e20, err) = let
  val err0 = err
  val s2f10 = s2exp2hnf (s2e10)
  and s2f20 = s2exp2hnf (s2e20)
in
  s2hnf_tyleq_solve_err (loc0, s2f10, s2f20, err)
end // end of [s2exp_tyleq_solve_err]

(* ****** ****** *)

implement
labs2explst_tyleq_solve_err
  (loc0, ls2es1, ls2es2, err) =
  case+ ls2es1 of
  | list_cons (ls2e1, ls2es1) => (
    case+ ls2es2 of
    | list_cons (ls2e2, ls2es2) => let
        val SLABELED (l1, _, s2e1) = ls2e1
        val SLABELED (l2, _, s2e2) = ls2e2
        val () = label_equal_solve_err (loc0, l1, l2, err)
        val () = s2exp_tyleq_solve_err (loc0, s2e1, s2e2, err)
      in
        labs2explst_tyleq_solve_err (loc0, ls2es1, ls2es2, err)
      end // end of [list_cons]
    | list_nil () => let
        val () = err := err + 1 in
        the_staerrlst_add (STAERR_labs2explst_length (loc0, 1))
      end // end of [list_nil]
    ) // end of [list_cons]
  | list_nil () => (
    case+ ls2es2 of
    | list_cons (ls2e2, ls2es2) => let
        val () = err := err + 1 in
        the_staerrlst_add (STAERR_labs2explst_length (loc0, ~1))
      end // end of [list_cons]
    | list_nil () => ()
    ) // end of [list_nil]
// end of [labs2explst_tyleq_solve_err]

(* ****** ****** *)

implement
s2hnf_tyleq_solve_lbs_err
  (loc0, lbs, s2f, err) = let
  macdef loop = s2hnf_tyleq_solve_lbs_err
in
  case+ lbs of
  | list_cons (lb, lbs) => let
      val s2f_lb = s2exp2hnf (s2VarBound_get_val (lb))
      val () = s2hnf_tyleq_solve_err (loc0, s2f_lb, s2f, err)
    in
      loop (loc0, lbs, s2f, err)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [s2hnf_tyleq_solve_lbs_err]

implement
s2hnf_tyleq_solve_ubs_err
  (loc0, s2f, ubs, err) = let
  macdef loop = s2hnf_tyleq_solve_ubs_err
in
  case+ ubs of
  | list_cons (ub, ubs) => let
      val s2f_ub = s2exp2hnf (s2VarBound_get_val (ub))
      val () = s2hnf_tyleq_solve_err (loc0, s2f, s2f_ub, err)
    in
      loop (loc0, s2f, ubs, err)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [s2hnf_tyleq_solve_ubs_err]

(* ****** ****** *)

implement
s2explst_tyleq_solve_argsrtlst_err
  (loc0, argsrts, s2es1, s2es2, err) = let
(*
  val () = (
    print "s2explst_tyleq_solve_argsrtlst_err: enter"; print_newline ()
  ) // end of [val]
*)
in
//
case+ s2es1 of
| list_cons (s2e1, s2es1) => (
  case+ s2es2 of
  | list_cons (s2e2, s2es2) => let
      val- list_cons
        (argsrt, argsrts) = argsrts
      // end of [val]
      val pol = s2rt_get_pol (argsrt.1)
      val () = (
        if pol = 0 then
          s2exp_equal_solve_err (loc0, s2e1, s2e2, err)
        else if pol > 0 then
          s2exp_tyleq_solve_err (loc0, s2e1, s2e2, err)
        else // pol < 0
          s2exp_tyleq_solve_err (loc0, s2e2, s2e1, err)
        // end of [if]
      ) : void // end of [val]
    in
      s2explst_tyleq_solve_argsrtlst_err (loc0, argsrts, s2es1, s2es2, err)
    end // end of [list_cons]
  | list_nil () => ()
  ) // end of [list_cons]
| list_nil () => ()
//
end // end of [s2explst_tyleq_solve_argsrtlst_err]

(* ****** ****** *)

(* end of [pats_staexp2_solve.dats] *)
