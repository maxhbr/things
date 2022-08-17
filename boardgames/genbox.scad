
function dsToD(ds, wall, i=0) = (i >= len(ds)-1 ? ds[i] : ds[i] + dsToD(ds, wall, i+1) + wall/2);

module boxInner(w, h, d, eps) {
    cube([d,w,h], center=true);
}

module rim(w, d, wall, nibsies=false) {
    difference() {
        union() {
            translate([0,-(w+wall)/2,-15]){
                cube([d+2*wall,wall,10], center=true);
                if (nibsies) {
                    translate([(d-10)/2,0.7,0])
                        sphere(r=3,$fn=60);
                    translate([-(d-10)/2,0.7,0])
                        sphere(r=3,$fn=60);
                }

            }
            hull() {
                translate([0,-(w-wall)/2,-15])
                    cube([d+2*wall,wall,10], center=true);
                translate([0,(w+wall)/2,15]) {
                    cube([d+2*wall,wall,10], center=true);
                }
            }
            translate([0,(w+wall)/2,15]) {
                if (nibsies) {
                    translate([(d-10)/2,-0.7,0])
                        sphere(r=3,$fn=60);
                    translate([-(d-10)/2,-0.7,0])
                        sphere(r=3,$fn=60);
                }
            }
        }
        for (m=[[1,1],[1,-1],[-1,-1],[-1,1]]) {
            translate([(d+2*wall)*m[0],(w+2*wall)*m[1],0]/2) rotate([0,0,45])
                cube([2,2,100], center=true);
        }
    }
}

module wedges(w,d,wall) {
    r=1.4;
    translate([0,-(w+wall)/2,-15]){
        translate([0,wall/2,10/2])
            rotate([45,0,0])
            cube([d,r,r], center=true);
    }
    translate([0,(w-wall)/2,15]){
        translate([0,wall/2,10/2])
            rotate([45,0,0])
            cube([d,r,r], center=true);
    }
}

module window(w,d) {
    scale([1,1.5,2.3])
        rotate([0,90,0])
        cylinder(d=w/2, h=d*2,center=true,$fn=6);
}

module bottom(w, h, d, ds, wall, window) {
    difference() {
        union() {
            hull() {
                translate([0,0,-(h+wall/2)/2]) {
                    translate([0,0,wall/4])
                        cube([d+wall,w+wall,wall/4], center=true);
                    cube([d+wall-2,w+wall-2,wall/2], center=true);
                }
                translate([0,0,-12])
                    rim(w=w,d=d,wall=wall);
            }
            translate([0,0,-10])
                rim(w=w,d=d,wall=wall);
            translate([0,0,0])
                rim(w=w,d=d,wall=wall/2, nibsies=true);
        }
        boxInner(w=w, h=h, d=d);
        wedges(w=w, d=d, wall=wall);
        if(window)
        window(w=w,d=d);
    }
    if (len(ds) > 1) {
        color("red")
            bottomInlay(w=w, h=h, d=d, ds=ds, wall=wall);
    }
}

module seperator(w, h, wall) {
    intersection() {
        union() {
            translate([0,-(w-6+wall)/2,-h/2-10])
                cube([wall/2,6,h],center=true);
            hull() {
                translate([0,(w-6+wall)/2,-h/2+20])
                    cube([wall/2,6,h],center=true);
                translate([0,-(w-6+wall)/2+6,-h/2-10])
                    cube([wall/2,6,h],center=true);
            }
        }
        cube([wall/2,w+wall,h],center=true);
    }
}

module bottomInlay(w, h, d, ds, wall) {
    translate([-(d-wall/2)/2,0,0])
    for(i = [1:len(ds)]) {
        thisD = dsToD(ds, wall, i=i);
        if (thisD) {
            translate([thisD,0,0])
            seperator(w=w, h=h, wall=wall);
        }

    }
}

module top(w, h, d, wall, window) {
    difference() {
        union() {
            hull() {
                translate([0,0,(h+wall/2)/2]){
                    translate([0,0,-wall/4])
                        cube([d+wall,w+wall,wall/4], center=true);
                    cube([d+wall-2,w+wall-2,wall/2], center=true);
                }
                translate([0,0,7])
                    rim(w=w,d=d,wall=wall);
            }
            translate([0,0,0])
            rotate([180,0,0])
                rim(w=w,d=d,wall=wall);
        }
        render() {
            boxInner(w=w, h=h, d=d);
            translate([0,0,0])
                rim(w=w,d=d,wall=wall/2+0.2);
            bottom(w=w, h=h, d=d, ds=[], wall=wall);
        }
        wedges(w=w, d=d, wall=wall);
        if(window)
        window(w=w,d=d);
        color("gray") translate([0,0,h/2+wall/2]) children();
    }
}

module boxImpl(w, h, ds, wall, window) {

    d=dsToD(ds,wall);
    bottom(w=w, h=h, d=d, ds=ds, wall=wall, window=window);

    translate([0,w+15,0])
        rotate([0,180,0])
        top(w=w, h=h, d=d, wall=wall, window=window)
        children();

    if ($preview) {
        translate([-d-20,0,0])
            bottom(w=w, h=h, d=d, ds=ds, wall=wall, window=window);
        intersection() {
            union() {
                color("green")
                    top(w=w, h=h, d=d, wall=wall, window=window) children();
            }
            translate([-d,-50,-100]) cube([d,100,200]);
        }
    }
}

module box(w=63.5, h=88, ds=[30,10], eps=1, wall=4, window=false) {

    boxImpl(w=w+eps, h=h+eps, ds=[ for (delem = ds) delem+eps ], wall=wall, window=window)
        children();
    if ($preview) {
        color("gray",0.8) boxInner(w=w, h=h, d=dsToD(ds,wall));
    }
}
