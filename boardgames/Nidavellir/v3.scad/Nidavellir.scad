use <../../../assets/Roboto-Medium.ttf>

width = 46.5;
boxH = 60;
toLeft = [-37/2,0,0];
toRight = [37/2,0,0];
e=0.35;
numStep = 1;

function coordsToPos(c) = [c.x * width, c.y * 8,0];

function posToLeft(v) = [v.x - (width - 10)/2,v.y];
function posToRight(v) = [v.x + (width - 10)/2,v.y];
function translateToLeft() = translate([(width - 10)/2,0,0]);

/* ========================================================================= */
/* == Configuration ======================================================== */
/* ========================================================================= */

s5  = [[-2,1]     , -6, 2];
s6  = [[-1,0.5]   , -5.5, 2];
s7  = [[0,0]      , -5, 3];
s8  = [[1,0.5]    , -4.5, 2];
s9  = [[2,1]      , -4, 3];

s10 = [[-1.5,5]   , -3, 2];
s11 = [[-0.5,4.5] , -2.5, 3];
s12 = [[0.5,5]    , -2, 2];
s13 = [[1.5,5.5]  , -1, 2];

s14 = [[-2,8.5]   ,  0, 2];
s15 = [[-1,9]     ,  0.5, 1];
s16 = [[0,8.5]    ,  1, 1];
s17 = [[1,9]      ,  1.5, 1];
s18 = [[2,9.5]    ,  2, 1];

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
    color("Gold")
        translate(coordsToPos(c) + [0,0,31 + offset])
        rotate([90,0,0])
        cylinder(h=2,r=40/2,center=true);
    color("GhostWhite", alpha = 0.4)
        translate(coordsToPos(c) + [0,0,31 + offset])
        rotate([90,0,0])
        cylinder(h=6,r=44.5/2,center=true);
}

module coinPlusE(c, offset=0, ePlus=0) {
    minkowski() {
        sphere(d=e + ePlus);
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
        cylinder(h=1,r=4, center=false);
        cylinder(h=10,r=1, center=false);
    }
}

module bridge(v,w) {
    color(c="Silver") {
        hull() {
            bridgeSupport(v);
            bridgeSupport(w);
        }
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

module pillars(c, offset=0, text=undef) {
    pillarH = 25 + offset;
    off=10;
    translate(coordsToPos(c)) {
        difference() {
            color(c="Silver") {
                difference() {
                    translate(toRight)
                        linear_extrude(height = pillarH, convexity = 10, twist = 0)
                        polygon(points=[[5,-5],[-5,-5],[-5,5],[5,5],[6.5,3.5],[6.5,-3.5]]);
                    translate([0,0,pillarH+8])
                        rotate([0,45-off,0])
                        cube(40, center=true);
                    translate([0,0,pillarH+10.5])
                        rotate([0,45+off,0])
                        cube(40, center=true);
                }
                difference() {
                    translate(toLeft) 
                        linear_extrude(height = pillarH, convexity = 10, twist = 0)
                        polygon(points=[[5,-5],[-5,-5],[-6.5,-3.5],[-6.5,3.5],[-5,5],[5,5]]);
                    translate([0,0,pillarH+8])
                        rotate([0,45+off,0])
                        cube(40, center=true);
                    translate([0,0,pillarH+10.5])
                        rotate([0,45-off,0])
                        cube(40, center=true);
                }

            }
            union() {
                textDepth = 0.5;
                color("DimGray") 
                translate(toLeft + [0.5,-5 + textDepth,14 + offset])
                    rotate([90,0,0])
                        linear_extrude(1)
                            text(text,
                                    font = "Roboto Condensed:style=Bold",
                                    size = 5,
                                    halign = "center");
            }
        }
    }
}

module seatCoins(s) {
    v = s[0];
    offset = s[1];
    num = s[2];
    color(c="Silver") {
        for ( i = [0 : num-1] ) coinPlusE(v + [0,i],offset - i * numStep);
    }
}

module seat(s, ltrs=[], rtls=[], rtrs=[], ltls=[], text=undef) {
    v = s[0];
    offset = s[1];
    num = s[2];
    for ( i = [0 : num-1] ) { 
        if (i == 0) {
            pillars(v + [0,i], offset - i * numStep, text=text);
        } else {
            pillars(v + [0,i], offset - i * numStep);
        }
    }

    vEnd = [v.x, v.y + num -1];
    for (w = ltrs) bridgeLeftRight(vEnd,w[0]);
    for (w = rtls) bridgeLeftRight(w[0],vEnd);
    for (w = rtrs) bridgeRightRight(w[0],vEnd);
    for (w = ltls) bridgeLeftLeft(w[0],vEnd);
}

module bank() {
    difference() {
        union() {
            seat(s5, ltrs=[], rtls=[s10], ltls=[s10], text="5");
            seat(s6, ltrs=[s10], rtls=[s11], text="6");
            seat(s7, ltrs=[s11], rtls=[s12], text="7");
            seat(s8, ltrs=[s12], rtls=[s13], text="8");
            seat(s9, ltrs=[s13], rtls=[], rtrs=[s13], text="9");

            seat(s10, ltrs=[s14], rtls=[s15], ltls=[s14], text="10");
            seat(s11, ltrs=[s15], rtls=[s16], text="11");
            seat(s12, ltrs=[s16], rtls=[s17], text="12");
            seat(s13, ltrs=[s17], rtls=[s18], rtrs=[s18], text="13");

            seat(s14, ltrs=[], rtls=[s19], text="14");
            seat(s15, ltrs=[s19], rtls=[s20], text="15");
            seat(s16, ltrs=[s20], rtls=[s21], text="16");
            seat(s17, ltrs=[s21], rtls=[s22], text="17");
            seat(s18, ltrs=[s22], rtls=[], text="18");

            seat(s19, ltrs=[], rtls=[s23], text="19");
            seat(s20, ltrs=[s23], rtls=[s24], text="20");
            seat(s21, ltrs=[s24], rtls=[s25], text="21");
            seat(s22, ltrs=[s25], rtls=[], text="22");

            seat(s23, text="23");
            seat(s24, text="24");
            seat(s25, text="25");
        }
        union() {
            seatCoins(s5);
            seatCoins(s6);
            seatCoins(s7);
            seatCoins(s8);
            seatCoins(s9);

            seatCoins(s10);
            seatCoins(s11);
            seatCoins(s12);
            seatCoins(s13);

            seatCoins(s14);
            seatCoins(s15);
            seatCoins(s16);
            seatCoins(s17);
            seatCoins(s18);

            seatCoins(s19);
            seatCoins(s20);
            seatCoins(s21);
            seatCoins(s22);

            seatCoins(s23);
            seatCoins(s24);
            seatCoins(s25);
        }
    }
}

/* ========================================================================= */
/* == Cover ================================================================ */
/* ========================================================================= */

module counterPillars(c, offset=0) {
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
                cube([20,15,boxH]);
            }
        }
    }
}

