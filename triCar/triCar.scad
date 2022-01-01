include <../lib.scad>

/* highRes=true; */
/* justOnePart="top.stl"; */
/* justOnePart="bottom.stl"; */

motorMaxWidth=42.5;
motorSeperation=75;

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

module b18650(r=[0,0,0]) {
    rotate(r)
    cylinder(d=18, h=65, center=true);
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
        }
    }
}

module motorMountPlate(d) {
    translate([0,-d/2,-motorMaxWidth/2]) {
        intersection() {
            difference() {
                    mirrorAndKeep([1,0,0]) {
                        difference() {
                            translate([0,-d/2,1])
                                cube([motorMaxWidth/2,d,motorMaxWidth/2-1]);
                            translate([31/2,0,31/2])
                                rotate([90,0,0])
                                cylinder(d=4, h=d*2, center=true);
                            translate([31/2,-d/2,31/2])
                                rotate([90,0,0])
                                cylinder(d1=8, d2=12, h=2, center=true);
                        }
                    }
                hull() {
                    rotate([90,0,0])
                        cylinder(d=6.5, h=d*2, center=true);
                    translate([0,0,-40])
                        rotate([90,0,0])
                        cylinder(d=6.5, h=d*2, center=true);
                }
                translate([0,d/2,0])
                    rotate([90,0,0])
                    cylinder(d1=36, d2=30, h=4, center=true);
            }
            rotate([90,0,0])
                cylinder(d=56, h=d*2, center=true);
        }
    }

}

module motorMountPoints(d, h) {
    translate([0,-d,0]) {
        translate([15-d + 5,60-d,h-2])
            cube([d,d,d]);
        translate([motorMaxWidth/2+5,30 + 20-d,1])
            cube([d,d,d]);
    }
}

module topMount(d, h) {
    translate([0,-motorSeperation,-h-d]) {
        motorMountPlate(d);
        translate([0,-d,0]) {
            mirrorAndKeep([1,0,0]) {
                hull() {
                    cube([10,d,d]);
                    translate([0,20,h])
                        cube([15,d,d]);
                }
                hull() {
                    translate([0,20,h])
                        cube([15,d,d]);
                    motorMountPoints(d=d, h=h);
                }
                hull() {
                    translate([motorMaxWidth/2,0,-motorMaxWidth/2 +1])
                        cube([d,d,15]);
                    translate([motorMaxWidth/2+5,30,1])
                        cube([d,20,d]);
                }
                hull() {
                    motorMountPoints(d=d, h=h);
                    translate([motorMaxWidth/2+5,30,1])
                        cube([d,d,d]);
                }
                translate([motorMaxWidth/2+5,30 + 20-d,-43])
                    cube([d,d,44]);
                hull() {
                translate([motorMaxWidth/2+5,30 + 20-d,-43])
                    cube([d,d,12]);
                    translate([motorMaxWidth/2+5 +d/2,30 + 20-d/2,-43])
                        cylinder(d=10, h=6, $fn=6);
                }
            }
        }
    }
}

module topStrut(d, h) {
    hull() {
        translate([0,-motorSeperation,-h-d])
            motorMountPoints(d=d, h=h);
        rotate([0,0,120])
            mirror([1,0,0])
            translate([0,-motorSeperation,-h-d])
            motorMountPoints(d=d, h=h);
    }
}

module top(d, h) {
    rot120() { 
        topMount(d=d, h=h);
        topStrut(d=d, h=h);
    }
}

module bottomMount(d,h) {
    translate([0,-motorSeperation,-h-d]) {
        mirror([0,0,1])
            motorMountPlate(d);
    }
    mirrorAndKeep([1,0,0]) {
        hull() {
            translate([motorMaxWidth/2,-d,5])
                translate([0,-motorSeperation,-h-d])
                cube([d,d,15]);
            rotate([0,0,60])
                mirror([1,0,0])
                translate([motorMaxWidth/2,-d,5])
                translate([0,-motorSeperation,-h-d])
                cube([d,d,15]);
        }
        hull() {
            rotate([0,0,60])
                mirror([1,0,0])
                translate([motorMaxWidth/2,-d,5])
                translate([0,-motorSeperation,-h-d])
                cube([d,d,15]);
            rotate([0,0,60])
                translate([0,-motorSeperation - d/2,-12])
                cube([34,d,4], center=true);
        }
    }
}

module bottomPlate(d,h) {
    difference() {
        union() {
            rot120()
                translate([0,-motorSeperation - d/2,-12])
                cube([34,d,4], center=true);
            mirrorAndKeep([0,1,0])
                hull()
                rot120()
                translate([0,-motorSeperation - d/2,-12.5])
                cube([34,d,3], center=true);
        }
        mirrorAndKeep([0,1,0]) {
            rot120() {
                translate([0,motorSeperation/5,0])
                    cylinder(d=motorSeperation/5,h=100, center=true, $fn=6);
                translate([0,2*motorSeperation/5,0])
                    cylinder(d=motorSeperation/5,h=100, center=true, $fn=6);
                translate([0,3*motorSeperation/5,0])
                    cylinder(d=motorSeperation/5,h=100, center=true, $fn=6);
                translate([0,4*motorSeperation/5,0])
                    cylinder(d=motorSeperation/5,h=100, center=true, $fn=6);
            }
        }
    }
}

module bottom(d,h) {
    rot120() {
        bottomMount(d=d,h=h);
        mirrorAndKeep([1,0,0])
            translate([16,-(motorSeperation - 50)+3,-6])
            cube([8,7,10], center=true);
        translate([0,-(motorSeperation - 50),10])
            rotate([180,270,90])
            driverShield();
    }
    bottomPlate(d=d,h=h);
}


translate([300,0,0]) {
    part("bottom.stl", s=[0,0,-motorMaxWidth])
        bottom(d=4, h=6);
    part("top.stl")
        top(d=4, h=6);

    /* noPart() { */
    /*     color("ghostWhite") */
    /*         translate([0,30,7]) */
    /*         roundCube([72,34,14], r=3, inner=true); */
    /* } */

    /* module mcuMount(d=4) { */
    /*     /1* tbd. *1/ */
    /* } */

    /* translate([-36,-80,15]) { */
    /*     mcuMount(); */
    /*     noPart() { */
    /*         color("ghostWhite") */
    /*             import("assets/MB1355-WB55RG-C02.stl"); */
    /*     } */
    /* } */

    rot120()
        translate([0,-motorSeperation-2,-31.25])
        motorWithWheel();


    noPart() {
        color("red")
        translate([0,0,-61])
            difference() {
                cube([210.5,210.5,0.5], center=true);
                cube([210,210,1], center=true);
            }
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
