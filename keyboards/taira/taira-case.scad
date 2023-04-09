h=32.5/2 + 2.5;

module wedge() {
    translate([-h,0,0])
        rotate([0,90,0])
        rotate([0,0,45])
        cylinder(r1=18, r2=18-2.5, h=2.5,$fn=4);
}


module edge(h=3) {
    rotate([0,-90,0])
    linear_extrude(height = h, convexity = 10)
        import (file = "./taira-bottom-plate.svg");
}

module inner() {
    render(convexity = 2)
            difference() {
                edge(32.5/2 + 2.5);
                translate([0,23.5,-1]) wedge();
                translate([0,114.5,-1]) wedge();
                translate([0,-5,130]) wedge();
            }
}
module inners() {
    render(convexity = 2)
        for (t=[[0,0,0]
               ,[0,0.5,0],[0,-0.5,0]
               ,[0,0.5,1],[0,-0.5,1]
               ,[0,0.5,2],[0,-0.5,2]
               ,[0,0.5,3],[0,-0.5,3]
               ,[0,0.5,4],[0,-0.5,4]
                         ,[0,0.5,18]
                         ,[0,0.5,28]
               ]) {
            translate(t) inner();
        }
        // minkowski() {
            inner();
        //     sphere(d=0.5);
        // }
    for(t=[[2.5,-3,134],[0,119,76]]) {
        translate([-(32.5/2 + 2.5),0,0]+t)
            cube([32.5/2 + 2.5 + 0.5,5,5]);
    }
        translate([-(32.5/2 + 2.5),0,0]+[0,119,73])
            rotate([45,0,0])
            cube([32.5/2 + 2.5 + 0.5,5,5]);

        translate([-(32.5/2 + 2.5),0,0]+[2.5,10,123])
            rotate([45,0,0])
            cube([32.5/2 + 2.5 + 0.5,50,50]);
}

module outer() {
    minkowski() {
        difference() {
            edge(32.5/2 + 2.5 + 0.5);
            hull() {
                translate([0,108,124]) rotate([0,-90,0]) cylinder(d=12,h=40);
                translate([0,104,118]) rotate([0,-90,0]) cylinder(d=12,h=40);
            }
        }
        sphere(r=2,$fn=6);
    }
    hull()
        intersection () {
            minkowski() {
                edge(32.5/2 + 2.5 + 0.5);
                sphere(r=2,$fn=6);
            }
            translate([-40,100,-10])
            cube([80,80,80]);
        }

}

module rails() {
    difference() {
        translate([-(32.5/2 + 2.5)+13,0,0])
            difference() {
                translate([0,-0.5,0])
                    edge(3);
                translate([0,0.5,0])
                    edge(3);
            }
        translate([-(32.5/2 + 2.5),0,0]+[2.5,10,123])
            rotate([45,0,0])
            cube([32.5/2 + 2.5 + 0.5,50,50]);
    }
    translate([-(32.5/2 + 2.5)+10,120.7,54]) {
        hull() {
            translate([0.5,0,0])
                cube([2,1,20]);
            translate([0,1,1])
                cube([3,1,20]);
        }
    }
    translate([-(32.5/2 + 2.5)+10,118.2,35]) {
        hull() {
            translate([0.5,0,0])
                cube([2,1,20]);
            translate([0,1,1])
                cube([3,1,20]);
        }
    }
}

module half() {
    difference() {
        outer();
        difference() {
            inners();
            rails();
        }
        translate([0,-50,-10]) cube([200,200,200]);

        // translate([-(h+2.5),0,0])
        //     minkowski() {
        //         render()
        //             intersection_for(t=[[0,0,10],[0,10,0],[0,-10,0],[0,0,-10],[0,-10,-10]])
        //             translate(t)
        //             edge(1);
        //         rotate([0,90,0])
        //             cylinder(d1=10,d2=1,h=1,$fn=20);
        //     }

    }
}
half();
if(!$preview) mirror([1,0,0]) half();
