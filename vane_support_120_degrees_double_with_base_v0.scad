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
hlh=50;

//filet
fi=12; //this value should be greater than vane_spacing

//spacing between 2 parallel vanes
vane_spacing=12; //this value should be smaller than fi
x=vane_spacing/2;


// The base
hb=5; //thickness of base
cs=3; //number of collimation screws, should be 3 or 4
rot=60; //rotation factor
perc=.80; //percentage of the diameter to place the collimation holes

//Resolution for STL export only. That is for display in Openscad and 3D printing only. 
//Please do comment this before going to Freecad, or you will end up with inefficient facets.
// and will not play well with export to .step files

$fn=150;

//_________________________________________________________________________________
//main body
module body(hm,dm){
difference(){
cylinder(h=hm, d=dm, center=true); //the body
//cube(size = [dm, dm, hm], center = true);
cylinder(h=hm+20, d=dh, center=true); //the hole
}
}

//The 3 cut outs of the main body
module cutter(dm,hm){
 for(i = [0 : 120 : 360]){
     //rotate([0,0,i]) translate([dm/6,0,-hm]) cube(size = [dm, dm, hm*2], center = false);
    rotate([0,0,i]) union(){
    translate([x,x+fi,-hm]) cube(size = [dm, dm, hm*2], center = false);
    translate([x+fi,x,-hm]) cube(size = [dm, dm, hm*2], center = false);
    translate([x+fi,x+fi,0]) cylinder(h=hm*2, r=fi, center=true);
    }
}

for(i = [30 : 120 : 390]){
     //rotate([0,0,i]) translate([dm/6,0,-hm]) cube(size = [dm, dm, hm*2], center = false);
    rotate([0,0,i]) union(){
    translate([x,x+fi,-hm]) cube(size = [dm, dm, hm*2], center = false);
    translate([x+fi,x,-hm]) cube(size = [dm, dm, hm*2], center = false);
    translate([x+fi,x+fi,0]) cylinder(h=hm*2, r=fi, center=true);
    }
}
// The following formula deserves a bit of explanation:
// the cylinders have their center on a circle of radius sqrt(2)*(x+fi)
// and 2 adjacent cylinders are 30 degrees apart
// hence the flat part should be at cos(15)*sqrt(2)*(x+fi)
for(i = [0 : 120 : 360]){
    rotate([0,0,i+60])translate([cos(15)*sqrt(2)*(x+fi),0,0])cube(size = [2*fi, fi, 1.2*hm], center = true);
}

}


//the holes to mount the vanes
module drill_holes(dm,hm,hlh,rlh){
   for(i = [0 : 120 : 360]){
     rotate([0,0,i])  translate([.75*dm/2,0,hm/4]) rotate([90,0,0]) cylinder(h=hlh, r=rlh, center=true);
     rotate([0,0,i])  translate([.75*dm/2,0,0]) rotate([90,0,0]) cylinder(h=hlh, r=rlh, center=true);
     rotate([0,0,i])  translate([.75*dm/2,0,-hm/4]) rotate([90,0,0]) cylinder(h=hlh, r=rlh, center=true);
}
}


// The base for colimation screws
module collimation_base(hb,hm,dm,dh,rlh){
    difference(){
        translate([0,0,-(hb+hm)/2])cylinder(h=hb, d=dm, center=true);  
        cylinder(h=hm+20, d=dh, center=true); //the hole
        for(i = [0 : 360/cs : 360]){
         rotate([0,0,i+rot])  translate([perc*dm/2,0,0]) cylinder(h=4*hm, r=rlh, center=true);   
        }
    }
}

//_________________________________________________________________________________
//build the body, remove the cut outs, drill the holes
union(){
    difference(){
    body(hm,dm);
    cutter(dm,hm);
    drill_holes(dm,hm,hlh,rlh);
    }
collimation_base(hb,hm,dm,dh);
}
//_________________________________________________________________________________
//Here we test the various parts individually
//_________________________________________________________________________________
//testing the cut out
if(0){
  color( "blue" ) {
      //for(i = [25 : 60 : 60]){
         rotate([0,0,60])translate([cos(15)*sqrt(2)*(x+fi),0,0])cube(size = [2*fi, fi, 1.2*hm], center = true);
  }
  //}
}

//_________________________________________________________________________________
//testing the cylinders
if(00){
  color( "red" ) {
      for(i = [0 : 30 : 30]){
      rotate([0,0,i]) translate([x+fi,x+fi,0]) cylinder(h=hm*1.4, r=fi, center=true);
      }
  }
    
}