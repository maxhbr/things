include <../../lib.scad>

/* highRes=true; */
/* justOnePart="top.stl"; */
/* justOnePart="bottom.stl"; */

motorMaxWidth=42.5;
motorSeperation=85;

module rot120() {
    children();
    rotate([0,0,120]) children();
    rotate([0,0,240]) children();
}

module motorWithWheel() {
    noPart() {
        color("darkgray") {
            translate([-4,0.5,0])
                rotate([90,0,0])
                import("assets/Nema17.stl"); /* https://creativecommons.org/licenses/by/4.0/ from https://www.thingiverse.com/thing:1695823 */
            translate([0,-35,0])
                rotate([0,18,0])
                import("assets/58mm-Omni Wheel.stl");
        }
    }
}

module b18650() {
    cylinder(d=18, h=65, center=true);
}

module pack() {
    color("black")
    difference() {
        cube([77.7,40,21.20], center=true);
        translate([0,0,0.5])
            cube([77.7-2,40-2,21.20], center=true);
        translate([0,0,15.5])
            cube([77.7-2,40+1,21.20], center=true);
    }
    color("green")
    mirrorAndKeep([0,1,0]) {
        translate([0,9.5,0])
            rotate([0,90,0])
            b18650();
    }
}

module packs(dist) {
    mirrorAndKeep([1,0,0]) {
        rotate([180,0,-30])
            translate([dist,0,0])
            pack();
        /* rotate([180,0,-90]) */
        /*     translate([dist-15,45,0]) */
        /*     pack(); */
    }
}

module driver() {
    color("black") {
        difference() {
            cube([15, 20, 14]);
            translate([2,-0.5,-2])
                cube([11, 21, 14]);
        }
    }
    color("gray") {
        translate([3,2.2,14])
            cube([9,9,6]);
    }
}

module driverShield() {
    noPart() {
        translate([34.4/-2, 41.8/-2, 1.6/-2]) {
            color("red") {
                translate([0,0,-1.6])
                    difference() {
                        cube([34.4, 41.8, 1.6]);
                        translate([3.5,4.5,0])
                            cylinder(d=3, h=4, center=true);
                        translate([3.5,41.8-4.5,0])
                            cylinder(d=3, h=4, center=true);
                    }
            }
            color("white") {
                translate([34.4-7, 41.8-13, 0])
                    cube([7,12.5,5.5]);
            }
            translate([0,0,-0.1])
                translate([12.6,7.26,0]) {
                    driver();
                }
            color("black") {
                translate([30,3.4,0])
                cube([2.5,10.5,8.8]);
            }
        }
    }
}

module customShield() {
    noPart() {
        color("green")
            difference() {
                cube([70,50,1.6], center=true);
                mirrorAndKeep([0,1,0])
                    mirrorAndKeep([1,0,0])
                    translate([70/2-2,50/2-2,0]) cylinder(d=2, h=2, center=true);
                translate([0,-38,0])
                    cylinder(d=67, h=10, center=true, $fn=6);
            }
        translate([0,4,0]) {
            translate([-11,0,0])
                rotate([0,0,90]) {
                    driver();
                    color("black") {
                        translate([16,3.4,0])
                            cube([2.5,10.5,8.8]);
                    }
                }
            translate([10,0,0])
                rotate([0,0,90]) {
                    driver();
                    color("black") {
                        translate([16,3.4,0])
                            cube([2.5,10.5,8.8]);
                    }
                }
            translate([31,0,0])
                rotate([0,0,90]) {
                    driver();
                    color("black") {
                        translate([16,3.4,0])
                            cube([2.5,10.5,8.8]);
                    }
                }
        }
    }
}

module composeElectronics() {
    rot120()
        translate([0,-motorSeperation-2,0])
        motorWithWheel();

    translate([0,0,-14])
        packs(53);

    /* translate([0,0,3]) { */
    /*     rotate([0,0,30]) */
    /*         translate([-60,0,0]) */
    /*         driverShield(); */
    /*     rotate([0,0,150]) */
    /*         translate([-60,0,0]) */
    /*         driverShield(); */
    /*     rotate([0,0,90]) */
    /*         translate([-9,0,0]) */
    /*         driverShield(); */
    /* } */
    /* translate([0,-8,16]) */
    /*     color("green") */
    /*     difference() { */
    /*         cube([60,40,1.6], center=true); */
    /*         mirrorAndKeep([0,1,0]) */
    /*             mirrorAndKeep([1,0,0]) */
    /*             translate([28,18,0]) cylinder(d=2, h=2, center=true); */
    /*     } */

