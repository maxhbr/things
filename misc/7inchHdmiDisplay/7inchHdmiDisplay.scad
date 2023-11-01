part="bracket"; // ["bracket", "base", "combined"]

$fs=0.5;
$fa=5;

height=115.5;
width=157;

module mirrorHorizontally() {
  children();
  mirror([1,0,0]) {
    children();
  }
}
module mirrorVertically() {
  children();
  mirror([0,1,0]) {
    children();
  }
}
module display() {
    translate([-102/2,-166/2,0])
      cube([102,166,12]);
}






module bracket()  {
  difference() {
    hull(){
      mirrorHorizontally() {
        translate([-102/2,-166/2,0])
          cylinder(r=10, h=11, $fn=100);
        translate([-102/2,-166/2,0])
          cylinder(r=12, h=9, $fn=100);
        translate([-102/2,-166/2+30,4])
          cylinder(r=10, h=7, $fn=100);
        translate([-102/2,-166/2+30,6])
          cylinder(r=12, h=3, $fn=100);
      }
    }
    display();
    hull() {
      translate([0,0,10])
        display();
      translate([0,0,12])
        minkowski() {
          display();
          cylinder(r=2, h=1, $fn=100);
        }
    }
    translate([0,-300,0])
      cylinder(r=213, h=15, $fn=100);
    translate([0,130,0])
      cylinder(r=183, h=15, $fn=100);
    // inserts
    mirrorHorizontally()
      translate([-115.5/2,-157/2,0])
      cylinder(r=2, h=9, $fn=100);
    hull()
      mirrorHorizontally()
      translate([30,0,-4])
      rotate([90,0,0])
      cylinder(r=7, h=200);

  }
}






// module screw() {
//     cylinder(d=3.2,h=15);
// }

module left() {
    translate([-width/2,-height/2,0]) {
        hull() {
            cylinder(d=7,h=10);
            translate([10,5,8])
                cylinder(d=15,h=2);
        };
        hull() {
            translate([10,5,5])
                cylinder(d1=3,d2=5,h=5);
            translate([width/2,5+30,8])
                cylinder(d1=3,d2=5,h=2);
        };
    };
    translate([-width/2,height/2,0]) {
        hull() {
            cylinder(d=7,h=10);
            translate([5,-10,8])
                cylinder(d=15,h=2);
        };
        hull() {
            translate([5,-10,5])
                cylinder(d1=3,d2=5,h=5);
            translate([width/2,-10,8])
                cylinder(d1=3,d2=5,h=2);
        };
        hull() {
            translate([5,-10,5])
                cylinder(d=5,h=5);
            translate([width/2,-height+5+30,8])
                cylinder(d=15,h=2);
        };
    };
    hull() {
        translate([-width/2,-height/2,0]) {
            translate([10,5,8])
                cylinder(d=15,h=2);
        };
        translate([-width/2,height/2,0]) {
            translate([width/2,-height+5+30,8])
                cylinder(d=15,h=2);
            translate([5,-10,8])
                cylinder(d=15,h=2);
            translate([width/2,-10,8])
                cylinder(d=15,h=2);
        };
    };
}

module base() {
  rotate([0,180,90]) {
    difference() {
      union() {
        difference() {
            union() {
                left();
                mirror([1,0,0]) left();
            };
            for (t=[[-width/2,-height/2,-1]
                  ,[-width/2,height/2,-1]
                  ,[width/2,-height/2,-1]
                  ,[width/2,height/2,-1]]) {
                translate(t)
                    cylinder(d=2.4,h=20);
                translate(t + [0,0,4])
                    cylinder(d=4.5,h=20);
            };
        };
        intersection() {
          hull() {
            translate([0,-28,33])
              rotate([-90,0,0])
              cylinder(r=28,h=83,$fn=100); 
            translate([0,-32,33])
              rotate([-90,0,0])
              cylinder(r=26,h=87,$fn=100); 
          }
          translate([-100,-100,0])
            cube([200,200,10]);
        }

        difference() {
          hull() {
            translate([0,60,0])
              rotate([-90,0,0])
              cylinder(r=4+3.3,h=14);
            intersection() {
              translate([0,53,33])
                rotate([-90,0,0])
                cylinder(r=28,h=18,$fn=100); 
              translate([-12,-200,0])
                cube([24,400,10]);
            }

          }
          translate([0,61,0])
            rotate([-90,0,0])
            cylinder(r=4,h=13);
        }
      }
          translate([0,-58,19])
            rotate([-90,0,0])
            cylinder(r=10,h=183,$fn=100); 
          mirrorHorizontally() {
            translate([12,40,0]) cube([2,6,20]);
            translate([12,0,0]) cube([2,6,20]);
          }
      mirrorVertically()
        mirrorHorizontally()
        translate([58/2,49/2,0]) {
          cylinder(d=2.75, h=40, $fn=100, center=true);
          translate([23-13,0,0])
            cylinder(d=2.75, h=40, $fn=100, center=true);
          translate([-13,0,0])
            cylinder(d=2.75, h=40, $fn=100, center=true);
          translate([49-13,0,0])
            cylinder(d=2.75, h=40, $fn=100, center=true);
        }
      mirrorHorizontally()
        translate([170, 0, 0]) {
        cylinder(d=200, h=40, $fn=100, center=true);
      }
    }
  }
}



if(part=="bracket") {
  mirrorVertically() {
    rotate([0,180,0])
    bracket();
  }

} else if(part=="base") {
  base();
} else if(part=="combined") {
  if ($preview) {
    translate([0,0,1.6]) {
      color("black") display();
    }
  }
  translate([0,0,1.6]) {
    render() {
      bracket();
      mirror([0,1,0]) {
        bracket();
      }
    }
  }

  base();
}