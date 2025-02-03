include <../../lib.scad>

module outer(innerw, innerl, innerh) {
    difference() {
      translate([0,0,innerh/2]) {
        wedgedCube([innerw,innerl,innerh]);
      }
      children();
    }
}

module cardWedge(alpha=7) {
  rotate([0,alpha,0])
    wedgedCube([59+4,90.5+2,3]);
}

module cards(width,totalh) {
  translate([0,0,8])
  hull() {
    translate([0,0,0]) cardWedge();
    translate([0,0,40]) cardWedge();
  }
  translate([-10,0,11]) cardWedge(alpha=0);
  translate([-10,0,0]) wedgedCube([50,50,50],r=6);
  translate([-53.5,0,0]) wedgedCube([54,54,54],r=4);

/*
    hull() {
        cardWedge(width/2, cardh=cardh, totalh=totalh, alpha=alpha);
        cardWedge(-width/2, cardh=cardh, totalh=totalh, alpha=alpha);
    }
    translate([0,width/2,totalh]) wedgedCube([cardh, 20,20],center=true);
    translate([0,width/2,totalh]) rotate([45,0,0]) wedgedCube([cardh, 22,20],center=true);
    */
}


innerw=158;
innerl=218;
innerh=50;
spreadl=4.25;
spreadw=spreadl+4.9;
difference() {
    outer(innerw=innerw, innerl=innerl, innerh=innerh){
      mirrorAndKeeps([[0,1,0]]) {
        mirrorAndKeeps([[1,0,0]])
        translate([-innerw/4-spreadw,innerl/4+spreadl,0]) {
          cards();
          translate([0,0,innerh+7-1]) wedgedCube([120+2,90.5+2+2,2*7]);
        };
        translate([0,55-23,innerh/2+2]) wedgedCube([27,38,innerh]);
        translate([0,71.6,52]) rotate([-45,0,0]) wedgedCube([27,38,2*innerh]);
        translate([0,93,0]) rotate([-45,0,0]) wedgedCube([27,38,2*innerh]);
      };
      mirrorAndKeeps([[1,0,0]])
        translate([-60,0,0]) rotate([0,-45,0]) wedgedCube([38,20,2*innerh]);
          


      translate([0,0,innerh]) wedgedCube([120,210,2*7]);
      translate([0,0,innerh+7-1]) wedgedCube([120+2,210+2,2*7]);
      translate([0,0,innerh-7]) wedgedCube([81,102,2*4]);
      translate([0,0,innerh-7+4-1]) wedgedCube([81+2,102+2,2*4]);
    };
    if ($preview) {
        translate([0,40,-50])
        cube([300,300,200]);
    }
}
if ($preview) {
  for (z=[0,1,2,3,4,35]) {
    translate([-innerw/4-spreadw+0.5,innerl/4+spreadl,7+z])
      rotate([0,7,0])
      cube([59,90.5,0.1], center=true);
  }
}
