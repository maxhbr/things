
wall=1.5;
width=46;
depth=70+2*wall;
height=12;

module tray(posX=0) {
    translate([posX * (width - wall),0,0])
        difference() {
            cube([width,depth,height], center=true);
            translate([0,0,wall])
                intersection() {
                    intersection() {
                        cube([width - 2*wall,depth -2*wall,height], center=true);
                        cylinder(h=width, d=depth, center=true);
                    }
                    translate([0,0,15+41])
                    rotate([0,90,0])
                    cylinder(h=width, d=depth*1.7, center=true);
                }
        }
}

module cards(posX=0) {
    translate([posX * (width - wall) -5,0,0])
        difference() {
            cube([width+10,depth,height], center=true);
            union() {
                for (a =[24:-8:-24]) {
                    translate([0,a,wall+1]) 
                    rotate([0,-2,10])
                    cube([width + wall + 10,2.5,height], center=true);
                }
            }
        }
}

module flatCards(posX=0) {
    translate([posX * (width - wall),0,0])
        difference() {
            cube([width*2,depth,height], center=true);
            translate([0,0,wall])
                cube([(width*3) - 2*wall,depth -2*wall,height], center=true);
        }
}

module caps() {
    translate([-2 * (width - wall) - (width + 2)/2,0,0])
        cube([4, depth, height],center=true);
    translate([2 * (width - wall) + (width + 2)/2,0,0])
        cube([4, depth, height],center=true);
}

module rail() {
    difference() {
        translate([-5,- (depth / 2) - 2.5,0])
            cube([234,5,12], center=true);
        translate([wall, 5/2, wall])
            translate([-5,- (depth / 2) - 2.5,0])
            cube([235,5,12], center=true);
    }
}

cards(posX=-2);
tray(posX=-1);
tray();
tray(posX=1);
tray(posX=2);
rail();
mirror([0,1,0])
    rail();

$fa = 1;
$fs = 0.4;
