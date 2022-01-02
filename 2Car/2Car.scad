include <../lib.scad>

/* justOnePart="front.stl"; */

module servo360(t=[0,0,0],r=[0,0,0]) {
    translate(t) rotate(r) {
        translate([0,10,-30])
        rotate([0,180,0])
        import("Parallax-900-00360-Feedback-360-High-Speed-Servo.stl");
        /* translate([0,10,1]){ */
        /*     translate([-10,-20,-1]) */
        /*         cube([20,40,37.2-28.5]); */
        /*     difference() { */
        /*         cube([20,54.5,2], center=true); */

        /*         mirrorAndKeep([0,1,0]) */
        /*             mirrorAndKeep([1,0,0]) */
        /*             translate([5,-49.5/2,0]) */
        /*             cylinder(d=6,h=3,center=true); */
        /*     } */
        /*     translate([-10,-20,-28.5-1]) */
        /*         cube([20,40,28.5]); */
        /*     translate([0,-10,7.5]) { */
        /*         cylinder(d=4, h=5); */
        /*         cylinder(d=12, h=1); */
        /*     } */
        /* } */

        translate([0,0,12])
            difference() {
                cylinder(d=90,h=4);
                translate([0,0,-0.5])
                cylinder(d=80,h=6);
            }
    }
}

width=60;

module servoMount() {
    difference() {
        mirrorAndKeep([1,0,0]) {
            hull() {
                mirrorAndKeep([0,0,1])
                    translate([15,-22,0])
                    cube([15,12,10]);
                translate([15,-16,-13])
                    cube([6,6,3]);
            }
            translate([15,-10,-13])
                cube([6,4,3]);
        }
        mirrorAndKeep([1,0,0]) {
            translate([23,-15,5])
                rotate([0,90,0])
                color("green")
                cylinder(d=5,h=20, center=true);
            translate([23,-15,-5])
                rotate([0,90,0])
                color("green")
                cylinder(d=5,h=20, center=true);
        }
    }
}

module batteryCutout() {
    translate([0,0,58])
        roundCube([63.3+1,13+1,90.5+1], r=13/2, inner=true);
    translate([0,0,58+45])
        cube([47.5,9.5,50], center=true);
}

module front() {
    servoMount();
    difference() {
        translate([0,-12,62]) {
            difference() {
                cube([70,20,104], center=true); 
                translate([0,0,3]) {
                    rotate([90,0,0])
                        mirrorAndKeep([1,0,0])
                        mirrorAndKeep([0,1,0])
                        translate([-55/2,-83/2,0])
                        color("green")
                        cylinder(d=5,h=30, center=true);
                }
            }
        }
        translate([0,-12,64])
            cube([40,40,93], center=true); 
        translate([0,7,64])
            roundCube([90,40,70],r=10, inner=true); 
        mirrorAndKeep([1,0,0]) {
            translate([39,8,64])
                roundCube([30,90,70],r=10, inner=true); 
        }
        difference() {
            translate([0,-12,65])
                cube([80,40,70], center=true); 
            translate([0,-2,62])
                roundCube([70,40,104], r=8, inner=true); 
        }
        batteryCutout();
    }
    translate([0,-35,65])
        rotate([90,0,0]) {
                    noPart("gray"){
                        rotate([0,0,90])
                            translate([-83/2,-55/2,0])
                            import("B-L4S5I-IOT01A.stl");
                    }
        }
    noPart("gray") {
        translate([0,0,58])
            roundCube([63.3,13,90.5], r=13/2, inner=true);
    }
}

module back() {
    difference() {
        union() {
            translate([0,20,0])
                mirror([0,1,0])
                servoMount();
            translate([0,34,12.5])
                cube([30,16,5], center=true);
            mirrorAndKeep([1,0,0]) {
                hull() {
                    translate([30,10,20])
                        cube([10,15,20], center=true);
                    translate([22.5,29.75,12.5])
                        cube([15,24.5,5], center=true);
                }
            }
        }
        batteryCutout();
    }
}

part("front.stl") {
    front();
}

part("back.stl") {
    back();
}


noPart("gray") {
    mirrorAndKeep([1,0,0])
        servo360(r=[0,90,0], t=[width/2,0,0]);
}
