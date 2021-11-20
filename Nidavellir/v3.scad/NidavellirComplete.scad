include <./Nidavellir.scad>

$fa = 1;
$fs = 0.4;

translate([94.5,3,2]) {
    noPart()
        color(c="Honeydew")
        import("../v1/Nidavellir-Cards.stl", convexity=3);
    translate([0,12,0]) {
        noPart()
            color(c="AliceBlue")
            import("../v1/Nidavellir-StartCoins.stl", convexity=3);
        noPart() {
            translate([-137,144,4]) coin([0,0]);

            translate([-137,153,4]) coin([0,0]);
            translate([-137,159,4]) coin([0,0]);
            translate([-137,165,4]) coin([0,0]);
            translate([-137,171,4]) coin([0,0]);
            translate([-137,176,4]) coin([0,0]);

            translate([-137,186,4]) coin([0,0]);
            translate([-137,192,4]) coin([0,0]);
            translate([-137,198,4]) coin([0,0]);
            translate([-137,204,4]) coin([0,0]);
            translate([-137,210,4]) coin([0,0]);

            translate([-188,120,4]) coin([0,0]);
            translate([-188,126,4]) coin([0,0]);
            translate([-188,132,4]) coin([0,0]);
            translate([-188,138,4]) coin([0,0]);
            translate([-188,144,4]) coin([0,0]);

            translate([-188,153,4]) coin([0,0]);
            translate([-188,159,4]) coin([0,0]);
            translate([-188,165,4]) coin([0,0]);
            translate([-188,171,4]) coin([0,0]);
            translate([-188,176,4]) coin([0,0]);

            translate([-188,186,4]) coin([0,0]);
            translate([-188,192,4]) coin([0,0]);
            translate([-188,198,4]) coin([0,0]);
            translate([-188,204,4]) coin([0,0]);
            translate([-188,210,4]) coin([0,0]);
        }
    }
}
