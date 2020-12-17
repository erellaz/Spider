// Base for Spider
// 12/14/2020
// Note: I had to break down the differences to make the file work in Freecad

scale=25.4;    // Inch to mm

//Main disk
dm=78; //External diameter mm
hm=10;

//central hole
dh=9.5; //diameter hole for 3/8 screw

//holes
rlh=((0.089)*(scale))/2; //for 4-40 tap, drill at 0.089", closest fractional 3/32"=0.094"
echo(rlh);
hlh=50;


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

collimation_base(hb,hm,dm,dh);

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
if(0){
  color( "red" ) {
      for(i = [0 : 30 : 30]){
      rotate([0,0,i]) translate([x+fi,x+fi,0]) cylinder(h=hm*1.4, r=fi, center=true);
      }
  }
    
}