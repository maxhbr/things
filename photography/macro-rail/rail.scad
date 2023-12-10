mode="develop"; // [ "print", "develop" ]
mount_translate_x = 0; // [ 0, -200 ]

$fn=100;




module mirror_horizontally() {
  children();
  mirror([1,0,0]) children();
}

module mirror_vertically() {
  children();
  mirror([1,0,0]) children();
}

module m3screw(h=10,dh=4) {
  cylinder(d=3.5,h=h,$fn=100);
  translate([0,0,dh]) cylinder(d=6,h=h,$fn=100);
}

module m4screw(h=10,dh=4) {
  cylinder(d=4.6,h=h,$fn=100);
  translate([0,0,dh]) cylinder(d=8,h=h,$fn=100);
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


module carrigeToClamp(){
  holeXDist = 25;
  holeYDist = 30;
  clampHoleDist = 20.5;
  clampHeight = 38.5 - 26 + 4;
  baseHeight = 4;
  render()
  mirror_horizontally() {
    difference() {
      union() {
        intersection () {
          hull() {
              translate([holeXDist/2,holeYDist/2,0]) hull() {
                cylinder(d=20-4, h=baseHeight);
                cylinder(d=20, h=baseHeight-2);
              }
              translate([holeXDist/2,-holeYDist/2,0])  hull() {
                cylinder(d=20-4, h=baseHeight);
                cylinder(d=20, h=baseHeight-2);
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
        hull() {
          mirror_horizontally() {
            translate([10,0,0]) cylinder(h=clampHeight,d1=18,d2=15);
          }
        }
        rotate([0,0,90])
          hull() {
            mirror_horizontally() {
              translate([10,0,0]) cylinder(h=clampHeight,d1=17,d2=13);
            }
          }
        hull(){
          translate([0,0,clampHeight-2])
          cylinder(h=2, d=37, $fn=100);
          cylinder(h=2, d=10, $fn=100);
        }

        translate([0,0,clampHeight]) {
          translate([-4,-1,0]) cube([8,2,1]);
          translate([-1,-4,0]) cube([2,8,1]);
        }
      }

      mirror_horizontally() {
        translate([holeXDist/2,holeYDist/2,0]) m4screw(clampHeight,dh=baseHeight);
        translate([holeXDist/2,-holeYDist/2,0]) m4screw(clampHeight,dh=baseHeight);

        for (t = [ [clampHoleDist/2,0,0],
                   [-clampHoleDist/2,0,0],
                   [0,clampHoleDist/2,0],
                   [0,-clampHoleDist/2,0]
                 ]) {
          translate(t + [0,0,clampHeight]) m5insert();
          hull() {
            translate(t + [0,0,clampHeight-9.5]) m5insert();
            translate(t) cylinder(d=13, h=1, $fn=100);
          }
        }
      }
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
      translate([30,0,-9]) m4screw(dh=9-4);
    }
  }
}

module feetArcaSwiss() {
  holeXDist = 25;
  height = 9;
  render() 
  mirror_horizontally() {
    difference() {
      union() {
        for(t=[[0,0,0],[0,80,0]]) {
          translate([holeXDist/2,0,0] + t) hull() {
            cylinder(d=20-2,h=height);
            translate([0,0,2]) cylinder(d=20,h=height-4);
          }
        }
        translate([holeXDist/2-10/2,0,0]) cube([10,80,height]);
        translate([0,-10,0]) cube([10,100,3]);
        for(dy=[-20,100]) {
          translate([0,dy,0]){
            difference() {
              hull() {
                cylinder(d=40-4, h=height);
                cylinder(d=40, h=height-4);
              }
              hull() {
                translate([0,0,height]) cube([8,40,4], center=true);
                translate([0,0,height+2]) cube([12,40,4], center=true);
              }
            }
          }
        }
        difference() {
          translate([-10,20,0]) cube([20,40,height - 2]);
          translate([0,8,0]) cylinder(d=30, h=height);
          translate([0,80-8,0]) cylinder(d=30, h=height);
        }
      }
      for(t=[[0,0,0],[0,80,0]]) {
        translate([holeXDist/2,0,height] + t) m4insert();
      }
      for(dy=[-20,40,100]) {
        translate([0,dy,height]) m4insert();
        translate([0,dy-10,height]) m4insert();
        translate([0,dy+10,height]) m4insert();
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
    translate([0,0,3.5])
      hull() {
        cube([width,depth-3,height],center=true);
        cube([width-3,depth,height],center=true);
        translate([0,-5,0])
        cube([width+4,20,height],center=true);
      }
    cylinder(h=height, d=24);
    for(t=[[-1,-1,0],[-1,1,0],[1,1,0],[1,-1,0]]) {
      translate(t*(holeDistance/2)) m3screw();
    }
    color("red")
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

    railStl="./HiWin-KK5002P/KK5002P150A1F000_FILE_2.stl";
    color("lightgray",0.8) import(railStl, convexity=3);

    translate(mount_translate) {
      color("gray",0.8)
        translate([0,45-10,-19]) 
        rotate([0,90,90])
        import("./vslot/Master_20_x_80_V_Slot_small.stl", convexity=3);
      translate([0,0,-9]) rotate([-90,0,0]) translate([-40,0,0]) import("./vslot/80x20_vslot_endcap.stl", convexity=3);
      color("gray") translate([200-20,0,-19]) scale([1,4/3,1]) rotate([90,0,180]) import("./arcaswiss/150mm_Arcaswiss_Style_Rail.stl", convexity=3);
    }

    color("gray",0.8) translate([-3,261,16]) rotate([90,0,0]) import("./motors/NEMA_17.stl", convexity=3);
    color("darkgray") translate([0,220-11,16]) rotate([90,0,0]) motorCopuling();

  }

  translate(mount_translate) {
    translate([0,45,0]) feetVslot();
    translate([0,45+80,0]) mirror([0,1,0]) feetVslot();
  }

  translate([0,88+25,26]) carrigeToClamp();

  translate([0,220+7,16]) rotate([90,0,0]) motorAdapterFlangeF3();

  translate([0,5,35.5 + 0.5]) ledMount();

  translate(mount_translate) {
    translate([200,45,-9]) feetArcaSwiss();
  }


  if ($preview) {
    color("lightblue") {
      translate([100,0,0]) {
        render() difference() {
          carrigeToClamp();
          cube([100,100,100]);
          rotate([0,0,45]) cube([100,100,100]);
        }
      }
      translate([100,100,0]) {
        feetArcaSwiss();
      }
      translate([-100,0,0]) {
        feetVslot();
      }
      translate([-100,100,0]) {
        motorAdapterFlangeF3();
      }
    }
  }
} else {
  carrigeToClamp();
  translate([42,0,0]) rotate([180,0,90]) feetVslot();
  translate([-42,0,0]) rotate([180,0,90]) feetVslot();
  translate([0,50,0])
  motorAdapterFlangeF3();
  
}
