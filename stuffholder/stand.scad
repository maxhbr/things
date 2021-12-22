wall=1.5;
width=46;
depth=60;
height=12;


module rombe() {
    rotate([0,90,0])
        linear_extrude(height = 100, center = false, convexity = 10)
        resize([50,46/2])
        circle(10,$fn=6);
}

module v2mod() {
    difference() {
        rotate([90,0,0])
            linear_extrude(height = 46, center = true, convexity = 10)
            polygon(
                    [[-4,0]
                    ,[-4,2]
                    ,[-10,12]
                    ,[-10,13]
                    ,[-8,14]
                    ,[0,10]
                    ,[30,70]
                    ,[32,70]
                    ,[32,68]
                    ,[15,20]
                    ,[20,10]
                    ,[30,2]
                    ,[30,0]

                    ,[15,0]
                    ,[8,10]
                    ,[1,0]
                    ]);
        union() {
            translate([0,-23,83])
                rombe();
            translate([0,0,35])
                rombe();
            translate([0,23,83])
                rombe();
            translate([15 + 8,0,0])
            cube([30,46/2,60],center=true);
            translate([29,0,-1])
            cylinder(20,20,20,$fn=6);
        }
    }
}

module stand() {
    rotate([0,0,90])
        for (a =[-92:46:92]) {
            translate([0,a,0])
                v2mod();
        }
}

$fa = 1;
$fs = 0.4;
stand();
