mode="develop"; // [ "print", "develop", "carrigeToClamp", "motorAdapterFlangeF3", "feetArcaSwiss" ]
mount_translate_x = 0; // [ 0, -200 ]

$fn=100;




module mirror_horizontally() {
  children();
  mirror([1,0,0]) children();
}

module mirror_vertically() {
  children();
  mirror([0,1,0]) children();
}

module mirror_both_directions() {
  mirror_vertically() mirror_horizontally() children();
}

module rotate_four_fold() {
  children();
  rotate([0,0,90]) children();
  rotate([0,0,180]) children();
  rotate([0,0,270]) children();
}

module m3screw(h=10,dh=4, addD=0) {
  cylinder(d=3.5,h=h,$fn=100);
  translate([0,0,dh]) cylinder(d=6+addD,h=h,$fn=100);
}

module m4screw(h=10,addH=0, addD=0) {
  cylinder(d=4.6,h=h,$fn=100);
  translate([0,0,h]) cylinder(d=8+addD,h=addH,$fn=100);
}

module insert(d,h) {
  translate([0,0,-h])
  cylinder(d=d,h=h,$fn=100);
}

module m3insert(addH=0) {
  insert(4,5.7+addH);
}

module m4insert(addH=0) {
  insert(5.6,9.1+addH);
}

module m5insert() {
  insert(6.4,9.5);
}
module m5insertShort(addH=0) {
  insert(6.4,5.8+addH);
}


module carrigeToClamp(){
  holeXDist = 25;
  holeYDist = 30;
  clampDiameter = 60;
  clampHoleRadius = 20.5;
  clampHeight = 38.5 - 26 + 4;
  baseHeight = 4;
  render()
  mirror_horizontally() {
    intersection() {
      difference() {
        union() {
          intersection () {
            hull() {
                translate([holeXDist/2,holeYDist/2,0]) hull() {
                  cylinder(d=20-4, h=baseHeight, $fn=6);
                  cylinder(d=20, h=baseHeight-2, $fn=6);
                }
                translate([holeXDist/2,-holeYDist/2,0])  hull() {
                  cylinder(d=20-4, h=baseHeight, $fn=6);
                  cylinder(d=20, h=baseHeight-2, $fn=6);
                }
            }
            hull() {
              translate([0,-40,1])
                cube([20,80,baseHeight]);
              translate([0,-40,0])
                cube([20-1,80,baseHeight]);
            }
          }
          translate([0,-20,0]) cube([10,40,baseHeight]);
          // /*rotate_four_fold()*/ hull() {
            //mirror_horizontally() {
              rotate_four_fold() hull() {
                translate([clampHoleRadius-5,0,0]) rotate([0,0,30]) cylinder(h=clampHeight,d=10, $fn=6);
                translate([clampHoleRadius,0,clampHeight - 2]) {
                  intersection() {
                    union() {
                      rotate([0,0,30]) cylinder(h=2,d=30, $fn=6);
                      translate([-clampHoleRadius,0,0]) difference() {
                        cylinder(d=25,h=2,$fn=100);
                        cylinder(d=23,h=2,$fn=100);
                      }
                    }
                    cube([30,19,20], center=true);
                  }
                }
              }
           // }
          //}

          rotate_four_fold() hull() {
            translate([-10,-2.5,clampHeight]) cube([20,5,1]);
            translate([-10,-1.5,0]) cube([20,3,1]);
          }
        }

        mirror_both_directions() translate([holeXDist/2,holeYDist/2,0]) m4screw(h=baseHeight,addH=0);
        // hull() { translate(t + [0,0,clampHeight-9.5]) m5insert(); translate(t) cylinder(d=13, h=1, $fn=100); }
        rotate_four_fold() translate([clampHoleRadius,0,clampHeight]) m5insert();
        rotate([0,0,360/16]) cylinder(d=18, h=baseHeight, $fn=8);
        rotate([0,0,360/8]) translate([0,0,baseHeight]) cylinder(d1=24,d2=0,h=clampHeight-baseHeight -1, $fn=4);
      }
      cylinder(d=clampDiameter, h=clampHeight+10);
    }


    translate([0,0,clampHeight-2]) {
      difference() {
        intersection() {
          cylinder(d=clampDiameter, h=2);
          cube([100,100,100]);
        }
        cylinder(d=clampDiameter-8, h=2);
      }
    }

  }
}

