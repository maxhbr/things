

module cone(offset) {
    hull() {
        cylinder(h=3, d=100-offset);
        translate([30,0,0])
            cylinder(h=98, d=30-offset);
    }
}

module rotateThreeTimes() {
    children();
    rotate([0,0,120])
    children();
    rotate([0,0,240])
    children();
}

module one() {
    difference() {
        rotateThreeTimes()
            cone(0);
        translate([0,0,-2])
            cylinder(h=98, d=69);
        rotateThreeTimes() {
            translate([0,0,-2])
                cone(4);

            hull() {
                translate([0,0,48])
                    rotate([0,-90,0])
                    cylinder(d=7, h=50);
                translate([0,0,98])
                    rotate([0,-90,0])
                    cylinder(d=42, h=50);
            }
            translate([0,0,30])
                hull() {
                    translate([0,0,48])
                        rotate([0,90,0])
                        cylinder(d=7, h=50);
                    rotate([0,90,0])
                        cylinder(d=42, h=50);
                }
        }
    };

    rotateThreeTimes()
        translate([0,-5,98-2])
        cube([40,10,2]);
}

one();
