include <Choc_Chicago_Steno_Thumb.scad>;

for(i=[-60:15:90]){
  for(j=[-60:15:60]){
    translate([i,j,0]) sphere(r=.5);
  }
 }

module key(id){
  difference(){
    keycap(
	   $trimmer = [[0,0],[0,0]],
	   keyID   = id, //change profile refer to KeyParameters Struct
	   cutLen  = 0, //Don't change. for chopped caps
	   Stem    = true, //tusn on shell and stems
	   StemRot = 0,//change stem orientation by deg
	   Dish    = true, //turn on dish cut
	   Stab    = 0,
	   visualizeDish = false, // turn on debug visual of Dish
	   crossSection  = false, // center cut to check internal
	   homeDot = false, //turn on homedots
	   Legends = false
	   );

    if(id==1||id==0){
      translate([17.20/2-1.5,0,0]+[10,0,0])cube([20,20,20],true);
    }

    if(id==1||id==0){
      translate([0,16.0/2-1,0]+[0,10,0])cube([20,20,20],true);
    }

    if(id==1){
      translate([0,-(16.0/2-1),0]+[0,-10,0])cube([20,20,20],true);
    }
  }
}
translate([-45,0,0]){
  key(1);

  translate([15,0,0])
    mirror([1,0,0])
    key(1);

  translate([0,15,0])
    rotate([0,0,180])
    mirror([1,0,0])
    key(0);

  translate([15,15,0])
    //mirror([1,0,0])
    rotate([0,0,180])
    key(0);

  translate([0,-15,0])
    key(0);

  translate([15,-15,0])
    mirror([1,0,0])
    key(0);
}
