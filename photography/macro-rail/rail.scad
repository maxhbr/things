mode="develop"; // [ "print", "develop" ]

$fn=100;


railStl="./HiWin-KK5002P/KK5002P150A1F000_FILE_2.stl";

module mirror_horizontally() {
  children();
  mirror([1,0,0]) children();
}

module m4screw(h=10,dh=4) {
  cylinder(d=4.6,h=h,$fn=100);
  translate([0,0,dh]) cylinder(d=6,h=h,$fn=100);
}

module insert(d,h) {
  translate([0,0,-h])
  cylinder(d=d,h=h,$fn=100);
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

module feet() {
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
      translate([30,0,-9]) m4screw(dh=9);
    }
  }
}


if (mode == "develop") {
  if ($preview) {
    color("lightgray") import(railStl, convexity=3);
    color("gray")
      translate([0,45-10,-19]) 
      rotate([0,90,90])
      import("./vslot/Master_20_x_80_V_Slot_small.stl", convexity=3);
  }

  translate([0,45,0]) feet();
  translate([0,45+80,0]) mirror([0,1,0]) feet();

  translate([0,88+25,26]) carrigeToClamp();


  if ($preview) {
    color("lightblue") {
      translate([100,0,0]) {
        render() difference() {
          carrigeToClamp();
          cube([100,100,100]);
          rotate([0,0,45]) cube([100,100,100]);
        }
      }
      translate([-100,0,0]) {
        feet();
      }
    }
  }
} else {
  carrigeToClamp();
  translate([0,42,0]) rotate([180,0,0]) feet();
  translate([0,-42,0]) rotate([180,0,0]) feet();
}