module boxSupport() {
    intersection() {
        rotate([0,0,-45])
            difference() {
                translate([-14,-14,1])
                    cube([28,28,boxH - 1]);
                translate([-6,-6,-0.5])
                    cube([25,25,boxH + 1]);
            }
        translate([-15,-15,-0.5])
            cube([16,30,boxH + 1]);
    }
}

module boxSupports() {
    /* Supports 1 */
    difference() {
        translate([-108,44,0])
            rotate([0,0,180])
            boxSupport();
        translate([-e * 1.4,0,0.9])
            union() {
                seat(s5, ltrs=[], rtls=[], ltls=[s10]);
                hull() seat([s10[0],s10[1]+3,s10[2]]);
                seat([s10[0],s10[1]+3,s10[2]], ltrs=[], rtls=[], ltls=[s14]);
            }
    }
    difference() {
        translate([108,49,0])
            boxSupport();
        translate([e * 1.4,0,0.9])
            union() {
                seat(s9, ltrs=[], rtls=[], rtrs=[s13]);
                hull() seat([s13[0],s13[1]+3,s13[2]]);
                seat([s13[0],s13[1]+3,s13[2]], ltrs=[s17], rtls=[], rtrs=[s18]);
            }
    }

    /* Supports 2 */
    difference() {
        translate(coordsToPos([-2.5,12.5]) + toRight + [-5,-4.75,1])
            cube([10,9.5,boxH-1]);
        translate([-e * 1.4,0,0.9])
            seat(s19);
    }
    difference() {
        translate(coordsToPos([2.5,12]) + toLeft + [-5,-4.75,1])
            cube([10,9.5,boxH-1]);
        translate([e * 1.4,0,0.9])
            seat(s22);
    }

    /* Supports 3 */
    difference() {
        translate(coordsToPos([-2,15]) + toRight + [-5,-4.75,1])
            cube([10,9.5,boxH-1]);
        translate([-e * 1.4,0,0.9])
            seat(s23);
    }
    difference() {
        translate(coordsToPos([2,15]) + toLeft + [-5,-4.75,1])
            cube([10,9.5,boxH-1]);
        translate([e * 1.4,0,0.9])
            seat(s25);
    }

