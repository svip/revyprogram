(* Begået hovedsagligt af Troels Henriksen *)

open List;
load "Random";
open Random;

val personer =
    ["en nørd", "en sekretær", "rektor", "lektor",
     "Jyrki", "Pawel", "Hitler", "nogle fysikere", "en rus", "en gammel bitter datalog",
     "Stroustrup", "Peter Naur", "en KUAine"];

val steder =
    ["i studieadministrationen", "på rektors kontor", "i kantinen",
     "på KUA", "på HCØv", "på Caféen?", "i parken", "på Duniyas",
     "på Dilans", "på Oasen?", "hos Leifs", "på pigetoilettet"];

val emner =
    ["SML", "SU", "fysik", "patter", "udflytningen", "C", "dårlig kode",
     "\"kvinder\"", "humor"];

val pointer =
    ["ordspil", "politik", "ordspil", "bitterhed", "ordspil", "kjolemænd",
     "ordspil", "social akavethed", "ordspil", "urimelighed", "ordspil", "fagfascisme",
     "ordspil", "Windowshad"];

fun vaelgEn l r = nth(l, range (0, length l) r);
fun vaelg l 0 r = ([], l)
  | vaelg l n r =
    let val elem = vaelgEn l r
        val (flere, tabt) = vaelg (filter (fn x => elem <> x) l) (n-1) r
    in (elem :: flere, tabt) end;

fun kommaer []      = ""
  | kommaer [x]     = x
  | kommaer [x,y]   = x ^ " og " ^ y
  | kommaer (x::xs) = x ^ ", " ^ kommaer xs;

fun sketch () = let val r = newgen ()
                    val (helte, restp)   = vaelg personer (range (3,4) r) r
                    val (harmoni, reste) = vaelg emner (range (3,4) r) r
                    val (skurke, _)      = vaelg restp (range (1,2) r) r
                    val (konflikt, _)    = vaelg reste (range (1,2) r) r
                in "Vi ser " ^ (kommaer helte)
                   ^ " der mødes " ^ vaelgEn steder r
                   ^ " for at snakke om " ^ kommaer harmoni
                   ^ ", men så dukker " ^ kommaer skurke
                   ^ " op og råber om " ^ kommaer konflikt ^ ". "
                   ^ "Pointen er " ^ vaelgEn pointer r ^ "."
                   ^ vaelgEn [" Hurtigt tæppefald.", "", ""] r
                end;
