include <../../lib.scad>


wall=1.5;
innerW=91.2;
innerL=171.5;
innerH=37;
outerW=96.2;
outerL=176.5;
cardH=67;
cardL=94;

module widen(r=wall) {
    for(t1=[[0,0,r],[0,0,0],[0,0,-r]]) {
        translate(t1)
            for(t2=[
                [r,r],[r,0],[0,r],
                [r,-r],[0,-r],
                [-r,-r],[-r,0],
                [-r,r]]) {
                translate(t2) children();
            }
    }
}

module outline() {
    overlap=8;
    translate([0,0,innerH/2 + overlap/2])
        wedgedCube([innerW,innerL,innerH+overlap],r=1,center=true);
    translate([0,0,(cardH-innerH)/2+innerH])
        wedgedCube([outerW,outerL,cardH-innerH],r=3,center=true);
}

module boxBuilder() {
    difference() {
        union() {
            difference() {
                outline();
                /* translate([0,0,-7.5]) */
                /*     wedgedCube([outerW-9,outerL-9,20],r=3,center=true); */
                /* translate([0,0,cardH-wall-(cardH-innerH)/2]) */
                /*     wedgedCube([outerW-6,outerL-6,cardH-innerH],r=6,center=true); */
                /* translate([0,0,cardH/2-wall-1]) */
                /*     wedgedCube([outerW-12,outerL-12,cardH+2],r=3,center=true); */
            }
        }
        children();
    }
}


module box() {
    boxBuilder(){
        translate([0,39-10,cardH/2])
            wedgedCube([innerW-20+4,cardL+4,cardH+4],r=2, center=true);
        translate([0,39-10,cardH*1.5-8])
            wedgedCube([innerW-20+4+8,cardL+4+8,cardH],r=8, center=true);
        translate([0,29,cardH-20])
            hull()
            for(t=[[0,0,0],[0,20,20],[0,-20,20]]) {
                translate(t)
                    rotate([0,90,0])
                    cylinder(d=20,h=outerW, center=true, $fn=100);
            }
        translate([0,29,cardH-20])
        difference() {
            cube([outerW,30,30],center=true);
            cube([innerW,40,40],center=true);
        }

        translate([0,-55,cardH-15])
            hull()
            for(t=[[[0,0,0],50],[[0,5,20],70],[[0,-5,20],70]]) {
                translate(t[0])
                    rotate([0,90,0])
                    cylinder(d=30,h=t[1], center=true, $fn=100);
            }
        translate([0,-55,cardH*1.5-8])
            wedgedCube([innerW-20+4+8,47,cardH],r=8, center=true);

        translate([0,-55,30])
            hull()
            for(t=[[0,0,0],[0,25,-30],[0,-20,-30]]) {
                translate(t)
                    rotate([0,90,0])
                    cube([10,10,innerW -10],center=true);
            }
    }
}


part("radlands.stl", s=[0,0,0], r=[0,0,0], rReset=[0,0,0]) {
    box();
}


/* noPart() { */
/*     translate([100,0,0]) { */
/*         difference() { */
/*             box(); */
/*             translate([0,-100,0]) cube([200,200,200]); */
/*         } */

/*         translate([0,-55,cardH-15]) */
/*             rotate([0,90,0]) */
/*             cylinder(d=25, h=5, center=true); */
/*     } */
/* } */
