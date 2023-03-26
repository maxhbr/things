
$fs=0.5;
$fa=5;

height=114.96;
width=156.90;

module screw() {
    cylinder(d=3.2,h=15);
}

module left() {
    translate([-width/2,-height/2,0]) {
        hull() {
            cylinder(d=7,h=10);
            translate([10,5,8])
                cylinder(d=15,h=2);
        };
        hull() {
            translate([10,5,5])
                cylinder(d1=3,d2=5,h=5);
            translate([width/2,5+30,8])
                cylinder(d1=3,d2=5,h=2);
        };
    };
    translate([-width/2,height/2,0]) {
        hull() {
            cylinder(d=7,h=10);
            translate([5,-10,8])
                cylinder(d=15,h=2);
        };
        hull() {
            translate([5,-10,5])
                cylinder(d1=3,d2=5,h=5);
            translate([width/2,-10,8])
                cylinder(d1=3,d2=5,h=2);
        };
        hull() {
            translate([5,-10,5])
                cylinder(d=5,h=5);
            translate([width/2,-height+5+30,8])
                cylinder(d=15,h=2);
        };
    };
    hull() {
        translate([-width/2,-height/2,0]) {
            translate([10,5,8])
                cylinder(d=15,h=2);
        };
        translate([-width/2,height/2,0]) {
            translate([width/2,-height+5+30,8])
                cylinder(d=15,h=2);
            translate([5,-10,8])
                cylinder(d=15,h=2);
            translate([width/2,-10,8])
                cylinder(d=15,h=2);
        };
    };
}

module both() {
    difference() {
        union() {
            left();
            mirror([1,0,0]) left();
        };
        for (t=[[-width/2,-height/2,-1]
               ,[-width/2,height/2,-1]
               ,[width/2,-height/2,-1]
               ,[width/2,height/2,-1]]) {
            translate(t)
                cylinder(d=3.2,h=7);
        };
    };
}

both();
