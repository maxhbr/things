include <../../lib.scad>

highRes=false;
justOnePart="";

eps=0.5;
2eps=2*eps;
wall=1.5;
2wall=2*wall;
cardH=91.2;
cardW=66.9;


module cards(d=10,text=undef, textLine2=undef) {
    stackH=cardH+eps*3;
    stackW=cardW+2eps*2;
    stackD=d+2eps*1.8;
    boxW=60;
    difference() {
        intersection() {
            cube([stackD+2wall, stackH+2wall, boxW]);
            translate([-eps,-90,-270])
                rotate([0,90,0])
                cylinder(d=700, h=stackH+2wall+2eps);
        }
        union() {
            translate([wall,wall,wall])
                cube([stackD, stackH, stackW]);

            translate([wall,stackH+wall,26])
                rotate([45,0,0])
                cube([stackD,20,20]);
            translate([wall,wall,boxW-wall+0.7])
                rotate([45,0,0])
                cube([stackD,2,2]);


            color("lightgray")
                hull(){
                    translate([(stackD+2wall)/2+2,(stackH+2wall)/2,wall - 0.3])
                        rotate([0,0,270])
                        linear_extrude(0.31)
                        text(text,
                                font = "Roboto Condensed:style=Bold",
                                size = 6,
                                halign = "center",
                                valign = "center");
                    translate([(stackD+2wall)/2-3.5,(stackH+2wall)/2,wall - 0.3])
                        rotate([0,0,270])
                        linear_extrude(0.31)
                        text(textLine2,
                                font = "Roboto Condensed:style=Bold",
                                size = 5,
                                halign = "center",
                                valign = "center");
                }
            color("gray") {
                translate([(stackD+2wall)/2+2,(stackH+2wall)/2,wall - 0.6])
                    rotate([0,0,270])
                    linear_extrude(0.61)
                    text(text,
                            font = "Roboto Condensed:style=Bold",
                            size = 5,
                            halign = "center",
                            valign = "center");
                translate([(stackD+2wall)/2-3.5,(stackH+2wall)/2,wall - 0.6])
                    rotate([0,0,270])
                    linear_extrude(0.61)
                    text(textLine2,
                            font = "Roboto Condensed:style=Bold",
                            size = 4,
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
     , ["STATE & SOLSTICE", 2.5,5, undef]

     , ["CARTHAGIANS", 8.6, 23, "1CAR" ]
     , ["CELTS",       10.4, 28, "1CEL" ]
     , ["GREEKS",      8.6, 23, "1GRE" ]
     , ["MACEDONIANS", 8.6, 23, "1MAC" ]
     , ["PERSIANS",    8.6, 23, "1PER" ]
     , ["ROMANS",      8.6, 23, "1ROM" ]
     , ["SCYTHIANS",   9, 24, "1SCY" ]
     , ["VIKINGS",     9.7, 26, "1VIK" ]
     ];

module cardsFromRow(row) {
    cards(d=row[1]*2, text=row[0], textLine2=row[3]) {
        children();
    }
}


module legendCards(s=[0,0,0], r=[0,0,0]) {
    part("imperium_legends_decks.stl", s=s, r=r) {
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
}

module commonCards(s=[0,0,0], r=[0,0,0]) {
    part("imperium_common.stl", s=s, r=r)
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
}

module classicCards(s=[0,0,0], r=[0,0,0]) {
    part("imperium_classic_decks.stl", s=s, r=r) {
        cardsFromRow(row=data[idx]) {
            idx=15; cardsFromRow(row=data[idx]) {
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
}

module commonCardsSlim(s=[0,0,0], r=[0,0,0]) {
    part("imperium_common_slim.stl", s=s, r=r)
        cardsFromRow(row=["CIV,REG,TRI,UNC,FAM", 25, 0, "15,14,11,22,9"]) {
                cardsFromRow(row=["STA,SOL,UNR", 6,5, "4,1,12"]) {
            }
        }
}

/* WIP */
module tray(s=[0,0,0], r=[0,0,0]) {
    part("imperium_tray.stl", s=s, r=r) {
        translate([2,2,2]) {
            difference() {
                hull(){
                    translate([0,2,0])
                        cube([40-4,70-4-4,2], center=true);
                    translate([0,0,21])
                        cube([40,70-4,2], center=true);
                }
                translate([0,0,2])
                hull(){
                    translate([0,2,0])
                        cube([40-4-3,70-4-4-3,2], center=true);
                    translate([0,0,21])
                        cube([40-3,70-4-3,2], center=true);
                }
            }
        }
    }
}

$fa = 1;
$fs = 0.4;

legendCards();
commonCardsSlim(s=[0,96.5+70,0], r=[0,0,-90]);
classicCards(s=[0,167,0]);


noPart() {
    color("red")
    translate([0,0,-1.25])
        difference() {
            translate([-1,-1,1])
                cube([173+2,263+2,0.5]); 
            cube([173,263,2]); 
        };

    /*
    # translate([131,138.5,0]) import("./thing:4911762/Imperium_token_holder_ACTIONS.stl", convexity=3);
    # translate([131 + 9,138.5 -7,30]) import("./thing:4911762/Imperium_token_holder_RESOURCES.stl", convexity=3);
    */

    # translate([81,107,83]) rotate([90,0,0]) import("./thing:4911762/Imperium_divider_UNREST.stl");
    # translate([81,115,83]) rotate([90,0,0]) import("./thing:4911762/Imperium_divider_CIVILIZED.stl");
    # translate([81,125,83]) rotate([90,0,0]) import("./thing:4911762/Imperium_divider_REGIONS.stl");
    # translate([81,135,83]) rotate([90,0,0]) import("./thing:4911762/Imperium_divider_TRIBUTARY.stl");
    # translate([81,145,83]) rotate([90,0,0]) import("./thing:4911762/Imperium_divider_UNCIVILIZED.stl");
    # translate([81,155,83]) rotate([90,0,0]) import("./thing:4911762/Imperium_divider_FAME.stl");

}