module carrigeToClampV2(){
  holeXDist = 25;
  holeYDist = 30;
  clampDiameter = 60;
  clampHoleRadius = 20.5;
  clampHeight = 38.5 - 26 + 4;
  baseHeight = 6;
  render()
  mirror_both_directions()
  difference() {
    union() {
      hull () {
        mirror_both_directions() 
        translate([holeXDist/2,holeYDist/2,baseHeight/2]) { 
          hull() {
            cube([10,20-2,baseHeight], center=true);
            cube([10-2,20,baseHeight], center=true);
          }
          rotate([0,0,30]) cylinder(d=18, h=baseHeight, center=true, $fn=6);
        }
        translate([0,0,clampHeight-1]) cylinder(d=clampDiameter, h=1, $fn=200);
        mirror_both_directions() rotate([0,0,2]) cylinder(d=46,h=1,$fn=6);
      }
      translate([0,0,clampHeight]) rotate_four_fold() hull() {
        translate([-9,-2.5,0]) cube([18,5,1]);
        translate([-10,-1.5,0]) cube([20,3,1]);
        translate([-8,-1.5,0]) cube([16,3,2]);
      }
    }
    mirror_both_directions() translate([holeXDist/2,holeYDist/2,0]) m4screw(h=baseHeight,addH=clampHeight, addD=4.5);
    rotate_four_fold() translate([clampHoleRadius,0,clampHeight]) m5insert();
    rotate_four_fold() translate([clampHoleRadius,0,0]) cylinder(d=5.5, h=clampHeight); 
    hull() {
      cube([15,20,2], center=true);
      cylinder(h=clampHeight-1, d1=10, d2=0);
    }
  }
}


module feetVslot() {
  holeXDist = 25;
  reailWidth = 50;
  render()
  mirror_horizontally() {
    difference() {
      union() {
        hull()
          translate([0,0,-9]) {
            hull() {
              translate([0,-15,2]) cube([25,30,9-4]);
              translate([0,-15+2,0]) cube([25,30-4,9]);
            }
            translate([30,0,0])
            hull() {
              cylinder(d=20, h=9-2, $fn=100);
              cylinder(d=20-2, h=9, $fn=100);
            }
          }
          translate([10,0,-9])
          intersection() {
            hull() {
              rotate([0,45,0]) translate([-3,-7,-3]) cube([6,14,6]);
              translate([-2,-10,0]) cube([4,20,2]);
            }
            translate([-10,-20,-2]) cube([20,40,2]);
          }
      }
      translate([holeXDist/2,0,0]) m4insert(addH=10);
      m5insertShort(addH=10);
      translate([30,0,-9]) m4screw(addH=0);
    }
  }
}

module feetArcaSwiss() {
  holeXDist = 25;
  height = 9;
  render() 
  translate([0,40,0])
  mirror_vertically() 
  mirror_horizontally()
  translate([0,-40,0])
  render() {
    difference() {
      union() {
        hull() {
          translate([holeXDist/2,0,0]) {
            cylinder(d=15-2,h=height, $fn=8);
          }
          translate([0,-20,0]) hull() {
            difference() {
              cylinder(d=40-4, h=height, $fn=10);
              translate([0,-20+4,height]) cube([40,4,2], center=true);
            }
            cylinder(d=40, h=height-4, $fn=10);
          }
        }
        translate([holeXDist/2-10/2,0,0]) cube([10,40,height]);
        //translate([0,-10,0]) cube([10,50,2]);
        translate([0,-20,0]){
        }
        difference() {
          translate([-10,15,0]) cube([20,50/2,height]);
          d=15;
          off=3;
          translate([0,d-off/2,0]) cylinder(d=16+off, h=height,$fn=6);
          translate([0,80-d+off/2,0]) cylinder(d=16+off, h=height,$fn=6);
        }
      }
      translate([holeXDist/2,0,height]) m4insert();
      translate([0,40,0]) hull() {
        translate([0,0,height]) cube([15,40,2], center=true);
        translate([0,-2,height+2]) cube([19,44,4], center=true);
      }
      for(dy=[-20,40]) {
        translate([0,dy,0]) hull() {
          translate([0,0,height]) cube([8,80,2], center=true);
          translate([0,0,height+2]) cube([12,80,4], center=true);
        }
        //translate([0,dy,height]) m4insert();
        //translate([0,dy-10,height]) m4insert();
        //translate([0,dy+10,height]) m4insert();
        translate([0,dy,0]) rotate([180,0,0]) m5insertShort(addH=10);
        translate([0,dy-12,0]) rotate([180,0,0]) m5insertShort(addH=10);
        translate([0,dy+12,0]) rotate([180,0,0]) m5insertShort(addH=10);
      }
      hull() {
        translate([holeXDist/2+10-10/2-3,10,(9-1)/2]) cube([10,30,1]);
        translate([holeXDist/2+10-10/2,6,(9-7)/2]) cube([10,34,7]);
      }
      mirror_horizontally() color("red") hull(){
        translate([11,-27,1]) cylinder(h=height+2, d=2);
        translate([11,-10,1]) cylinder(h=height+2, d=2);
        translate([14,-10,1]) cylinder(h=height+2, d=2);
      }

    }
  }
}

