width = 46.5;
toLeft = [-37/2,0,0];
toRight = [37/2,0,0];
e=0.25;
numStep = 1;

function coordsToPos(c) = [c.x * width, c.y * 8,0];

function posToLeft(v) = [v.x - (width - 10)/2,v.y];
function posToRight(v) = [v.x + (width - 10)/2,v.y];
function translateToLeft() = translate([(width - 10)/2,0,0]);

/* ========================================================================= */
/* == Configuration ======================================================== */
/* ========================================================================= */

s5  = [[-2,1]     , -6, 2];
s6  = [[-1,0.5]   , -6, 2];
s7  = [[0,0]      , -6, 3];
s8  = [[1,0.5]    , -6, 2];
s9  = [[2,1]      , -6, 3];

s10 = [[-1.5,5]   , -3, 2];
s11 = [[-0.5,4.5] , -3, 3];
s12 = [[0.5,5]    , -3, 2];
s13 = [[1.5,5.5]  , -3, 2];

s14 = [[-2,8.5]   ,  0, 2];
s15 = [[-1,9]     ,  0, 1];
s16 = [[0,8.5]    ,  0, 1];
s17 = [[1,9]      ,  0, 1];
s18 = [[2,9.5]    ,  0, 1];

s19 = [[-1.5,12.5],  2, 1];
s20 = [[-0.5,12]  ,  3, 1];
s21 = [[0.5,11.5] ,  4, 1];
s22 = [[1.5,12]   ,  5, 1];

s23 = [[-1,15]    ,  6, 1];
s24 = [[0,14.5]   ,  9, 1];
s25 = [[1,15]     , 12, 1];

ss=[s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25];

/* ========================================================================= */
/* == Coins ================================================================ */
/* ========================================================================= */

module coin(c, offset=0) {
    translate(coordsToPos(c) + [0,0,31 + offset])
        rotate([90,0,0])
        cylinder(h=6,r=44.5/2,center=true);
}

module coinPlusE(c, offset=0) {
    minkowski() {
        sphere(d=e);
        coin(c,offset);
    }
}

module coins() {
    for (s=ss) {
        v = s[0];
        offset=s[1];
        num=s[2];
        for ( i = [0 : num-1] ) coin(v + [0,i],offset - i * numStep);
    }
}

/* ========================================================================= */
/* == Base ================================================================= */
/* ========================================================================= */

module bridgeSupport(v) {
    translate(v){
        cylinder(h=1,r=3, center=false);
        cylinder(h=10,r=1, center=false);
    }
}

module bridge(v,w) {
    hull() {
        bridgeSupport(v);
        bridgeSupport(w);
    }
}

module bridgeLeftRight(c1, c2) {
    bridge(coordsToPos(c1) + toLeft,coordsToPos(c2) + toRight);
}

module bridgeRightRight(c1, c2) {
    bridge(coordsToPos(c1) + toRight,coordsToPos(c2) + toRight);
}

module bridgeLeftLeft(c1, c2) {
    bridge(coordsToPos(c1) + toLeft,coordsToPos(c2) + toLeft);
}

module pillars(c, offset=0) {
    pillarH = 25 + offset;
    translate(coordsToPos(c)) {
        difference() {
            union() {
                translate(toRight)
                    linear_extrude(height = pillarH, convexity = 10, twist = 0)
                    polygon(points=[[5,-5],[-5,-5],[-5,5],[5,5],[6.5,3.5],[6.5,-3.5]]);
                translate(toLeft) 
                    linear_extrude(height = pillarH, convexity = 10, twist = 0)
                    polygon(points=[[5,-5],[-5,-5],[-6.5,-3.5],[-6.5,3.5],[-5,5],[5,5]]);
            }
            translate([0,0,pillarH+8]) {
                rotate([0,45,0])
                cube(40, center=true);
            }

        }
    }
}

module seat(s, ltrs=[], rtls=[], rtrs=[], ltls=[]) {
    v = s[0];
    offset = s[1];
    num = s[2];
    difference() {
        union() {
            for ( i = [0 : num-1] ) pillars(v + [0,i], offset - i * numStep);

            vEnd = [v.x, v.y + num -1];
            for (w = ltrs) bridgeLeftRight(vEnd,w[0]);
            for (w = rtls) bridgeLeftRight(w[0],vEnd);
            for (w = rtrs) bridgeRightRight(w[0],vEnd);
            for (w = ltls) bridgeLeftLeft(w[0],vEnd);
        }
        union () {
            for ( i = [0 : num-1] ) coinPlusE(v + [0,i],offset - i * numStep);
        }
    }
}

module seats() {
    seat(s5, ltrs=[], rtls=[s10], ltls=[s10]);
    seat(s6, ltrs=[s10], rtls=[s11]);
    seat(s7, ltrs=[s11], rtls=[s12]);
    seat(s8, ltrs=[s12], rtls=[s13]);
    seat(s9, ltrs=[s13], rtls=[], rtrs=[s13]);

    seat(s10, ltrs=[s14], rtls=[s15], ltls=[s14]);
    seat(s11, ltrs=[s15], rtls=[s16]);
    seat(s12, ltrs=[s16], rtls=[s17]);
    seat(s13, ltrs=[s17], rtls=[s18], rtrs=[s18]);

