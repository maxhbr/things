

module start() {
    translate([-20,0,0]){
        translate([-20,0,-14])
        color("green")
        rotate([90,0,0])
        linear_extrude(50)
        polygon(points=[[2,0],[0,2],[0,20],[20,20],[20,14],[10,14],[10,12],[11,8],[11,2],[9,0]],convexity=10);

        color("red")
        rotate([0,0,-90])
        linear_extrude(6)
        polygon(points=[[0,0],[0,20],[10,20],[10,10],[20,0]],convexity=10);
    }

    color("yellow")
    rotate([90,180,0])
    linear_extrude(10)
    polygon(points=[[0,0],[0,5],[10,5],[12,2],[12,0]],convexity=10);

    color("blue")
    rotate([-90,0,90])
    linear_extrude(10)
    polygon(points=[[0,-2],[-10,5],[5,15],[20,15],[35,0],[35,-6],[25,-6],[25,-2],[15,3],[10,3]],convexity=10);
}

module wedge(t) {
    translate(t)
    rotate([0,0,45])
    cube([5,5,100], center=true);
}

module hwedge(t) {
    translate(t)
    rotate([90,0,0])
    rotate([0,0,45])
    cube([5,5,100], center=true);
}

module doublewedge(t) {
    translate(t)
    hull() {
        cube([7,5,100], center=true);
        cube([1,25,100], center=true);
    }
}


module final() {
    difference() {
    start();
    wedge([0,-10,0]);
    wedge([0,35,0]);
    wedge([-10,35,0]);
    wedge([-40,0,0]);
    wedge([-40,-50,0]);
    wedge([-20,-50,0]);
    wedge([-13,-10,-50]);
    wedge([-29,0,-50]);
    wedge([-29,-50,-50]);
    hwedge([0,0,-15]);
    hwedge([-10,0,-15]);
    doublewedge([1,12.5,0]);
    doublewedge([-11,12.5,0]);
    doublewedge([-41,-25,0]);
    }
}

if($preview) {
    final();
}else {
    mirror([0,0,1]) {
        final();
        translate([10,0,0])
            mirror([1,0,0])
            final();
    }
}