module motorAdapterFlangeF3() {
  height=7;
  width=49;
  depth=40;
  holeDistance=31;
  render()
  difference() {
    union() {
      translate([0,0,3.5])
        hull() {
          cube([width,depth-3,height],center=true);
          translate([0,1,0]) cube([width-3,depth+2,height],center=true);
          translate([0,-5,0]) cube([width+4,20,height],center=true);
        }
      // translate([-25,0,0]) {
      //   difference() {
      //     hull() {
      //       translate([0,0,1]) cylinder(h=5-2, r=9);
      //       cylinder(h=5, r=9-1);
      //       translate([0,-8,0]) {
      //         translate([0,0,1]) cylinder(h=5-2, r=9);
      //         cylinder(h=5, r=9-1);
      //       }
      //     }
      //     translate([-3,0,0]) hull() {
      //       cylinder(h=5, r=2);
      //       translate([0,-8,0]) cylinder(h=5, r=2);
      //     }
      //   }
      // }
    }
    cylinder(h=height, d=24);
    mirror_horizontally() {
      translate([1,1,0] * (holeDistance/2)) m3screw(addD=3.5);
      translate([1,-1,0] * (holeDistance/2)) m3screw();
    }
    mirror_horizontally() {
      for(t=[[21.5,-1.5,0],[21.5,-11.5,0]]) {
        translate(t+[0,0,height])
          rotate([0,0,0])
          m3insert();
        translate(t)
          cylinder(d=3.5,h=10);
      }
    }
  }

}

module motorCopuling() {
  render()
  difference() {
    cylinder(h=25, d=19);
    cylinder(h=25, d=5);
    cube([20,20,25]);
  }
}

module ledMount() {
  holeDistance=24;
  render()
  difference() {
    hull() {
      mirror_horizontally() {
        translate([holeDistance/2,0,0]) {
          cylinder(d=10-2,h=4);
          cylinder(d=10,h=4-2);
        }
      }
    }
    mirror_horizontally() translate([holeDistance/2,0,0]) m3screw();
  }
}


if (mode == "develop") {
  mount_translate = [mount_translate_x,0,0];
  if ($preview) {

    // railStl="./HiWin-KK5002P/KK5002P150A1F000_FILE_2.stl";
    railStl="./HiWin-KK5002P/KK5002P150A1F00SA_FILE_1.stl";
    color("lightgray",0.8) import(railStl, convexity=3);

    translate(mount_translate) {
      color("gray",0.8)
        translate([0,45-10,-19]) 
        rotate([0,90,90])
        import("./vslot/Master_20_x_80_V_Slot_small.stl", convexity=3);
      translate([0,0,-9]) rotate([-90,0,0]) translate([-40,0,0]) import("./vslot/80x20_vslot_endcap.stl", convexity=3);
      color("gray") translate([200-20,0,-19]) scale([1,4/3,1]) rotate([90,0,180]) import("./arcaswiss/150mm_Arcaswiss_Style_Rail.stl", convexity=3);
    }

    color("gray",0.8) translate([-3,260,16]) rotate([90,0,0]) import("./motors/NEMA_17.stl", convexity=3);
    color("darkgray") translate([0,220-11,16]) rotate([90,0,0]) motorCopuling();

  }

  translate(mount_translate) {
    translate([0,45,0]) feetVslot();
    translate([0,45+80,0]) mirror([0,1,0]) feetVslot();
  }

  translate([0,88+25,26]) carrigeToClampV2();

  translate([0,220+7,16]) rotate([90,0,0]) motorAdapterFlangeF3();

  translate([0,5,35.5 + 0.5]) ledMount();

  translate(mount_translate) {
    translate([200,45,-9]) feetArcaSwiss();
  }


  if ($preview) {
    color("lightblue") {
      translate([100,0,0]) {
        render() difference() {
          carrigeToClampV2();
          cube([100,100,100]);
          rotate([0,0,45]) cube([100,100,100]);
          translate([-100,-120,0]) cube([100,100,100]);
        }
      }
      translate([100,100,0]) {
        render() difference() {
          feetArcaSwiss();
          translate([0,40,0]) cube([100,100,100]);
          translate([-100,70,0]) cube([100,100,100]);
        }
      }
      translate([-100,0,0]) {
        feetVslot();
      }
      translate([-100,100,0]) {
        motorAdapterFlangeF3();
      }
    }
  }
} else if (mode == "carrigeToClamp") {
  carrigeToClamp();
  if ($preview) {
    color("lightblue") {
      translate([100,0,0]) {
        render() difference() {
          carrigeToClamp();
          cube([100,100,100]);
          rotate([0,0,45]) cube([100,100,100]);
        }
      }
    }
  }
} else if (mode == "carrigeToClampV2") {
  carrigeToClampV2();
  if ($preview) {
    color("lightblue") {
      translate([100,0,0]) {
        render() difference() {
          carrigeToClampV2();
          cube([100,100,100]);
          rotate([0,0,45]) cube([100,100,100]);
        }
      }
    }
  }
} else if (mode == "motorAdapterFlangeF3") {
  motorAdapterFlangeF3();
} else if (mode == "feetArcaSwiss") {
  feetArcaSwiss();
} else {
  translate([0,-10,0]) carrigeToClampV2();
  translate([52,0,0]) rotate([180,0,90]) feetVslot();
  translate([-52,0,0]) rotate([180,0,90]) feetVslot();
  translate([0,50,0])
  motorAdapterFlangeF3();
  translate([0,-65,0])
  rotate([0,0,90])
  translate([0,-40,0]) feetArcaSwiss();
  if ($preview) {
    color("lightblue") {
      difference() {
        cube([250,250,2], center=true);
        cube([248,248,3], center=true);
      }
    }
  }
}
