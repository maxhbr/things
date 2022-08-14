//interior 68.5 x 67.5 x 93
//First print 67 mm interior

tol = 0.15;
tolH = 0.4;

inWidth = 56+0.4;
inLen = 69+1.5;
inH = 97;

//angle = atan(6/13);
cutAng = 25; //degrees
cutHRel = 0.52; //on outside at middle of cut
thick = 4; //inWidth*8/102; 
clipTopBot = 1; //improve printing of rounded bottom by reducing overhang

rimH = 8;//(inH+2*thick)*13/(120+110); //fraction of 

domeD = 0.55*rimH;
domeH = 1.4-0.4;

roundR = 3;


//echo(rimH);

//InTop();
//Outer();


//projection(cut=true) 
//   translate([0,0,inH/2+3])
//   Box();

translate([-35,0,0])
Bottom();
translate([35,0,0])
rotate([180,0,0])Top();
//InnerRim();

//sphere(r = thick);

module Top() {
    difference() {
        difference() {
            difference() {
                Outer();
                translate([0,0,(cutHRel-0.5)*inH])
                    rotate([cutAng,0,0]) translate([0,0,-1000])  cube([2000,2000,2000],true);
            }
            difference() {
                InnerRim();
                translate([0,0,rimH+tolH+(cutHRel-0.5)*inH])
                    rotate([cutAng,0,0]) translate([0,0,1000])  cube([2000,2000,2000],true);
            }
        }
        Inner();
    }
}

module Bottom() {
    difference() {
        union() {
            difference() {
                Outer();
                translate([0,0,(cutHRel-0.5)*inH])
                    rotate([cutAng,0,0]) translate([0,0,1000])  cube([2000,2000,2000],true);
            }
            difference() {
                InnerRim(tol);
                translate([0,0,rimH+(cutHRel-0.5)*inH])
                    rotate([cutAng,0,0]) translate([0,0,1000])  cube([2000,2000,2000],true);
            }
        }
        Inner();
    }
}


module InTop() {
    cube([inWidth,inLen,inH],true);
}

module Inner() {
    cube([inWidth,inLen,inH],true);
}

module InnerRim(shrinkBy = 0) {
    x = inWidth+thick-2*shrinkBy;
    y = inLen+thick-2*shrinkBy;

    domeDFix = domeD+shrinkBy;
    domeHFix = domeH+shrinkBy;

    domeHScale = domeHFix/(0.5*domeDFix);
    domeSepRel = 0.25;

    difference() {
        cube([x,y,inH],true);

        translate([0,0,]) {
            translate([0,0,rimH/2+(cutHRel-0.5)*inH])
                rotate([cutAng,0,0]) translate([x/2,domeSepRel*y,0]) scale([domeHScale,1,1])sphere(d=domeDFix,$fn=48);

            translate([0,0,rimH/2+(cutHRel-0.5)*inH])
                rotate([cutAng,0,0]) translate([x/2,-domeSepRel*y,0]) scale([domeHScale,1,1])sphere(d=domeDFix,$fn=48);

            translate([0,0,rimH/2+(cutHRel-0.5)*inH])
                rotate([cutAng,0,0]) translate([-x/2,domeSepRel*y,0]) scale([domeHScale,1,1])sphere(d=domeDFix,$fn=48);

            translate([0,0,rimH/2+(cutHRel-0.5)*inH])
                rotate([cutAng,0,0]) translate([-x/2,-domeSepRel*y,0]) scale([domeHScale,1,1])sphere(d=domeDFix,$fn=48);
        }
    }
}


module Box() {
    difference() {
        Outer();
        Inner();
    }
}

module Logo() {
    d=0.3;
    angle=45;
    color("gray") {
        render(convexity = 2) {
            translate([0,14,-d])
                multmatrix(m = [ [0.8, 0.2, 0, 0],
                        [0.1, 1, 0, 0],
                        [0, 0, 1, 0],
                        [0, 0, 0, 1]
                ])
                linear_extrude(d*2)
                text("MIND",
                        font = "Roboto Condensed:style=Bold",
                        size = 23,
                        halign = "center", valign="center");
            translate([0,-14,-d])
                multmatrix(m = [ [0.8, 0.2, 0, 0],
                        [0.1, 1, 0, 0],
                        [0, 0, 1, 0],
                        [0, 0, 0, 1]
                ])
                linear_extrude(d*2)
                text("BUG",
                        font = "Roboto Condensed:style=Bold",
                        size = 30,
                        halign = "center", valign="center");
        }
    }
}

module Outer() {
    nonMinkThick = thick - roundR;

    difference() {
        intersection() {
            minkowski() {
                cube([inWidth+2*nonMinkThick,inLen+2*nonMinkThick,inH+2*nonMinkThick],true);
                sphere(r = roundR,$fn=24);
            }
            cube([2*inWidth,2*inLen,inH+2*thick-clipTopBot],true);

        }
        translate([0,0,(inH+2*thick-clipTopBot)/2]) Logo();
    }
}

if ($preview)
translate([200,0,0]) Outer();
