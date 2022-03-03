
highRes=false;
justOnePart="";

module part(partName, shift=[0,0,0]){
    if (justOnePart == ""){
        translate(shift){
            children();
            translate([150,0,0])
            text(partName,
                    font = "Roboto Condensed:style=Light",
                    size = 7,
                    halign = "center");
        }
    } else if (justOnePart == partName) {
        $fa = 1;
        $fs = 0.4;
        rotate([0,0,35]) {
            children();
        }
    }
}

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
                translate([0,-20+2,-14])
                    rotate([90,0,90])
                    cylinder(width-2*wall,20,20,$fn=3,center=true);
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
                translate([34,0,0])
                    rotate([0,37,0])
                    cube([10, depth, 30], center=true);
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
    translate([0,0,6]) {
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
                translate([-139,-12,0])
                    rotate([0,-37,0])
                    cube([10, depth + 20, 30], center=true);

                translate([18,-40,0])
                    rotate([0,-10,90])
                    cube([10, 188-4*wall, 30], center=true);
                translate([-10,40,0])
                    rotate([0,10,90])
                    cube([10, 244-4*wall, 30], center=true);
                
                translate([112.5,36,0])
                    rotate([0,0,45])
                    cube([4,4,20],center=true);
                translate([112.5,-36,0])
                    rotate([0,0,45])
                    cube([4,4,20],center=true);
                translate([-132.5,36,0])
                    rotate([0,0,45])
                    cube([4,4,20],center=true);

                translate([-120.5,0,-5.7])
                    rotate([180,0,270])
                    linear_extrude(0.31)
                    text("github.com/maxhbr/things",
                            font = "Roboto Condensed:style=Light",
                            size = 4,
                            halign = "center");
            }
        }
    }
}

module v1a() {
    v1_base() {
        tray(posX=-1, bigger=true);
        tray(bigger=true);
        tray(posX=1, bigger=true);
        trayEnd(posX=2);
    }
}

module v1b() {
    v1_base() {
        tray(posX=-1, bigger=true);
        translate([22,(depth-wall - 1)/2,0])
            cube([134-width,wall+1,12], center=true);
        translate([22,-(depth-wall - 1)/2,0])
            cube([134-width,wall + 1,12], center=true);

        trayEnd(posX=2);
        translate([66.5,0,0])
            cube([wall, depth,12], center=true);
    }
}

module v1c() {
    v1_base() {
        translate([1,(depth-wall - 1)/2,0])
            cube([134,wall+1,12], center=true);
        translate([1,-(depth-wall - 1)/2,0])
            cube([134,wall + 1,12], center=true);
        translate([-66.5,0,0])
            cube([wall, depth,12], center=true);

        trayEnd(posX=2);
        translate([66.5,0,0])
            cube([wall, depth,12], center=true);
    }
}

module boxes() {

    translate([-width + 1.5* wall,0,6]) {
        difference() {
            cube([width - 2*wall, depth - 4*wall, height], center=true);
            union() {
                translate([0,14.625 - wall,wall/2]) {
                    cube([width - 2*wall - 2*wall, (depth - 4*wall- 2*wall - wall) / 2, height], center=true);
                }
                translate([0,-(14.625 - wall),wall/2]) {
                    cube([width - 2*wall - 2*wall, (depth - 4*wall- 2*wall - wall) / 2, height], center=true);
                }
            }
        }
        translate([14.75,0,0])
            difference(){
                cube([height - wall, depth - 4*wall- 2*wall, height], center=true);
                translate([-(height - wall)/2, 0, (height - wall)/2])
                    rotate([90,90,0])
                    cylinder(r=height - wall, h=depth - 4*wall- 2*wall, center=true);
            }
    }

    translate([0,0,6]) {
        difference() {
            cube([width - 2*wall, depth - 4*wall, height], center=true);
            translate([0,0,wall/2]) {
                cube([width - 2*wall - 2*wall, depth - 4*wall- 2*wall, height], center=true);
            }
        }
        translate([14.75,0,0])
            difference(){
                cube([height - wall, depth - 4*wall- 2*wall, height], center=true);
                translate([-(height - wall)/2, 0, (height - wall)/2])
                    rotate([90,90,0])
                    cylinder(r=height - wall, h=depth - 4*wall- 2*wall, center=true);
            }
    }

    translate([+width - 1.5 * wall,0,9]) {
        difference() {
            cube([width - 2*wall, depth - 4*wall, 1.5*height], center=true);
            translate([0,0,wall/2])
                cube([width - 2*wall - 2*wall, depth - 4*wall- 2*wall, 1.5*height], center=true);
        }
    }

    translate([(+width - 1 * wall)/2,90,9]) {
        difference() {
            cube([(width - 2*wall) * 2 , depth - 4*wall, 1.5*height], center=true);
            translate([0,0,wall/2])
                cube([(width - 2*wall) * 2 - 2*wall, depth - 4*wall- 2*wall, 1.5*height], center=true);
        }
    }

}

module v2() {
    difference() {
        union() {

            translate([-30,0,0]) cards();
            mirror([1,0,0]) translate([-30,0,0]) cards();

            difference() {
                translate([0, (depth / 2) + 2.5,0])
                    cube([146,5,12], center=true);
                translate([0, 2.5, wall])
                    translate([0, (depth / 2) - 2.5,0])
                    cube([245,5,12], center=true);
            }
            translate([0,+ (depth / 2) + 2.4,-3.5])
                rotate([60,0,0])
                cube([146,4,2], center=true);

            cube([14,60,12],center=true);
        }
        translate([0,-31,0])
            cube([38,2,13],center=true);
        union() {
            translate([77,0,7])
                rotate([0,45,0])
                cube([10,depth+15,10], center=true);
            translate([-77,0,7])
                rotate([0,45,0])
                cube([10,depth+15,10], center=true);
        }
        union() {
            translate([0, +depth/2+2.5/2,7])
                rotate([45,0,0])
                cube([245,5,5], center=true);
            translate([0, -depth/2-2.5/2,7])
                rotate([45,0,0])
                cube([35,5,5], center=true);
            translate([-139,-12,0])
                rotate([0,-37,0])
                cube([10, depth + 20, 30], center=true);

            translate([0,40,0])
                rotate([0,10,90])
                cube([10, 146-4*wall, 30], center=true);

            translate([73,36,0])
                rotate([0,0,45])
                cube([4,4,20],center=true);
            translate([-73,36,0])
                rotate([0,0,45])
                cube([4,4,20],center=true);
            /* translate([0,-10,0]) */
            /*     cube([38,70,20],center=true); */
            /* translate([0,-35,0]) */
            /*     rotate([0,0,45]) */
            /*     cube([38,38,20],center=true); */

            translate([-80.5,0,-5.7])
                rotate([180,0,270])
                linear_extrude(0.31)
                text("github.com/maxhbr/things",
                        font = "Roboto Condensed:style=Light",
                        size = 4,
                        halign = "center");
        }
    }

}

part("stuffholder-v1a.stl") v1a();
part("stuffholder-v1c.stl", shift=[0,90,0]) v1c();
part("stuffholder-v1b.stl", shift=[0,180,0]) v1b();
part("stuffholder-boxes.stl", shift=[0,90,120]) boxes();
part("stuffholder-v2.stl", shift=[300,0,0]) v2();
