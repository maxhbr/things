highRes=false;
justOnePart="";

module part(partName, s=[0,0,0], r=[0,0,0], label=false){
    if (justOnePart == ""){
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
        translate(s)
            rotate(r)
            children();
    }
}

module noPart(){
    if (justOnePart == ""){
        children();
    }
}

module roundCube(dimensions, r=1, fn=0) {
    if (r==0) {
        cube(dimensions, center=true);
    } else {
        x=dimensions[0];
        y=dimensions[1];
        z=dimensions[2];
        hull()
            for (xyz=[[1,1,1],[1,1,-1],[1,-1,1],[1,-1,-1],[-1,1,1],[-1,1,-1],[-1,-1,1],[-1,-1,-1]]){
                translate([xyz[0]*x/2, xyz[1]*y/2, xyz[2]*z/2])
                    sphere(r=r, $fn=fn);
            }
    }
}
