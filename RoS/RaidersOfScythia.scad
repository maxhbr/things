include <../lib.scad>

wall=1.5;
eps=0.1;

cardB=58.5;
cardH=89;

/* module roundCube(dimensions, r=1, fn=0) { */
/*     if (r==0) { */
/*         cube(dimensions, center=true); */
/*     } else { */
/*         x=dimensions[0]; */
/*         y=dimensions[1]; */
/*         z=dimensions[2]; */
/*         hull() */
/*             for (xyz=[[1,1,1],[1,1,-1],[1,-1,1],[1,-1,-1],[-1,1,1],[-1,1,-1],[-1,-1,1],[-1,-1,-1]]){ */
/*                 translate([xyz[0]*x/2, xyz[1]*y/2, xyz[2]*z/2]) */
/*                     sphere(r=r, $fn=fn); */
/*             } */
/*     } */
/* } */

module deck(h, plus=0) {
    difference() {
        translate([0,3.5/2,0])
            cube([ceil(cardB+2*wall)+2,ceil(cardH+2*wall) + 3.5,h+2*wall+plus + 2], center=true);
        union() {
            translate([0,5/2,0])
                roundCube([cardB,cardH + 5,h]);
            hull() {
                translate([0,50,0])
                    cube([cardB,4,h],center=true);
                translate([0,50+3,0])
                    cube([cardB+6,2,h+6],center=true);
            }

            translate([0,50,0])
                hull() {
                    roundCube([0,10,max(h+5,0)],r=10);
                }
        }
    }
}

module crewDeck() {
    deck(36);
}
module otherDecks() {

    translate([0,0,-10])
        deck(16);
    translate([0,0,4])
        deck(4);
    translate([0,0,14])
        deck(7, plus=1);
}

module cap() {
    hull() {
        children();
        translate([1,-2,1]) children();
        translate([-1,-2,1]) children();
        translate([-1,-2,-1]) children();
        translate([1,-2,-1]) children();
    }
}

module deckBoxTray() {
    difference() {
        translate([58,0,0])
            cube([218,64,45],center=true);
        union() {
            hull() {
                translate([-3.5/2,31,0])
                    roundCube([95.5,0,41], r=0.5);
                translate([-3.5/2,-31,0])
                    roundCube([95.5,0,41], r=0.5);
            }
            cap()
                translate([-3.5/2,-31,0])
                roundCube([95.5,0,41], r=0.5);
            hull() {
                translate([-3.5/2+98,31,0])
                    roundCube([95.5,0,41], r=0.5);
                translate([-3.5/2+98,-31,0])
                    roundCube([95.5,0,41], r=0.5);
            }
            cap()
                translate([-3.5/2+98,-31,0])
                roundCube([95.5,0,41], r=0.5);
            hull() {
                translate([98+58,31,0])
                    roundCube([18,0,41], r=0.5);
                translate([98+58,-31,0])
                    roundCube([18,0,41], r=0.5);
            }
            cap()
                translate([98+58,-31,0])
                roundCube([18,0,41], r=0.5);
        }
    }
}

module 7quests() {
    roundCube([40,40,14.5]);
    translate([15,0,0])
        roundCube([10,40,20]);
    translate([20,0,])
        cube([15,15,20],center=true);
}

module allquests() {
    for (xy=[[1,1],[1,-1]]){
        translate([xy[0]*22,xy[1]*22,0])
            7quests();
    }
    mirror(v= [1,0,0] )
        for (xy=[[1,1],[1,-1]]){
            translate([xy[0]*22,xy[1]*22,0])
                7quests();
        }
}

module questTray() {
    rotate([0,0,180]) {
    translate([0,-5,0]) {
        difference() {
            cube([90,90,16], center=true); 
            translate([0,0,wall])
                union() {
                    allquests();
                    translate([0,0,10])
                        allquests();
                }
        }
        translate([0,45+5,0]) {
            difference() {
                cube([80,10,16], center=true);
                translate([0,-0.75,2 + wall]) {
                    for(x=[-29.5, -10, 10, 29.5]) {
                        translate([x,0,0]) {
                            roundCube([16,6,20], r=1);
                            translate([0,2,0])
                            roundCube([6,10,30], r=1);
                        }
                    }
                }
            }
        }
    }
    }
}

module workerTray() {
    difference() {
        cube([83,118,12], center=true);
        translate([0,0,wall])
            union() {
                translate([-27.5,-22,0])
                    roundCube([24,70,12]);
                translate([-29.5,25,0])
                    roundCube([28,16,20]);
                translate([-27.5,47,0])
                    roundCube([24,20,12]);
                roundCube([24,114,12]);
                translate([27.5,0,0])
                    roundCube([24,114,12]);
            }
    }
}

module trayTray() {
    difference() {
        translate([41,0.75,0])
            cube([218,102.5,20], center=true);
        union() {
            hull() 
                for(shift=[[-20,-40,0],[-20,50,0]]) {
                    translate(shift)
                        roundCube([90,0,16], r=0.5);
                }
            hull() 
                for(shift=[[-20,50,0]
                        ,[-19,52,1]
                        ,[-21,52,1]
                        ,[-21,52,-1]
                        ,[-19,52,-1]]) {
                    translate(shift)
                        roundCube([90,0,16], r=0.5);
                }
            hull() 
                for(shift=[[-20,-40,0],[-20,-50,0]]) {
                    translate(shift)
                        roundCube([80,0,16], r=0.5);
                }
            hull() 
                for(shift=[[-20,-50,0]
                          ,[-19,-52,1]
                          ,[-19,-52,-1]
                          ,[-21,-52,-1]
                          ,[-21,-52,1]
                    ]) {
                    translate(shift)
                        roundCube([80,0,16], r=0.5);
                }
            hull() 
                for(shift=[[88,-33,-2],[88,50,-2]]) {
                    translate(shift)
                        roundCube([118,0,12], r=0.5);
                }
            hull() 
                for(shift=[[88,50,-2]
                        ,[89,52,-1]
                        ,[89,52,-3]
                        ,[87,52,-3]
                        ,[87,52,-1]
                ]) {
                    translate(shift)
                        roundCube([118,0,12], r=0.5);
                }
        }
    }
}

part("RaidersOfScythia-1.stl") {
    translate([88,8.5,-2])
        rotate([0,0,90])
        workerTray();

    translate([-20,0,0])
        questTray();
}

part("RaidersOfScythia-2.stl") {
    color("green")
        trayTray();
}

translate([-17,-134,11]) {
    rotate([0,0,90])
        part("RaidersOfScythia-3.stl") {
            crewDeck();
        }
    translate([98,0,0])
        rotate([0,0,90])
        part("RaidersOfScythia-4.stl") {
            otherDecks();
        }
    translate([98 + 58,0,0])
        part("RaidersOfScythia-5.stl") {
            difference() {
                cube([18,64,41], center=true);
                translate([wall + 1,0,0])
                    roundCube([18, 64 - 2- 2*wall , 41 - 2- 2*wall]);
            }
        }
    part("RaidersOfScythia-6.stl") {
        color("green")
            deckBoxTray();
    }
}

part("RaidersOfScythia-7.stl") {
    color("orange")
    translate([41,-76,11]) {
        cube([218,50,45], center=true);
    }
}


/* noPart() { */
/*     color("red") */
/*         translate([41,-57,12]) */
/*         difference() { */
/*             cube([218,218,44],center=true); */
/*             roundCube([216.2,216.2,43.2],fn=8); */
/*         } */
/* } */

