

d=22;
h=20;
module cutout(fn=100,addD=0,addH=0) {
    cylinder(h=h+addH,d=d+addD,$fn=fn);
}

module cuttedout(addH=0) {
    difference() {
        intersection() {
            minkowski() {
                cutout(fn=6,addD=2,addH=addH);
                translate([0,0,-2]) cylinder(h=2,d1=6,d2=4,$fn=6);
            }
            translate([0,0,addH/2-1]) 
                translate([0,0,-13])
                cylinder(h=50, d1=2,d2=100, $fn=6);
        }
        hull() {
            translate([0,0,addH/2-1]) cutout(addH=addH,addD=-1);
            translate([0,0,addH/2]) cutout(addH=addH);
        }
        translate([0,0,h-1+addH])
        minkowski() {
            cutout();
            cylinder(h=2,d1=0,d2=2,$fn=6);
        }
        translate([0,0,addH/2-1]) translate([0,0,-11]) cylinder(h=10,d1=20,d2=1, $fn=6);
    }
}

module saltstand() {
    offY=2.25;
    offX=-1.0;
    for(t=[[[         0,          0 ,0],0.8*0]
          ,[[         0,     d+offY ,0],0.8*2]
          ,[[         0,2  *(d+offY),0],0.8*4]
          ,[[    d+offX,0.5*(d+offY),0],0.8*6]
          ,[[    d+offX,1.5*(d+offY),0],0.8*8]
          ,[[2*(d+offX),     d+offY ,0],0.8*10]
        ]) {
        translate(t[0])
            cuttedout(addH=t[1]);
    }
}

mirror([0,1,0]) saltstand();
