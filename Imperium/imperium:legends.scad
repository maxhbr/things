
highRes=false;
justOnePart="";

module part(partName, shift=[0,0,0]){
    if (justOnePart == ""){
        translate(shift){
            children();
        }
    } else if (justOnePart == partName) {
        $fa = 1;
        $fs = 0.4;
        children();
    }
}


eps=0.5;
2eps=2*eps;
wall=1.5;
2wall=2*wall;
cardH=91.2;
cardW=66.9;


module cards(d=10,text=undef) {
    stackH=cardH+2eps;
    stackW=cardW+2eps;
    stackD=d+2eps;
    boxW=60;
    difference() {
        intersection() {
            cube([stackD+2wall, stackH+2wall, boxW]);
            translate([-eps,-100,-270])
                rotate([0,90,0])
                cylinder(d=700, h=stackH+2wall+2eps);
        }
        union() {
            translate([wall,wall,wall])
                cube([stackD, stackH, stackW]);


            translate([wall,stackH+wall,20.4])
                rotate([45,0,0])
                cube([stackD,2,2]);
            translate([wall,wall,boxW-wall+0.7])
                rotate([45,0,0])
                cube([stackD,2,2]);


            color("gray") {
                translate([(stackD+2wall)/2,(stackH+2wall)/2,wall - 0.6])
                    rotate([0,0,270])
                    linear_extrude(0.61)
                    text(text,
                            font = "Roboto Condensed:style=Bold",
                            size = 5,
                            halign = "center",
                            valign = "center");
                translate([(stackD+2wall)/2,0.6,(boxW)/2])
                    rotate([0,90,270])
                    linear_extrude(0.61)
                    text(text,
                            font = "Roboto Condensed:style=Bold",
                            size = 5,
                            halign = "center",
                            valign = "center");
            }
        }
    }
    translate([stackD+wall,0,0])
        children();
}


/*
Comment
*/
data=[ ["ARTHURIANS",11,29,"2ART"]
     , ["ATLANTEANS",8.2,22,"2ALT"]
     , ["EGYPTIANS", 8.6,23,"2EGY"]
     , ["MAURYANS", 9,24,"2MAU"]
     , ["MINOANS", 8.8,23,"2MIN"]
     , ["OLMECS", 9.7,26,"2OLM"]
     , ["QIN", 9.2, 25, "2QIN"]
     , ["UTOPIANS", 7.7, 21, "2UTO"]
     , ["UNCIVILISED", 8.2, 22, "2UNC"]
     , ["TRIBUTARY", 4.1, 11, "2TRI"]
     , ["REGION", 5.2, 14, "2REG"]
     , ["CIVILISED",5.5, 15, "2CIV"]
     , ["UNREST", 4.4, 12, "2UNR"]
     , ["FAME", 3.3, 9, "2FAM"]
     , ["STATE & SOLSTICE", 2,5, undef]
     ];

module cardsFromRow(row) {
    cards(d=row[1]*2, text=row[0]) {
        children();
    }
}


part("imperium_legends_decks.stl") {
    cardsFromRow(row=data[idx]) {
        idx=0; cardsFromRow(row=data[idx]) {
            idx=idx+1; cardsFromRow(row=data[idx]) {
                idx=idx+1; cardsFromRow(row=data[idx]) {
                    idx=idx+1; cardsFromRow(row=data[idx]) {
                        idx=idx+1; cardsFromRow(row=data[idx]) {
                            idx=idx+1; cardsFromRow(row=data[idx]) {
                                idx=idx+1; cardsFromRow(row=data[idx]) {
                                    idx=idx+1;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

part("imperium_legends_misc.stl", shift=[0,165,0])
    cardsFromRow(row=data[idx]) {
        idx=8; cardsFromRow(row=data[idx]) {
            idx=idx+1; cardsFromRow(row=data[idx]) {
                idx=idx+1; cardsFromRow(row=data[idx]) {
                    idx=idx+1; cardsFromRow(row=data[idx]) {
                        idx=idx+1; cardsFromRow(row=data[idx]) {
                            idx=idx+1; cardsFromRow(row=data[idx]) {
                                idx=idx+1;
                            }
                        }
                    }
                }
            }
        }
    }

part("...") {
    translate([-wall,-wall,-wall])
        difference() {
            translate([-1,-1,1])
                cube([173+2,263+2,0.5]); 
            cube([173,263,2]); 
        }
}