    translate([0,-19,4])
        customShield();
}

/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */

module mountBar(d) {
    translate([-24,-motorSeperation-d/2,-6])
        color("blue")
        cube([d,d,30], center=true);
}
module topBar(d) {
    translate([0,-motorSeperation-d/2,24])
        color("blue")
        cube([20,d,d], center=true);
}

module motorMountPlate(d) {
    screwDist=31;
    difference() {
        hull() {
            mirrorAndKeep([1,0,0])
                mountBar(d=d);
            topBar(d=d);
            translate([0,-motorSeperation-d/2,0]) {
                intersection() {
                    mirrorAndKeep([0,0,1]) {
                        mirrorAndKeep([1,0,0]) {
                            translate([0,-d/2,0])
                                cube([motorMaxWidth/2,d,motorMaxWidth/2]);
                        }
                    }
                    rotate([90,0,0])
                        cylinder(d=56, h=d*2, center=true);
                }
            }
        }
        translate([0,-motorSeperation-d/2,0]) {
            mirrorAndKeep([0,0,1]) {
                mirrorAndKeep([1,0,0]) {
                    translate([screwDist/2,0,screwDist/2])
                        rotate([90,0,0])
                        cylinder(d=4, h=d*2, center=true);
                    translate([screwDist/2,-d/2,screwDist/2])
                        rotate([90,0,0])
                        cylinder(d1=8, d2=12, h=3, center=true);
                }
            }
            rotate([90,0,0])
                cylinder(d=25, h=d*2, center=true);
            translate([0,d/2,0])
                rotate([90,0,0])
                cylinder(d1=36, d2=30, h=4, center=true);
        }
    }
}


module bottomPlate() {
    d=4;

    mirrorAndKeep([1,0,0])
        rotate([0,0,30])
        translate([-54,0,-1.5])
        cube([80,46,d], center=true);
    color("DodgerBlue")
        difference() {
            rot120()
                hull() {
                    mirrorAndKeep([1,0,0])
                        rotate([0,0,30])
                        translate([-19,0,-1.5])
                        cube([10,46,d], center=true);
                }
            translate([0,13,0])
                cylinder(d=10,h=10,center=true);
        }


    color("RoyalBlue")
        mirrorAndKeep([1,0,0]){
            mirrorAndKeep([0,1,0],r=[0,0,60]){
                hull() {
                    rotate([0,0,30])
                        translate([-92,-22,-11.5])
                        cube([4,2,20+d], center=true);
                    mountBar(d);
                }
                hull() {
                    rotate([0,0,30])
                        translate([-50,-22,-11.5])
                        cube([4,2,20+d], center=true);
                    mountBar(d);
                }
                hull() {
                    rotate([0,0,30])
                        translate([-92,-22,-11.5])
                        cube([4,2,20+d], center=true);
                    rotate([0,0,30])
                        translate([-23,-22,-11.5])
                        cube([4,2,20+d], center=true);
                }
                rotate([0,0,30])
                    translate([-93,0,-11.5])
                    cube([2,46,20+d], center=true);
            }
            rotate([0,0,240]) {
                hull() {
                    rotate([0,0,30])
                        translate([-50,-22,-11.5])
                        cube([4,2,20+d], center=true);
                    mountBar(d);
                }
                hull() {
                    rotate([0,0,30])
                        translate([-50,-22,-11.5])
                        cube([4,2,20+d], center=true);
                    rotate([0,0,30])
                        translate([-23,-22,-11.5])
                        cube([4,2,20+d], center=true);
                }
            }
        }
    hull() {
        mirrorAndKeep([1,0,0]){
            rotate([0,0,270])
                translate([-50,-22,-11.5])
                cube([4,2,20+d], center=true);
        }
    }

    color("blue") {
        rot120() {
            hull() {
                topBar(d=d);
                translate([0,50,0])
                    topBar(d=d);
            }
            hull() {
                translate([0,50,0])
                    topBar(d=d);
                hull()
                    mirrorAndKeep([1,0,0]){
                        rotate([0,0,30])
                            translate([-23,-22,-11.5])
                            cube([4,2,20+d], center=true);
                    }
            }
        }
    }

    rot120()
        motorMountPlate(d);
}


/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */
bottomPlate();


noPart() {
    translate([300,0,0]) {
        bottomPlate();

        composeElectronics();
    }
}
noPart() {
    color("red")
        translate([0,0,-61])
        difference() {
            cube([210.5,210.5,0.5], center=true);
            cube([210,210,1], center=true);
        }
}
