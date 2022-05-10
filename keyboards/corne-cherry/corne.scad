include <../../lib.scad>

// ############################################################################
// ## lib #####################################################################
// ############################################################################

module screwHoles(h=10) {
    minkowski() {
        linear_extrude(height = h, convexity = 10)
            import (file = "./corne-cherry-Nutzer_1.svg");
        children();
    }
}

module edge(h=3) {
    linear_extrude(height = h, convexity = 10) {
        import (file = "./corne-cherry-Nutzer_5.svg");
        import (file = "./corne-cherry-Nutzer_4.svg");
    }
    screwHoles(h=h-1) {
        cylinder(h=1, d=5);
    }
}
module spacySelector(h=10) {
    color("red",0.3){
        translate([62,30,0])
            cube([10,10,2*h], center=true);
        translate([108,22,0])
            cube([10,10,2*h], center=true);
        translate([37,88,0])
            cube([10,10,2*h], center=true);
        translate([118,88,0])
            cube([10,10,2*h], center=true);
    }
}

module spacyScrewHoles(h=10) {
    minkowski() {
        intersection() {
            screwHoles(h=h);
            spacySelector(h=h);
        }
        children();
    }
}

module nonSpacyScrewHoles(h=10) {
    minkowski() {
        difference() {
            screwHoles(h=h);
            spacySelector(h=h);
        }
        children();
    }
}

module keyCutout() {
    translate([0,0,-5]) {
        minkowski() {
            linear_extrude(height = 8.5, convexity = 10) {
                import (file = "./corne-cherry-Nutzer_2.svg");
                import (file = "./corne-cherry-Nutzer_3.svg");
            }
            translate([0,0,-1.5]) cylinder(d1=1,d2=0,h=1.5,$fn=8);
        }
        linear_extrude(height = 10, convexity = 10)
            import (file = "./corne-cherry-Nutzer_2.svg");
    }
}
// ############################################################################
// ## top #####################################################################
// ############################################################################

module pins() {
    translate([0,0,-2])
        nonSpacyScrewHoles(h=3)
        cylinder(h=1,d1=1,d2=1.5,$fn=20);
}

module top() {
    addH=5;
    difference() {
        union() {
            translate([0,0,2])
                edge(h=3);
            render()
            minkowski() {
                translate([0,0,-addH]) edge(h=5);
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
                        import (file = "./corne-cherry-Nutzer_4.svg");
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
            cylinder(h=3.3, r=0.6, $fn=20);
        color("yellow")
            translate([0,0,-1.6-4])
            minkowski() {
                linear_extrude(height = 5, convexity = 10)
                    import (file = "./corne-cherry-Nutzer_6.svg");
                cylinder(h=1,d=0.5);
            }
    }
    pins();
}

module bottom(mirrorText=false) {
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
                        import (file = "./corne-cherry-Nutzer_4.svg");
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
                translate([64,57,-5.8])
                rotate([0,180,0])
                linear_extrude(0.31)
                mirror(mirrorText ? [1,0,0] : [0,0,0])
                text("github.com/maxhbr",
                        font = "Roboto Condensed:style=slim",
                        size = 10,
                        halign = "center");
            color("yellow")
                translate([0,0,-hSpace-hThickness-2])
                minkowski() {
                    linear_extrude(height = 3, convexity = 10)
                        import (file = "./corne-cherry-Nutzer_6.svg");
                    cylinder(h=1,d=1);
                }
        }
        translate([0,0,-hSpace-hThickness-1.6])
            edge(h=hSpace+hThickness+5);
    }

}


// ############################################################################
// ## compose #################################################################
// ############################################################################

module mkRight() {
    translate([-68,23,0])
        mirror([0,1,0])
        children();
}

part("corne-cherry.top.stl", s=[0,0,0], r=[0,0,0], rReset=[0,180,0]) {
    top();
    mkRight() top();
}
part("corne-cherry.bottom.stl", s=[0,0,0], r=[0,0,0], rReset=[0,0,0]) {
    bottom();
    mkRight() bottom(mirrorText=true);
}

if ($preview) {
    /* noPart("gray") { */
    /*     translate([32.305,107.194,-1.6]) */
    /*         import("./corne-cherry.pcb.stl"); */
    /* } */
    translate([150,100,0]) top();
    translate([0,100,0]) bottom();
    translate([-150,100,0]) { 
        keyCutout();
        screwHoles(h=10);
        color("red",0.2) spacySelector(h=10);
    }
}