    seat(s14, ltrs=[], rtls=[s19]);
    seat(s15, ltrs=[s19], rtls=[s20]);
    seat(s16, ltrs=[s20], rtls=[s21]);
    seat(s17, ltrs=[s21], rtls=[s22]);
    seat(s18, ltrs=[s22], rtls=[]);

    seat(s19, ltrs=[], rtls=[s23]);
    seat(s20, ltrs=[s23], rtls=[s24]);
    seat(s21, ltrs=[s24], rtls=[s25]);
    seat(s22, ltrs=[s25], rtls=[]);

    seat(s23);
    seat(s24);
    seat(s25);
}

/* ========================================================================= */
/* == Cover ================================================================ */
/* ========================================================================= */

module counterPillars(c, offset=0) {
    boxH = 60;
    cPillarH = 25 - offset;
    translate(coordsToPos(c)) {
        difference() {
            union() {
                translate([-width/2,-5,boxH - cPillarH])
                    cube([width,10,cPillarH]);
            }
            union() {
                translate([0,0,31 + offset])
                    rotate([90,0,0])
                    cylinder(h=11,r=20,center=true);
                translate([-10, -7.5,0])
                cube([20,15,60]);
            }
        }
    }
}

module boxSupport() {
    intersection() {
        rotate([0,0,-45])
            difference() {
                translate([-14,-14,1])
                    cube([28,28,59]);
                translate([-6,-6,-0.5])
                    cube([25,25,61]);
            }
        translate([-15,-15,-0.5])
            cube([16,30,61]);
    }
}

module boxSupports() {
    difference() {
        translate([-108,44,0])
            rotate([0,0,180])
            boxSupport();
        translate([-e * 1.4,0,0.9])
            union() {
                seat(s5, ltrs=[], rtls=[], ltls=[s10]);
                seat([s10[0],s10[1]+3,s10[2]], ltrs=[], rtls=[], ltls=[s14]);
            }
    }
    difference() {
        translate([108,49,0])
            boxSupport();
        translate([e * 1.4,0,0.9])
            union() {
                seat(s9, ltrs=[], rtls=[], rtrs=[s13]);
                seat([s13[0],s13[1]+3,s13[2]], ltrs=[s17], rtls=[], rtrs=[s18]);
            }
    }
}

module boxSupportGaps() {
    translate([-119,44,0])
        rotate([0,0,45])
        translate([-12.5,-12.5,-0.5])
        cube([25,25,61]);
    translate([119,49,0])
        rotate([0,0,45])
        translate([-12.5,-12.5,-0.5])
        cube([25,25,61]);
}

module box() {
    thicknesF = 2;
    thicknesB = 4;
    difference() {
        union() {
            hull() {
                for (s=ss) {
                    v = s[0];
                    num = s[2];
                    for ( i = [0 : num-1] ) {
                        translate(coordsToPos(v + [0,i]) + 
                                [-(width + 4) / 2, -5,60 - thicknesF])
                            cube([width+4,10,thicknesF]);
                    }
                }
                translate([97,107,0])
                    rotate([0,0,-45])
                    translate([-width/2,-5,60 - thicknesB])
                    cube([width,10,thicknesB]);
                translate([-97,107,0])
                    rotate([0,0,45])
                    translate([-width/2,-5,60 - thicknesB])
                    cube([width,10,thicknesB]);
            }
            for (s=ss) {
                v = s[0];
                offset = s[1];
                num = s[2];
                for ( i = [0 : num-1] ) counterPillars(v + [0,i], offset - i * numStep);
            }

            translate([97,107,0])
                rotate([0,0,-45])
                translate([-width/2,-5,32])
                cube([width,10,28]);
            translate([-97,107,0])
                rotate([0,0,45])
                translate([-width/2,-5,32])
                cube([width,10,28]);

            boxSupports();
        }
        union () {
            for (s=ss) {
                v = s[0];
                offset = s[1];
                num = s[2];
                for ( i = [0 : num-1] ) coinPlusE(v + [0,i],offset - i  * numStep);
            }
            translate(coordsToPos(s23[0]) + [-7,-3.2, 35])
                cube([14,6.4,40]);
            translate(coordsToPos(s24[0]) + [-14,-3.2, 35])
                cube([28,6.4,40]);
            translate(coordsToPos(s25[0]) + [-17,-3.2, 35])
                cube([34,6.4,40]);
            translate([97,107,0])
                rotate([0,0,-45])
                coinPlusE([0,0]);
            translate([-97,107,0])
                rotate([0,0,45])
                coinPlusE([0,0]);

            boxSupportGaps();
        }
    }
}

/* ========================================================================= */
/* == Main ================================================================= */
/* ========================================================================= */

justOnePart="";

module part(partName,c=undef){
    if (justOnePart == ""){
        color(c=c)
            children();
    } else if (justOnePart == partName) {
        $fa = 1;
        $fs = 0.4;
        color(c=c)
            children();
    }
}

module noPart(c=undef){
    if (justOnePart == ""){
        color(c=c)
            children();
    }
}


part("seats.stl",c="Silver") seats();
noPart(c="Gold") coins();
part("box.stl",c="Tan") box();

noPart(c="Tan") translate([-250,0,60]) rotate([0,180,0]) box();

noPart(c="Silver") translate([250,0,0]) seats();

