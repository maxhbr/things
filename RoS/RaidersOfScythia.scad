/* $fa = 1; */
/* $fs = 0.4; */

wall=1.5;
eps=0.1;

cardB=55;
cardH=87;


module roundCube(dimensions, r=1, fn=0) {
    if (r==0) {
        cube(dimensions, center=true);
    } else {
        x=dimensions[0];
        y=dimensions[1];
        z=dimensions[2];
        hull()
            for (xyz=[[1,1,1],[1,1,-1],[1,-1,1],[1,-1,-1],[-1,1,1],[-1,1,-1],[-1,-1,1],[-1,-1,-1]]){
                translate([xyz[0]*x/2, xyz[1]*y/2, xyz[2]*z/2])
                    sphere(r=r, $fn=fn);
            }
    }
}

module deck(h, plus=0) {
    difference() {
        translate([0,4.5/2,0])
            cube([cardB+2*wall,cardH+2*wall + 4.5,h+2*wall+plus], center=true);
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
                    roundCube([0,10,max(h-3,0)],r=10);
                }
        }
    }
}

module herosDeck() { deck(5, plus=1); }
module animalsDeck() { deck(12,plus=1); }
module aiDeck() { deck(3, plus=1); }

module decks() {
    translate([60,0,0]) {
        animalsDeck();
        translate([60,0,-3.5]) {
            herosDeck();
            translate([0,0,8])
                aiDeck();
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

translate([88,8.5,-2])
    rotate([0,0,90])
    workerTray();

translate([-20,0,0])
    questTray();

color("green")
trayTray();

translate([40.5,-59,14])
    difference() {
        cube([218,218,44],center=true);
        roundCube([216.2,216.2,43.2],fn=8);
    }

/* translate([40.5,-59,14]) */
/*     translate([300,0,0]) { */
/*         difference(){ */
/*             cube([218,218,44],center=true); */
/*             union() { */
/*                 translate([(218-202 + eps)/2,(218-100 + eps)/2,(44-28 + eps)/2]) */
/*                     cube([202,100,28],center=true); */
/*             } */
/*         } */
/*     } */
