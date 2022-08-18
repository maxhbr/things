include <../../lib.scad>

module outer(totalh) {
    innerw=127;
    innerl=202;
    innerh=36;
    outerw=innerw+4;
    outerl=innerl+6;

    difference() {
        translate([0,0,totalh/2]) {
            wedgedCube([innerw,innerl,totalh]);
            translate([0,0,innerh/2])
                wedgedCube([outerw,outerl,totalh-innerh]);
        }
        children();
    }
}

module cardWedge(y,cardh,totalh,alpha) {
    translate([0,y,totalh])
        rotate([alpha,0,0])
        translate([0,0,80/2-((totalh-2) / cos(alpha))])
        wedgedCube([cardh,4,80]);
}

module cards(width,totalh) {
    cardw=68;
    alpha=acos((totalh-2)/cardw);
    echo(alpha);
    cardh=95;
    hull() {
        cardWedge(width/2, cardh=cardh, totalh=totalh, alpha=alpha);
        cardWedge(-width/2, cardh=cardh, totalh=totalh, alpha=alpha);
    }
    translate([0,width/2,totalh]) wedgedCube([cardh, 20,20],center=true);
    translate([0,width/2,totalh]) rotate([45,0,0]) wedgedCube([cardh, 22,20],center=true);
}


totalh=48;
stackh=42;
baseOffset=27;
intersection() {
    outer(totalh=totalh){
        sep=11;
        for (t=[[13,baseOffset],
                [-13,baseOffset - (stackh + sep)], 
                [13,baseOffset - 2*(stackh + sep)]]) {
            translate([t[0],t[1],0]) cards(stackh,totalh=totalh);
        }
        translate([0,0,totalh])
            wedgedCube([69,100,7],center=true);
        translate([13,-100,totalh+3])
            wedgedCube([69+2*13,10,7],center=true);
        /* translate([0,baseOffset,totalh+10]) */
        /*     rotate([90,0,0]) */
        /*     cylinder(h=104,r=20); */
    };
    if ($preview) {
        translate([-300,-150,0])
        cube([300,300,100]);
    }
}
