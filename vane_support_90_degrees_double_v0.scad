// Base for Spider
// 12/14/2020
// Note: I had to break down the differences to make the file work in Freecad

scale=25.4;    // Inch to mm

//Main disk
dm=78; //External diameter mm
dc=35;
hm=30; //heigth  mm

//central hole
dh=9.5; //diameter hole for 3/8 screw

//holes
rlh=((0.089)*(scale))/2; //for 4-40 tap, drill at 0.089", closest fractional 3/32"=0.094"
echo(rlh);
hlh=12;

//filet
fi=14;

//spacing between 2 parallel vanes
vane_spacing=11;
x=vane_spacing/2;

//Resolution for STL export only. That is for display in Openscad and 3D printing only. 
//Please do comment this before going to Freecad, or you will end up with inefficient facets.
// and will not play well with export to .step files

$fn=150;

//_________________________________________________________________________________
//main body
module body(hm,dm){
difference(){
//cylinder(h=hm, d=dm, center=true); //the body
cube(size = [dm, dm, hm], center = true);
cylinder(h=hm+20, d=dh, center=true); //the hole
}
}

//The 4 cut outs of the main body
module cutter(dm,hm){
 for(i = [0 : 90 : 360]){
     //rotate([0,0,i]) translate([dm/6,0,-hm]) cube(size = [dm, dm, hm*2], center = false);
    rotate([0,0,i]) union(){
    translate([x,x+fi,-hm]) cube(size = [dm, dm, hm*2], center = false);
    translate([x+fi,x,-hm]) cube(size = [dm, dm, hm*2], center = false);
    translate([x+fi,x+fi,0]) cylinder(h=hm*2, r=fi, center=true);
    }
}
}

//the holes to mount the vanes
module drill_holes(dm,hm,hlh,rlh){
   for(i = [0 : 90 : 360]){
     rotate([0,0,i])  translate([0,.75*dm/2,hm/4]) rotate([0,90,0]) cylinder(h=hlh, r=rlh, center=true);
     rotate([0,0,i])  translate([0,.75*dm/2,0]) rotate([0,90,0]) cylinder(h=hlh, r=rlh, center=true);
     rotate([0,0,i])  translate([0,.75*dm/2,-hm/4]) rotate([0,90,0]) cylinder(h=hlh, r=rlh, center=true);
}
}

//_________________________________________________________________________________
//build the body, remove the cut outs, drill the holes
difference(){
body(hm,dm);
cutter(dm,hm);
drill_holes(dm,hm,hlh,rlh);
}
//_________________________________________________________________________________
//Here we test the various parts individually
//_________________________________________________________________________________
//testing the cut out
if(0){
  color( "blue" ) {
    

  }
}

//_________________________________________________________________________________
//testing the holes
if(0){
  color( "red" ) {
  }
    
}