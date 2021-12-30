include <../lib.scad>

module servo360(t=[0,0,0],r=[0,0,0]) {
    translate(t + [0,10,0]) rotate(r) {
        translate([0,0,1]){
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
    }
}

width=60;

module servoMount() {
    translate([0,-29,7])
        cube([20,20,6], center=true);
    difference() {
        translate([0,-15,0])
            cube([width,8,20],center=true);
        translate([0,-15,0])
            cube([20,8+1,8],center=true);
    }
    translate([0,35,0])
        cube([width,8,20],center=true);
    translate([0,49,7])
        cube([20,20,6], center=true);
}

module batteryMount() {
    difference() {
        mirrorAndKeep([1,0,0]) {
            translate([17,10,12])
                cube([10,58,5],center=true);
            hull() {
                translate([17,10,12])
                    cube([5,58,5],center=true);
                translate([17,10,40])
                    cube([5,58,5],center=true);
            }
        }
        translate([0,0,40])
            rotate([90,0,90])
            roundCube([127,60,30], r=7, inner=true);
    }
}

module mcuMount() {
    mirrorAndKeep([1,0,0])
        mirrorAndKeep([0,1,0])
        translate([-55/2,-83/2,-9])
            difference() {
                cylinder(d=10,h=6, center=true,$fn=8);
                translate([0,0,-2])
                    cylinder(d=5,h=6);
            }
    mirrorAndKeep([1,0,0])
        hull() {
            mirrorAndKeep([0,1,0])
                translate([-55/2,-83/2,-9-3])
                cylinder(d=10,h=3, center=true,$fn=8);
            translate([-17,10,-40])
                cube([5,57,5],center=true);
        }
}

part("chassis.stl") {
    translate([0,0,80])
        mcuMount();
    batteryMount();
    servoMount();
}



noPart("gray") {
    rotate([0,0,90])
    translate([-83/2,-55/2,80])
        import("B-L4S5I-IOT01A.stl");
    translate([0,0,40])
        rotate([90,0,90])
        roundCube([125,58,28], r=7, inner=true);
    mirrorAndKeep([1,0,0])
        servo360(r=[0,90,0], t=[width/2,0,0]);
}
