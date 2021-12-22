
wall=1.5;
width=46;
depth=60;
height=12;

module tray(posX=0, bigger=false) {
    translate([posX * (width - wall),0,0])
        difference() {
            cube([width,depth,height], center=true);
            union() {
                translate([0,0,wall])
                    intersection() {
                        intersection() {
                            cube([width - 2*wall,depth -2*wall,height], center=true);
                            cylinder(h=width, d=depth, center=true);
                        }
                        translate([0,0,15+21])
                            rotate([0,90,0])
                            cylinder(h=width, d=depth*1.4, center=true);
                    }
                if (bigger) {
                    translate([0,15 - wall/2,4+wall])
                        cube([width - 2*wall,30-wall,20], center=true);
                    translate([0, +depth/2-2.5/2,8])
                        cube([width - 2*wall,5,5], center=true);
                }
            }
        }
}
module trayEnd(posX=0) {
    translate([posX * (width - wall),0,0])
        difference() {
            union(){
                cube([width,depth,height], center=true);
                intersection() {
                cylinder(h=height, d=depth + wall*2, center=true);
                translate([width-wall,0,0])
                cube([width,depth,height], center=true);
                }
            }
            union() {
                translate([0,0,wall])
                    intersection() {
                        cylinder(h=width+1, d=depth, center=true);
                        intersection() {
                            translate([0,0,15+32])
                                rotate([0,90,90])
                                cylinder(h=width*2, d=depth*1.73, center=true);
                            cube([100,depth-3*wall,10],center=true);
                        }
                    }
            }
        }
}

module cards(posX=0) {
    translate([posX * (width - wall) -10,0,0])
        difference() {
            translate([0,-2.5,0])
                cube([width+20,depth + 5,height], center=true);
            union() {
                for (a =[21:-7:-28]) {
                    translate([0,a,wall+1]) 
                        rotate([0,0,7])
                        rotate([-5,0,0])
                        union() {
                            rotate([0,2,0])
                                cube([width + wall + 20,2,height], center=true);
                            translate([-5+wall, 0,4])
                                rotate([45,0,0])
                                cube([width + wall + 10+10 + 10,5,5], center=true);
                        }
                }
                translate([-36,-14.5,7])
                    rotate([0,45,0])
                    cube([10,depth+5,10], center=true);
                translate([width/2 + 5.5,-depth/2 - 5,0])
                    cube([11,10,20], center=true);
                translate([0,-37,0])
                    rotate([0,0,7])
                    rotate([-5,0,0])
                    translate([-4.5,0,0])
                    cube([width+10,10,20], center=true);
            }
        }
}

module rail() {
    difference() {
        union() {
            difference() {
                translate([-10 + 28,- (depth / 2) - 2.5,0])
                    cube([244 - 56,5,12], center=true);
                translate([wall, 3, wall])
                    translate([-10 + 28,- (depth / 2) - 2.5,0])
                    cube([245 - 56,5,12], center=true);
            }
            difference() {
                translate([-10, (depth / 2) + 2.5,0])
                    cube([244,5,12], center=true);
                translate([0, 2.5, wall])
                    translate([-10, (depth / 2) - 2.5,0])
                    cube([245,5,12], center=true);
            }
        }
        union() {
            translate([114,0,7])
                rotate([0,45,0])
                cube([10,depth+15,10], center=true);
            translate([-134,0,7])
                rotate([0,45,0])
                cube([10,depth+15,10], center=true);
        }
    }
}

module v1_base() {
    translate([0,0,6])
    difference() {
        union() {
            cards(posX=-2);
            children();
            rail();
            translate([-10 + 28,- (depth / 2),-3.5])
                rotate([60,0,0])
                cube([244 - 56,4,2], center=true);
            translate([-10,+ (depth / 2) + 2.4,-3.5])
                rotate([60,0,0])
                cube([244,4,2], center=true);
        }
        union() {
            translate([-10, +depth/2+2.5/2,7])
                rotate([45,0,0])
                cube([245,5,5], center=true);
            translate([-10+wall + 28, -depth/2-2.5/2,7])
                rotate([45,0,0])
                cube([245 - 56,5,5], center=true);
            /* translate([30,0,46]) */
            /*     rotate([0,90,0]) */
            /*     cylinder(h=150,d=90, center=true); */
        }
    }
}

module v1() {
    v1_base() {
        tray(posX=-1, bigger=true);
        tray(bigger=true);
        tray(posX=1, bigger=true);
        trayEnd(posX=2);
    }
}

module v1b() {
    v1_base() {
        tray(posX=-1);
        translate([45,(depth-wall - 1)/2,0])
            cube([134,wall+1,12], center=true);
        translate([45,-(depth-wall - 1)/2,0])
            cube([134,wall + 1,12], center=true);
    }
}

highRes=false;
justOnePart="";

module part(partName){
    if (justOnePart == ""){
        children();
    } else if (justOnePart == partName) {
        $fa = 1;
        $fs = 0.4;
        rotate([0,0,35]) {
            children();
        }
    }
}

part("stuffholder-v1.stl") v1();
translate([0,90,0])
    part("stuffholder-v1b.stl") v1b();
