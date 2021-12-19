
wall=1.5;
width=46;
depth=60;
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
                    translate([0,0,15+32])
                    rotate([0,90,0])
                    cylinder(h=width, d=depth*1.7, center=true);
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
        translate([-10 + 28,- (depth / 2) - 2.5,0])
            cube([244 - 56,5,12], center=true);
        translate([wall, 3, wall])
            translate([-10 + 28,- (depth / 2) - 2.5,0])
            cube([245 - 56,5,12], center=true);
    }
    difference() {
        translate([-10, (depth / 2) + 2.5,0])
            cube([244,5,12], center=true);
        translate([wall, 3, wall])
            translate([-10, (depth / 2) - 2.5,0])
            cube([245,5,12], center=true);
    }
}

module v1() {
    difference() {
        union() {
            cards(posX=-2);
            tray(posX=-1);
            tray();
            tray(posX=1);
            tray(posX=2);
            rail();
            translate([-10 + 28,- (depth / 2),-3.5])
                rotate([60,0,0])
                cube([244 - 56,4,2], center=true);
            translate([-10,+ (depth / 2) + 2.5,-3.5])
                rotate([60,0,0])
                cube([244,4,2], center=true);
        }
        union() {
            translate([-10+wall, +depth/2+2.5/2,7])
                rotate([45,0,0])
                cube([245,5,5], center=true);
            translate([-10+wall + 28, -depth/2-2.5/2,7])
                rotate([45,0,0])
                cube([245 - 56,5,5], center=true);
        }
    }
}

module rombe() {
    rotate([0,90,0])
        linear_extrude(height = 100, center = false, convexity = 10)
        resize([50,46/2])
        circle(10,$fn=6);
}

module v2mod() {
    difference() {
        rotate([90,0,0])
            linear_extrude(height = 46, center = true, convexity = 10)
            polygon(
                    [[-4,0]
                    ,[-4,2]
                    ,[-10,12]
                    ,[-10,13]
                    ,[-8,14]
                    ,[0,10]
                    ,[30,70]
                    ,[32,70]
                    ,[32,68]
                    ,[15,20]
                    ,[20,10]
                    ,[30,2]
                    ,[30,0]

                    ,[15,0]
                    ,[8,10]
                    ,[1,0]
                    ]);
        union() {
            translate([0,-23,83])
                rombe();
            translate([0,0,35])
                rombe();
            translate([0,23,83])
                rombe();
            translate([15 + 8,0,0])
            cube([30,46/2,60],center=true);
            translate([29,0,-1])
            cylinder(20,20,20,$fn=6);
        }
    }
}

module stand() {
    rotate([0,0,90])
        for (a =[-92:46:92]) {
            translate([0,a,0])
                v2mod();
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
        children();
    }
}

translate([3,0,6])
    part("stuffholder-v1.stl") v1();
translate([0,60,0])
    part("stuffholder-stand.stl") stand();
