include <../../lib.scad>

// ############################################################################
// ## lib #####################################################################
// ############################################################################

module edge(h=3) {
    linear_extrude(height = h, convexity = 10)
    translate([-2.238,-2.507])
            import (file = "./reviung41-Edge_Cuts.flattened.svg");
}

module screwHoles(h=10) {
    minkowski() {
        linear_extrude(height = h, convexity = 10)
            import (file = "./reviung41-Nutzer_1.svg");
        children();
    }
}

module spacyScrewHoles(h=10) {
    minkowski() {
        intersection() {
            screwHoles(h=h);
            translate([130,20,0])
                cube([130,40,2*h], center=true);
        }
        children();
    }
}

module nonSpacyScrewHoles(h=10) {
    minkowski() {
        difference() {
            screwHoles(h=h);
            translate([130,20,0])
                cube([130,40,2*h], center=true);
        }
        children();
    }
}

module keyCutout() {
    translate([0,0,-5]) {
        minkowski() {
            intersection() {
                union() {
                    linear_extrude(height = 8.5, convexity = 10) {
                        import (file = "./reviung41-Nutzer_2.svg");
                        import (file = "./reviung41-Nutzer_3.svg");
                    }
                }
                edge(h=8.5);
            }
            translate([0,0,-1.5]) cylinder(d1=1,d2=0,h=1.5,$fn=8);
        }
        intersection() {
            linear_extrude(height = 10, convexity = 10)
            import (file = "./reviung41-Nutzer_2.svg");
            edge(h=10);
        }
    }
}
// ############################################################################
// ## top #####################################################################
// ############################################################################

module pins() {
    translate([0,0,-2])
        nonSpacyScrewHoles(h=3)
        cylinder(h=1,d1=1,d2=2,$fn=20);
}

module top() {
    addH=5;
    difference() {
        union() {
            translate([0,0,2])
                edge(h=3);
            render()
            minkowski() {
                translate([0,0,-addH]) {
                    edge(h=5);
                    minkowski() {
                        linear_extrude(height = 4, convexity = 10) {
                            import (file = "./reviung41-Nutzer_2.svg");
                            import (file = "./reviung41-Nutzer_3.svg");
                        }
                        cylinder(d=2,h=1,$fn=20);
                    }
                }
                cylinder(d1=4.5,d2=1,h=addH);
            }
        }
        keyCutout();
        difference() {
            translate([0,0,-addH])
                edge(h=2+addH);
            union() {
                minkowski() {
                    linear_extrude(height = 2, convexity = 10)
                        import (file = "./reviung41-Nutzer_4.svg");
                    cylinder(h=2, d1=0.7, d2=2, $fn=8);
                }
                spacyScrewHoles(h=1)
                    cylinder(h=2, d1=5, d2=6, $fn=20);
            }
        }
        minkowski() {
            translate([0,0,-addH])
                edge(h=addH-1);
            cylinder(d=1, h=1, $fn=8);
        }
        spacyScrewHoles(h=1)
            cylinder(h=3.3, r=1.1, $fn=20);
    }
    pins();

}

module bottom() {
    hSpace=2.5;
    hThickness=2;

    intersection() {
        difference() {
            translate([0,0,-1.6]) {
                translate([0,0,-hSpace-hThickness])
                    edge(h=hThickness);
                translate([0,0,-hSpace])
                    spacyScrewHoles(h=1)
                    cylinder(h=hSpace-1, d1=6, d2=5, $fn=20);
                translate([0,0,-hSpace])
                    nonSpacyScrewHoles(h=1)
                    cylinder(h=hSpace-1, d1=4, d2=3.5, $fn=20);
                minkowski() {
                    translate([0,0,-hSpace])
                        linear_extrude(height = hSpace-2, convexity = 10)
                        import (file = "./reviung41-Nutzer_4.svg");
                    cylinder(h=2, d2=0.7, d1=2, $fn=8);
                }
            }
            translate([0,0,-1.6]) {
                translate([0,0,-hSpace-hThickness])
                    spacyScrewHoles(h=1)
                    cylinder(h=hSpace+hThickness-1, d=0.5, $fn=20);
                translate([0,0,-hSpace-hThickness])
                    spacyScrewHoles(h=1)
                    cylinder(h=3-1, d=3, $fn=20);
            }
            for(t=[[0.2,0.2],[-0.2,0.2],[-0.2,-0.2],[0.2,-0.2]]) {
                translate(t) pins();
            }
        color("red")
            translate([128,41,-5.8])
            rotate([0,180,0])
            linear_extrude(0.31)
            text("github.com/maxhbr",
                    font = "Roboto Condensed:style=slim",
                    size = 10,
                    halign = "center");
        }
        translate([0,0,-hSpace-hThickness-1.6])
            edge(h=hSpace+hThickness+5);
    }

}


// ############################################################################
// ## compose #################################################################
// ############################################################################

part("reviung41.top.stl", s=[0,0,0], r=[0,0,0], rReset=[0,180,30]) {
    top();
}
part("reviung41.bottom.stl", s=[0,0,0], r=[0,0,0], rReset=[0,0,30]) {
    bottom();
}

if ($preview) {
    noPart("gray") {
        translate([32.305,107.194,-1.6])
            import("./reviung41.pcb.stl");
    }
}
