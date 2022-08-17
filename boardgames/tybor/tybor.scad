include <../genbox.scad>

module Logo() {
    d=0.3;
    angle=45;
    color("gray") {
        render(convexity = 2) {
            translate([0,0,-d])
                multmatrix(m = [ [0.8, 0.2, 0, 0],
                        [0.1, 1, 0, 0],
                        [0, 0, 1, 0],
                        [0, 0, 0, 1]
                ])
                linear_extrude(d*2)
                text("Tybor",
                        font = "Roboto Condensed:style=Bold",
                        size = 23,
                        halign = "center", valign="center");
        }
    }
}

box(h=96, w=62.5, ds=[32,22,2,12], window=true) Logo() ;
