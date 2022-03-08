relLen=120;
relWid=33;
relHig=18;
rel=[relLen,relWid,relHig];



translate([-(relLen+20)/2,-(relWid+10)/2,(relHig+10)/2])
    union() {
        difference() {
            cube(rel+[20,10,10],center=true);
            translate([-6,0,2]) cube(rel+[4,4,10],center=true); 
            for(t=[[0,7,0],[0,-7,0]]) {
                translate(t)
                    hull() {
                        translate([40,0,relHig/-2+4]) rotate([0,93,0]) cylinder(d=10,h=200);
                        translate([40,0,relHig/-2+4-10]) rotate([0,93,0]) cylinder(d=10,h=200);
                    }
            }
            translate([relLen/2+3,0,-13]) cube([10,24,20],center=true);
            translate([relLen/2+3,0,+6]) cube([10,2,20],center=true);
            translate([relLen/2+3,-11,+6]) cube([10,2,20],center=true);
            translate([relLen/2+3,11,+6]) cube([10,2,20],center=true);
            translate([relLen/2+13,-7,-17]) cube([10,10,20],center=true);
            translate([relLen/2+13,7,-17]) cube([10,10,20],center=true);
            translate([42,0,-10]) cube([relHig + 10,relWid+4,10],center=true);
        }
        translate([63,0,-9])
            difference() {
                cube([10,4,10],center=true);
                translate([0,0,5])
                    rotate([90,0,0])
                    cylinder(d=10,h=30,center=true);
            }
    }


/* shadeLen=50; */
/* shadeWid=53; */
/* shadeHig=27+relHig+10; */
/* translate([shadeLen/2,-shadeWid/2,-shadeHig/2+relHig+10]) */
/* difference(){ */
/*     cube([shadeLen,shadeWid,shadeHig],center=true); */
/*     translate([-1,0,2]) */
/*         cube([shadeLen-2,shadeWid-4,shadeHig],center=true); */
/* } */
