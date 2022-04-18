
screws = [[0+0,0,0], [-110.49,15.287,0], [-17.145,92.202,0], [-127.635,90.297,0]];

module contour() {
    translate([-213.35,144.3,0])
        import("./assets/redox_rev1_contour.stl");
}

module case(right=false, trrs=true) {
    intersection() {
        translate([57.25,32.25,1])
            color("red")
            import(file="assets/Neodox_rev1.0-Top-Left_0.12.stl");
        minkowski() {
            contour();
            cylinder(d=1,h=4);
        }
    }
    intersection() {
        translate([57.25,32.25,0])
            color("red")
            import(file="assets/Neodox_rev1.0-Top-Left_0.12.stl");
        for (screw=screws) {
            translate(screw) cylinder(d=6, h=10, center=true, $fn=100);
        }
    }
    difference() {
        union() {
            minkowski() {
                contour();
                union() {
                    cylinder(d1=5,d2=2,h=4);
                    addH=4;
                    translate([0,0,-addH]) cylinder(d=5,h=addH);
                }
            }
        }
        minkowski() {
            contour();
            union() {
                cylinder(d=1,h=4);
                translate([0,0,-6]) cylinder(d=1,h=6);
            }
        }
        translate([-62.25, 78.2,-3]) {
            translate(right==false ? [0,27,0] : [0,27,-0.5])
                hull() {
                    translate([-2.5,0,0]) rotate([90,0,0]) cylinder(d=7.5, h=10);
                    translate([2.5,0,0]) rotate([90,0,0]) cylinder(d=7.5, h=10);
                    translate([-2.5,0,-6]) rotate([90,0,0]) cylinder(d=7.5, h=10);
                    translate([2.5,0,-6]) rotate([90,0,0]) cylinder(d=7.5, h=10);
                }
        }
            color("blue")
            translate(screws[2] + [0,-4.81,0] + (right==true ? [9,0,0] : [14,0,0])) {
                hull() {
                    translate([0,0,-1.5-3]) cube([5,17.26,3], center=true);
                    translate([0,-1,-1.5-3]) cube([7,16.26,3], center=true);
                    translate([0,-1,-0.5-3]) cube([9,15.26,3], center=true);
                }
                if(trrs) {
                    hull() {
                        for(t=[[0,6.5,-5.3/2],[0,6.5,-5.3/2-6]]) {
                            translate(t) rotate([270,0,0]) cylinder(d=8.8,h=10);
                        }
                    }
                }
            }
    }
}
case();