    /* Supports 4 */
    difference() {
        union() {
            difference() {
                translate(coordsToPos([0,15.5]) + toRight + [-(6+2),-3.3,1])
                    cube([12,6.3,boxH-1]);
                translate([-e * 1.4,0,0.9])
                    seat(s25);
            }
            difference() {
                translate(coordsToPos([0,15.5]) + toLeft + [-(6-2),-3.3,1])
                    cube([12,6.3,boxH-1]);
                translate([e * 1.4,0,0.9])
                    seat(s23);
            }
        }
        hull() {
            translate([0,e,0.9])
                seat(s24);
        }
    }
}

module boxSupportGaps() {
    translate([-119,44,0])
        rotate([0,0,45])
        translate([-12.5,-12.5,-0.5])
        cube([25,25,boxH+1]);
    translate([119,49,0])
        rotate([0,0,45])
        translate([-12.5,-12.5,-0.5])
        cube([25,25,boxH+1]);
}

module bankLid() {
    reverseHolders = false;
    thicknesF = 2;
    thicknesB = 4;
    color(c="Tan")
        difference() {
            union() {
                hull() {
                    for (s=ss) {
                        v = s[0];
                        num = s[2];
                        for ( i = [0 : num-1] ) {
                            translate(coordsToPos(v + [0,i]) + 
                                    [-(width + 4) / 2, -5,boxH - thicknesF])
                                cube([width+4,10,thicknesF]);
                        }
                    }
                    translate([97,107,0])
                        rotate([0,0,-45])
                        translate([-width/2,-5,boxH - thicknesB])
                        cube([width,10,thicknesB]);
                    translate([-97,107,0])
                        rotate([0,0,45])
                        translate([-width/2,-5,boxH - thicknesB])
                        cube([width,10,thicknesB]);
                }
                for (s=ss) {
                    v = s[0];
                    offset = s[1];
                    num = s[2];
                    for ( i = [0 : num-1] ) counterPillars(v + [0,i], offset - i * numStep);
                }

                if (reverseHolders) {
                    translate([97,107,0])
                        rotate([0,0,-45])
                        translate([-width/2,-5,boxH-28])
                        cube([width,10,28]);
                    translate([-97,107,0])
                        rotate([0,0,45])
                        translate([-width/2,-5,boxH-28])
                        cube([width,10,28]);
                }

                boxSupports();
                for (s=[[[-2,2]     , -6, 1],
                        [[-1,1.5]   , -6, 2],
                        [[0,1]      , -6, 2],
                        [[1,1.5]    , -6, 2],
                        [[2,2]      , -6, 2],
                        s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22]){
                    v = s[0];
                    num = s[2];
                    hull() {
                        for ( i = [0 : num-1] ) {
                            translate(coordsToPos(v + [0,i]) + [0,0,boxH-3])
                                rotate([0,0,30])
                                cylinder(3,24/2,26/2,$fn=6,center=true);
                        }
                    }
                }

            }
            union () {
                for (s=ss) {
                    v = s[0];
                    offset = s[1];
                    num = s[2];
                    for ( i = [0 : num-1] ) coinPlusE(v + [0,i],offset - i  * numStep, ePlus=0.2);
                }
                /* hex holes */
                for (s=[[[-2,2]     , -6, 1],
                        [[-1,1.5]   , -6, 2],
                        [[0,1]      , -6, 2],
                        [[1,1.5]    , -6, 2],
                        [[2,2]      , -6, 2],
                        s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22]){
                    v = s[0];
                    num = s[2];
                    hull() {
                        for ( i = [0 : num-1] ) {
                            translate(coordsToPos(v + [0,i]) + [0,0,boxH])
                                rotate([0,0,30])
                                cylinder(10,20/2,21/2,$fn=6,center=true);
                        }
                    }
                }

                translate(coordsToPos(s23[0]) + [-7,-3.2, 35])
                    cube([14,6.4,boxH-20]);
                translate(coordsToPos(s24[0]) + [-14,-3.2, 35])
                    cube([28,6.4,boxH-20]);
                translate(coordsToPos(s25[0]) + [-17,-3.2, 35])
                    cube([34,6.4,boxH-20]);

                if (reverseHolders) {
                    translate([97,107,0])
                        rotate([0,0,-45])
                        coinPlusE([0,0], ePlus=0.1);
                    translate([-97,107,0])
                        rotate([0,0,45])
                        coinPlusE([0,0], ePlus=0.1);
                }

                boxSupportGaps();
            }
        }
}

/* ========================================================================= */
/* == Main ================================================================= */
/* ========================================================================= */

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

module noPart(){
    if (justOnePart == ""){
        children();
    }
}

part("Nidavellir-Bank.stl") bank();
noPart() coins();
part("Nidavellir-BankLid.stl") bankLid();

noPart() translate([-250,0,60]) rotate([0,180,0]) bankLid();

noPart() translate([250,0,0]) bank();

