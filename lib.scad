highRes=false;
isStlExport=false;
justOnePart="";

module part(partName,
            s=[0,0,0], r=[0,0,0],
            sReset=[0,0,0], rReset=[0,0,0],
            label=false){
    echo(partName, "$part")
    if (justOnePart == ""){
        translate(s)
            rotate(r)
            children();
        if (label) {
            translate([150,0,0])
                text(partName,
                        font = "Roboto Condensed:style=Light",
                        size = 7,
                        halign = "center");
        }
    } else if (justOnePart == partName) {
        $fa = 1;
        $fs = 0.4;
        translate(sReset)
            rotate(rReset)
            children();
    }
}

module noPart(c=undef){
    if (justOnePart == ""){
        color(c)
        children();
    }
}

module roundCube(dimensions, r=1, fn=0, center=true, inner=false) {
    if (r==0) {
        cube(dimensions, center=center);
    } else {
        x=dimensions[0];
        y=dimensions[1];
        z=dimensions[2];
        translate(center ? [0,0,0] : [x/2, y/2, z/2])
            hull()
                for (xyz=[[1,1,1],[1,1,-1],[1,-1,1],[1,-1,-1],[-1,1,1],[-1,1,-1],[-1,-1,1],[-1,-1,-1]]){
                    translate([xyz[0]*(x/2 - (inner ? r : 0)),
                               xyz[1]*(y/2 - (inner ? r : 0)),
                               xyz[2]*(z/2 - (inner ? r : 0))])
                        sphere(r=r, $fn=fn);
                }
    }
}

module mirrorAndKeep(m) {
    children();
    mirror(m) children();
}

module mirrorAndKeeps(ms) {
    children();
    for(m = ms)
        mirror(m) children();
}
