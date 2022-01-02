include <../../lib.scad>

width=60;

/* isStlExport=true; */
/* justOnePart="top.stl"; */
/* justOnePart="bottom.stl"; */

module servo360(t=[0,0,0],r=[0,0,0]) {
    translate(t) rotate(r) {
        if (isStlExport) {
            translate([0,10,1]){
                translate([-10,-20,-1])
                    cube([20,40,37.2-28.5]);
                difference() {
                    cube([20,54.5,2], center=true);

                    mirrorAndKeep([0,1,0])
                        mirrorAndKeep([1,0,0])
                        translate([5,-49.5/2,0])
                        cylinder(d=6,h=3,center=true);
                }
                translate([-10,-20,-28.5-1])
                    cube([20,40,28.5]);
                translate([0,-10,7.5]) {
                    cylinder(d=4, h=5);
                    cylinder(d=12, h=1);
                }
            }
        }else {
            translate([0,10,-30])
                rotate([0,180,0])
                import("assets/Parallax-900-00360-Feedback-360-High-Speed-Servo.stl");
        }

        translate([0,0,12])
            difference() {
                cylinder(d=70,h=4);
                translate([0,0,-0.5])
                cylinder(d=60,h=6);
            }
    }
}

module mcu() {
    if (! isStlExport) {
        rotate([90,0,0])
            rotate([0,0,90])
            translate([-83/2,-55/2,0])
            import("assets/B-L4S5I-IOT01A.stl");
    }
}

module battery() {
    roundCube([63.3,13,90.5], r=13/2, inner=true);
}

module batteryCutout() {
    roundCube([63.3+1,13+0.7,90.5+1], r=13/2, inner=true, fn=20);
    /* cylinder(d=7, h=5, center=true); */
    translate([0,0,45])
        cube([47.5,9.5,50], center=true);
}

module top1() {
    holeDepth=20;
    mirrorAndKeep([1,0,0]){ 
        difference() {
            hull() {
                translate([width/2-5,-5,-7])
                    cube([10,10,1], center=true);
                translate([55/2,-8,0])
                    rotate([90,0,0])
                    cylinder(d=10, h=8, center=true, $fn=6);
            }
            translate([55/2 ,-12+ holeDepth,-0.4])
                rotate([90,0,0])
                color("red")
                cylinder(d=4, h=holeDepth + 0.1, $fn=16);
        }
        difference() {
            hull() {
                translate([55/2,-8,82.5])
                    rotate([90,0,0])
                    cylinder(d=10, h=8, center=true, $fn=6);
                translate([22,2,63])
                    rotate([0,30,0])
                    cube([10,1,10],center=true);
            }
            translate([55/2 ,-12+ holeDepth,82.5])
                rotate([90,0,0])
                color("red")
                cylinder(d=4, h=holeDepth + 0.1, $fn=16);
        }
        translate([19,0.5,29.5])
            cube([2,3,69],center=true);
    }
    translate([0,-13,41]) {
        noPart("gray")
            mcu();
    }
}

module top2() {
    mirrorAndKeep([1,0,0]){ 
        hull() {
            translate([18,1,0])
                cube([4,3,30],center=true);
            translate([0,-4,25])
                cube([2,2,10],center=true);
        }
        hull() {
            translate([19,2,-4])
                cube([2,1,30],center=true);
            translate([18,1,0])
                cube([4,3,30],center=true);

        }
    }
}

module top0() {
    batteryPosition = [0,10,50];
    noPart("gray")
        translate(batteryPosition)
        battery();
    difference() {
        union() {
            translate([0,5,0]) 
                cube([width, 10, 10], center=true);
            mirrorAndKeep([1,0,0]){
                hull() {
                    translate([(width - 15) / 2,-5,0]) 
                        cube([15, 10, 10], center=true);
                    translate([12,-15,-2.5]) 
                        cube([5, 5, 5], center=true);
                }
                translate([14 / 2,-15,-2.5]) 
                    cube([14, 5, 5], center=true);
            }

            translate(batteryPosition)
                difference() {
                    hull() {
                        plus=5;
                        roundCube([63.3+plus,13+plus,90.5+plus], r=13/2, inner=true, fn=8);
                        translate([0,0,-50])
                            cube([40,10,10], center=true);
                    }
                    translate([0,0,80])
                        cube([100,100,100], center=true);
                    hull() {
                        translate([0,0,-29])
                            rotate([90,0,0])
                            cylinder(d=30, h=40, $fn=4);
                        translate([0,0,+30])
                            rotate([90,0,0])
                            cylinder(d=30, h=40, $fn=4);
                    }
                    rotate([0,0,180])
                    hull() {
                        translate([0,0,-25])
                            rotate([90,-360/5/4,0])
                            cylinder(d=50, h=40, $fn=5);
                        translate([0,0,+30])
                            rotate([90,0,0])
                            cylinder(d=30, h=40, $fn=4);
                    }
                    /* translate([0,5,-50]) */
                    /*     cube([30,10,100], center=true); */
                    translate([0,0,25])
                        rotate([90,-30,0])
                        cylinder(d=60, h=40, $fn=3);
                    translate([0,0,16])
                        rotate([0,0,180])
                        rotate([90,-30,0])
                        cylinder(d=60, h=40, $fn=3);
                }

            translate([0,0,10]) top1();
            translate([0,0,30]) top2();

        }
        translate([width/2,0,-5])
            rotate([0,45,0])
            cube([1,30,1], center=true);
        mirrorAndKeep([1,0,0]){
            mirrorAndKeep([0,1,0]){
                holeDepth=9;
                translate([width/2 - holeDepth,5,-0.6])
                    rotate([0,90,0])
                    color("red")
                    cylinder(d=4, h=holeDepth + 0.1, $fn=16);
            }
        }

        translate(batteryPosition)
            batteryCutout();
    }
}

module bottom() {
    difference() {
        union() {
            mirrorAndKeep([1,0,0]){
                hull() {
                    translate([(width - 15) / 2,5,0]) 
                        cube([15, 10, 10], center=true);
                    translate([5,11,-2.5]) 
                        cube([10, 5, 5], center=true);
                }
                hull() {
                    translate([(width - 15) / 2,-5,0]) 
                        cube([15, 10, 10], center=true);
                    translate([12,-15,-2.5]) 
                        cube([5, 5, 5], center=true);
                }
                translate([14 / 2,-15,-2.5]) 
                    cube([14, 5, 5], center=true);
            }
        }
        translate([width/2,0,-5])
            rotate([0,45,0])
            cube([1,30,1], center=true);
        mirrorAndKeep([1,0,0]){
            mirrorAndKeep([0,1,0]){
                holeDepth=9;
                translate([width/2 - holeDepth,5,-0.6])
                    rotate([0,90,0])
                    color("red")
                    cylinder(d=5.5, h=holeDepth + 0.1, $fn=16);
            }
        }
    }
}

part("top.stl", s=[0,0,35]) {
        top0();
}

part("bottom.stl", s=[0,0,-15], r=[0,180,0]) {
    bottom();
}


noPart("gray") {
    mirrorAndKeep([1,0,0])
        servo360(r=[90,0,90], t=[width/2,0,0]);
}
