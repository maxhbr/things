include <../../lib.scad>
module v1() {
    translate([-1,-10,0])
        cube([2,10,14.5]);
    translate([-1,-10,0])
        cube([2,10,14.5]);

    translate([-1.5,0,0])
        cube([2.8,15,10.7]);

    translate([-4.5,0,0])
        cube([9,2,10.7]);
    translate([-4.5,5.5+2,0])
        cube([9,2,10.7]);
}

module v2(e=0) {
    hull() {
        translate([-0.5,-10,0])
            cube([1,10,13.5]);
        translate([-0.5,-9.5,0])
            cube([1,9,14.5]);
        translate([-1,-9,0])
            cube([2,8.5,13.5]);
    }
    translate([-1,-3,0])
        cube([2,4,10.7]);

    hull() {
        translate([-0.9,0,0])
            cube([1.8,14,10.7]);
        translate([-0.9,0,0])
            cube([1.8,15,9.7]);
        translate([-1.4+e/2,0,0])
            cube([2.8 -e,14,9.7]);
    }

    for(t=[0,5.5+2+e]) {
        translate([0,t,0])
            hull() {
                translate([-4,0,0])
                    cube([8,2,9.7]);
                translate([-4,0.5,0])
                    cube([8,1,10.7]);
                translate([-4.5,0.5,0])
                    cube([9,1,9.7]);
            }
    }
}

v2();
translate([8,4,0]) v2(e=0.1);
translate([16,0,0]) v2(e=0.2);
translate([24,4,0]) v2(e=0.3);
