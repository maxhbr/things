$fa = 1;
$fs = 0.4;

rotate([0,180,0])
intersection() {
    difference() {
        union() {
            translate([-55,0,0.5])
                 cylinder(100,100,20,$fn=3);
            translate([-50,0,-10.5])
                rotate([0,0,60])
                 cylinder(100,100,20,$fn=3);
        }
        union() {
            cylinder(h=30,d=108);
            cylinder(h=8,d=113);
            translate([-84,-40,0])
                cube([70,80,25]);
            intersection() {
                translate([-55,0,-23])
                    cylinder(100,100,20,$fn=3);
                translate([-100,-100,0])
                    cube([200,200,25]);
            }
        }
    }
    intersection() {
        translate([-(52.5 + 50),-100,0.5])
            cube([52.5 + 50,200,29]);
        intersection() {
            translate([-94,0,0.5])
                cylinder(h=100, d=200);
            translate([-31,0,0.5])
                cylinder(h=100, d=200);
        }
    }
}
