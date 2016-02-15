(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"libats/ML/SATS/basis.sats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./atexting.sats"

(* ****** ****** *)
//
implement
tokenlst_topeval
  (out, xs) =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) =>
  (
    token_topeval(out, x); tokenlst_topeval(out, xs)
  ) (* end of [list0_cons] *)
)
//
(* ****** ****** *)
//
implement
atextlst_topeval
  (out, xs) =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) =>
  (
    atext_topeval(out, x); atextlst_topeval(out, xs)
  ) (* end of [list0_cons] *)
)
//
(* ****** ****** *)

(* end of [atexting_topeval.dats] *)
