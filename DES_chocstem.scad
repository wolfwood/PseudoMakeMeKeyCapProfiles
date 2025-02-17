use <scad-utils/morphology.scad> //for cheaper minwoski
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>
//use <z-butt.scad>

/*DES (Distorted Elliptical Saddle) Sculpted Profile for 6x3 and corne thumb
Version 2: Eliptical Rectangle
*/
 h_adjust = 0;
 translate([0,0,0])rotate([0,0,0])keycap(
  keyID  = 4, //change profile refer to KeyParameters Struct
  cutLen = 0, //Don't change. for chopped caps
  Stem   = true, //tusn on shell and stems
  Dish   = true, //turn on dish cut
  Stab   = 0,
  visualizeDish = false, // turn on debug visual of Dish
  crossSection  = false, // center cut to check internal
  homeDot = false, //turn on homedots
  Legends = false
 );

 *translate([19,0,0])rotate([0,0,0])keycap(
  keyID  = 2, //change profile refer to KeyParameters Struct
  cutLen = 0, //Don't change. for chopped caps
  Stem   = true, //tusn on shell and stems
  Dish   = true, //turn on dish cut
  Stab   = 0,
  visualizeDish = false, // turn on debug visual of Dish
  crossSection  = false, // center cut to check internal
  homeDot = false, //turn on homedots
  Legends = false
 );

//mirror([1,0,0])keycap(
//  keyID  = 3, //change profile refer to KeyParameters Struct
//  cutLen = 0, //Don't change. for chopped caps
//  Stem   = true, //tusn on shell and stems
//  Dish   = true, //turn on dish cut
//  Stab   = 0,
//  visualizeDish = false, // turn on debug visual of Dish
//  crossSection  = false, // center cut to check internal
//  homeDot = true, //turn on homedots
//  Legends = false
// );
lp_key = [
//     "base_sx", 18.5
//     "base_sy", 18.5,
     "base_sx", 17.65,
     "base_sy", 16.5,
//     "cavity_sx", 16.1,
//     "cavity_sy", 14.9,
     "cavity_sx", 15.8,
     "cavity_sy", 14.8,
     "cavity_sz", 1.6,
     "cavity_ch_xy", 1.4,
     "indent_inset", 1.5
     ];

mx_al_tp_key = [
     "base_sx", 18.5,
     "base_sy", 18.5,
     "cavity_sx", 14.725,
//     "cavity_sx", 14.925,
     "cavity_sy", 14.725,
//     "cavity_sy", 14.925,
     "cavity_sz", 4.25,
//     "cavity_sz", 5.25,
//     "cavity_ch_xy", 2,
     "cavity_ch_xy", 1.9,
     "indent_inset", 3
     ];

//    #translate([0,0,.4])key_cavity(key= lp_key, xu=1, yu=1);
//translate([0,0,0])lp_master_base(xu = 4.25, yu = 1 );
// color("blue")translate([0,0,2.5])rotate_extrude()translate([5,0])circle(d=1,$fn=8);
//#translate([0,38,13])cube([18-5.7, 18-5.7,1],center = true);
//Parameters
wallthickness = 1.6; // 1.5 for norm, 1.25 for cast master
topthickness  = 2.5;   // 3 for norm, 2.5 for cast master
stepsize      = 60;  //resolution of Trajectory
step          = 0.5;   //resolution of ellipes
slop          = 0;
fn            = 60;  //resolution of Rounded Rectangles: 60 for output
layers        = 50;  //resolution of vertical Sweep: 50 for output
dotRadius     = 0.55;   //home dot size
//---Stem param
Tol    = 0.10;
stemRot = 0;
stemWid = 5.5;
stemLen = 5.5;
stemCrossHeight = 4;
extra_vertical  = 0.6;
StemBrimDep     = 0.25;
stemLayers      = 50; //resolution of stem to cap top transition


keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx
//Column high sculpt 3 row system
    //0~5
    [17.16,  17.16,   6.5, 	 6.5,10.55+h_adjust,    0,    0,   -9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4 8
    [17.16,  17.16,   6.5, 	 6.5, 8.75+h_adjust,    0,  -.5,   -4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5, 9.75+h_adjust,    0,    0,   13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    [17.16,  17.16,   6.5, 	 6.5, 8.75+h_adjust,    0,   .5,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 deepdish
    [17.16,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 mod
    [17.16,  17.16,   6.5, 	 6.5, 15.0,    0,    0,    10,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R1 num

];

dishParameters = //dishParameter[keyID][ParameteID]
[
//FFwd1 FFwd2 FPit1 FPit2  DshDep DshHDif FDshDepF FArcFn FArcEx     BFwd1 BFwd2 BPit1 BPit2  BArcIn BArcFn BArcEx
  // low pro 3 row system
  [   6,    3,   18,  -50,      5,    1.8,   8.8,    15,     2,        5,  4.4,    5,  -55,    8.8,    15,     2], //R4
  [ 4.5,  3.8,   10,  -55,      5,    1.8,   8.5,    15,     2,        5,  3.7,   10,  -55,    8.5,    15,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,   8.8,    15,     2,        6,    4,   13,   30,    8.8,    16,     2], //R2
  [ 4.8,    4,   10,  -30,      6,    2.2,     1,   4.5,     2,        4.8,  4,   10,  -30,    8.8,   4.5,     2], //R3 deep
  [   6,    3,   -5,  -50,      5,    1.8,   8.8,    15,     2,        6,  3.5,   13,  -50,    8.8,    15,     2], //R5 mod
  [ 5.0,  3.5,   25,  -50,    5.0,    3.0,     1,   3.5,     2,       5.0, 3.5,   25,  -50,    9,   4.5,     2], //R1 deep
    //C0



];

function FrontForward1(keyID) = dishParameters[keyID][0];  //
function FrontForward2(keyID) = dishParameters[keyID][1];  //
function FrontPitch1(keyID)   = dishParameters[keyID][2];  //
function FrontPitch2(keyID)   = dishParameters[keyID][3];  //
function DishDepth(keyID)     = dishParameters[keyID][4];  //
function DishHeightDif(keyID) = dishParameters[keyID][5];  //
function DishDepthF(keyID)    = dishParameters[keyID][6];
function FrontFinArc(keyID)   = dishParameters[keyID][7];
function FrontArcExpo(keyID)  = dishParameters[keyID][8];
function BackForward1(keyID)  = dishParameters[keyID][9];  //
function BackForward2(keyID)  = dishParameters[keyID][10];  //
function BackPitch1(keyID)    = dishParameters[keyID][11];  //
function BackPitch2(keyID)    = dishParameters[keyID][12];  //
function BackInitArc(keyID)   = dishParameters[keyID][13];
function BackFinArc(keyID)    = dishParameters[keyID][14];
function BackArcExpo(keyID)   = dishParameters[keyID][15];

function BottomWidth(keyID)  = keyParameters[keyID][0];  //
function BottomLength(keyID) = keyParameters[keyID][1];  //
function TopWidthDiff(keyID) = keyParameters[keyID][2];  //
function TopLenDiff(keyID)   = keyParameters[keyID][3];  //
function KeyHeight(keyID)    = keyParameters[keyID][4];  //
function TopWidShift(keyID)  = keyParameters[keyID][5];
function TopLenShift(keyID)  = keyParameters[keyID][6];
function XAngleSkew(keyID)   = keyParameters[keyID][7];
function YAngleSkew(keyID)   = keyParameters[keyID][8];
function ZAngleSkew(keyID)   = keyParameters[keyID][9];
function WidExponent(keyID)  = keyParameters[keyID][10];
function LenExponent(keyID)  = keyParameters[keyID][11];
function CapRound0i(keyID)   = keyParameters[keyID][12];
function CapRound0f(keyID)   = keyParameters[keyID][13];
function CapRound1i(keyID)   = keyParameters[keyID][14];
function CapRound1f(keyID)   = keyParameters[keyID][15];
function ChamExponent(keyID) = keyParameters[keyID][16];
function StemExponent(keyID) = keyParameters[keyID][17];

function FrontTrajectory(keyID) =
  [
    trajectory(forward = FrontForward1(keyID), pitch =  FrontPitch1(keyID)), //more param available: yaw, roll, scale
    trajectory(forward = FrontForward2(keyID), pitch =  FrontPitch2(keyID))  //You can add more traj if you wish
  ];

function BackTrajectory (keyID) =
  [
    trajectory(forward = BackForward1(keyID), pitch =  BackPitch1(keyID)),
    trajectory(forward = BackForward2(keyID), pitch =  BackPitch2(keyID)),
  ];

//------- function defining Dish Shapes

function ellipse(a, b, d = 0, rot1 = 0, rot2 = 360) = [for (t = [rot1:step:rot2]) [a*cos(t)+a, b*sin(t)*(1+d*cos(t))]]; //Centered at a apex to avoid inverted face

function DishShape (a,b,c,d) =
  concat(
//   [[c+a,b]],
    ellipse(a, b, d = 0,rot1 = 110, rot2 = 250)
//   [[c+a,-b]]
  );

function oval_path(theta, phi, a, b, c, deform = 0) = [
 a*cos(theta)*cos(phi), //x
 c*sin(theta)*(1+deform*cos(theta)) , //
 b*sin(phi),
];

path_trans2 = [for (t=[0:step:180])   translation(oval_path(t,0,10,15,2,0))*rotation([0,90,0])];


//--------------Function definng Cap
function CapTranslation(t, keyID) =
  [
    ((t)/layers*TopWidShift(keyID)),   //X shift
    ((t)/layers*TopLenShift(keyID)),   //Y shift
    (t/layers*KeyHeight(keyID))    //Z shift
  ];

function InnerTranslation(t, keyID) =
  [
    0,   //X shift
    0,   //Y shift
    (t/layers*(2.6))    //Z shift
  ];

function CapRotation(t, keyID) =
  [
    ((t)/layers*XAngleSkew(keyID)),   //X shift
    ((t)/layers*YAngleSkew(keyID)),   //Y shift
    ((t)/layers*ZAngleSkew(keyID))    //Z shift
  ];

function CapTransform(t, keyID) =
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopWidthDiff(keyID)) + (1-pow(t/layers, WidExponent(keyID)))*BottomWidth(keyID),
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)) + (1-pow(t/layers, LenExponent(keyID)))*BottomLength(keyID)
  ];
function CapRoundness(t, keyID) =
  [
    pow(t/layers, ChamExponent(keyID))*(CapRound0f(keyID)) + (1-pow(t/layers, ChamExponent(keyID)))*CapRound0i(keyID),
    pow(t/layers, ChamExponent(keyID))*(CapRound1f(keyID)) + (1-pow(t/layers, ChamExponent(keyID)))*CapRound1i(keyID)
  ];

function CapRadius(t, keyID) = pow(t/layers, ChamExponent(keyID))*ChamfFinRad(keyID) + (1-pow(t/layers, ChamExponent(keyID)))*ChamfInitRad(keyID);

function InnerTransform(t, keyID) =
  [
    pow(t/layers,1.5)*(13) + (1-pow(t/layers,1.5))*(16),

    pow(t/layers,1.5)*(13) + (1-pow(t/layers,1.5))*(16)
  ];

function StemTranslation(t, keyID) =
  [
    0,   //X shift
    0,   //Y shift
    (t/stemLayers*(2.55)+(1-t/stemLayers)*(2.))    //Z shift
  ];

function StemRotation(t, keyID) =
  [
    ((t)/stemLayers*XAngleSkew(keyID)),   //X shift
    ((t)/stemLayers*YAngleSkew(keyID)),   //Y shift
    ((t)/stemLayers*ZAngleSkew(keyID))    //Z shift
  ];

function StemTransform(t, keyID) =
  [
    pow(t/stemLayers, StemExponent(keyID))*(7.1) + (1-pow(t/stemLayers, StemExponent(keyID)))*(7),
    pow(t/stemLayers, StemExponent(keyID))*(3.3) + (1-pow(t/stemLayers, StemExponent(keyID)))*(3.2)
  ];

function StemRadius(t, keyID) = pow(t/stemLayers,1)*2 + (1-pow(t/stemLayers, 1))*1;
  //Stem Exponent

///----- KEY Builder Module
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, rossSection = false, Dish = true, Stem = false, crossSection = true,Legends = false, homeDot = false, Stab = 0) {

  //Set Parameters for dish shape
  FrontPath = quantize_trajectories(FrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
  BackPath  = quantize_trajectories(BackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);

  //Scaling initial and final dim tranformation by exponents
  function FrontDishArc(t) =  pow((t)/(len(FrontPath)),FrontArcExpo(keyID))*FrontFinArc(keyID) + (1-pow(t/(len(FrontPath)),FrontArcExpo(keyID)))*BackInitArc(keyID);
  function BackDishArc(t)  =  pow((t)/(len(FrontPath)),BackArcExpo(keyID))*BackFinArc(keyID) + (1-pow(t/(len(FrontPath)),BackArcExpo(keyID)))*BackInitArc(keyID);

  function DishDepths(t, keyID, p) = pow((t)/(len(FrontPath)),p)*DishDepthF(keyID) + (1-pow(t/(len(FrontPath)),p))*DishDepth(keyID);

  FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(DishDepths(i,keyID,2), FrontDishArc(i), 1, d = 0)) ];
  BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],  DishShape(DishDepths(i,keyID,2),  BackDishArc(i), 1, d = 0)) ];

  //builds
  difference(){
    union(){
      difference(){
        skin([for (i=[0:layers-1]) transform(translation(CapTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(CapTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]); //outer shell

        //Cut inner shell
        if(Stem == true){
          translate([0,0,-.001])skin([for (i=[0:layers-1]) transform(translation(InnerTranslation(i, keyID)), elliptical_rectangle(InnerTransform(i, keyID), b =[0.5, 0.5],fn=fn))]);
        }
             if(crossSection == true) {
       translate([0,-15,-.1])cube([30,30,20]);
//      translate([-15.1,-15,-.1])cube([15,30,20]);
     }
      }
      if(Stem == true){
         translate([0,0,0])rotate(stemRot)difference(){
          union(){
          choc_stem();
//            cylinder(d =5.5,KeyHeight(keyID)-StemBrimDep, $fn= 32);
//            if (Stab >= 2){
//              translate([.625*19.05,0,0])cylinder(d =5.5,KeyHeight(keyID)-StemBrimDep, $fn= 32);
//              translate([-.625*19.05,0,0])cylinder(d =5.5,KeyHeight(keyID)-StemBrimDep, $fn= 32);
//              }
           translate([0,0,-.001])skin([for (i=[0:stemLayers-1]) transform(translation(StemTranslation(i,keyID)), elliptical_rectangle(StemTransform(i, keyID),b=[.5,.5], fn=8))]); //Transition Support for taller profilea
          }

//          skin(StemCurve);
//          skin(StemCurve2);
//          if (Stab >= 2){
//            translate([.625*19.05,0,0]){
//              skin(StemCurve);
//              skin(StemCurve2);
//            }
//            translate([-.625*19.05,0,0]){
//              skin(StemCurve);
//              skin(StemCurve2);
//            }
//          }
        }

      }
    //cut for fonts and extra pattern for light?
    }

    //Cuts

    //Fonts
    if(Legends ==  true){
//          #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])
      translate([0,0,KeyHeight(keyID)-5])linear_extrude(height =5)text( text = "A", font = "Calibri:style=Bold", size = 4, valign = "center", halign = "center" );
      //  #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,-3.5,0])linear_extrude(height = 0.5)text( text = "Me", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      }
   //Dish Shape
    if(Dish == true){
      translate([TopWidShift(keyID),.00001+TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      translate([TopWidShift(keyID),TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     }



  }
  //Homing dot
        if(homeDot == true){
//      // center dot
//      translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-0.1])sphere(r = dotRadius, $fn=32); // center dot
      // double bar dots
        rotate([XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([1.5,-5.25,KeyHeight(keyID)-DishHeightDif(keyID)+.1])sphere(r = dotRadius, $fn= 32); // center dot
        rotate([XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([-1.5,-5.25,KeyHeight(keyID)-DishHeightDif(keyID)+.1])sphere(r = dotRadius, $fn= 32); // center dot
      }
    if(visualizeDish == true){
      #translate([TopWidShift(keyID),.00001+TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      #translate([TopWidShift(keyID),TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
    }
}
//------------------stems

MXWid = 4.03/2+Tol; //horizontal lenght
MXLen = 4.23/2+Tol; //vertical length

MXWidT = 1.15/2+Tol; //horizontal thickness
MXLenT = 1.25/2+Tol; //vertical thickness

function stem_internal(sc=1) = sc*[
[MXLenT, MXLen],[MXLenT, MXWidT],[MXWid, MXWidT],
[MXWid, -MXWidT],[MXLenT, -MXWidT],[MXLenT, -MXLen],
[-MXLenT, -MXLen],[-MXLenT, -MXWidT],[-MXWid, -MXWidT],
[-MXWid,MXWidT],[-MXLenT, MXWidT],[-MXLenT, MXLen]
];  //2D stem cross with tolance offset and additonal transformation via jog
//trajectory();
function StemTrajectory() =
  [ trajectory(forward = 5.25) ];

  StemPath  = quantize_trajectories(StemTrajectory(),  steps = 1 , loop=false, start_position= $t*4);
  StemCurve  = [ for(i=[0:len(StemPath)-1])  transform(StemPath[i],  stem_internal()) ];


function StemTrajectory2() =
  [trajectory(forward = .5)];

StemPath2  = quantize_trajectories(StemTrajectory2(),  steps = 10, loop=false, start_position= $t*4);
StemCurve2  = [for(i=[0:len(StemPath2)-1])  transform(StemPath2[i]*scaling([(1.1-.1*i/(len(StemPath2)-1)),(1.1-.1*i/(len(StemPath2)-1)),1]), stem_internal())];

module rotate_z_copy (angle) {
     children();
     rotate([0, 0, angle]) {
          children();
     }
}

module lp_copy () {
     dx = attr(lp_stem, "distance_x");
     translate([-dx / 2, 0]) {
          children();
     }
     translate([dx / 2, 0]) {
          children();
     }
}

function attr(p, k) = p[search([k], [for(i = [0 : 2: len(p) - 2]) p[i]])[0] * 2 + 1];
lp_depth = 1.6;
lp_stem = [
     "distance_x", 5.75,
     "extension_z", 2.0,
     "size_x", 1.25,
     "size_y", 2.95,
     "bevel", 0.25,
     ];
overlap = 0.1;  // Offset to avoid coplanar faces in Boolean operations.
module lp_stem (cavity_height) {
     $fn = 32;
     ext_z = attr(lp_stem, "extension_z");
     sx = attr(lp_stem, "size_x");
     sy = attr(lp_stem, "size_y");
     bevel = attr(lp_stem, "bevel");

     translate([0, 0, -ext_z]) {
        lp_copy() {
          linear_extrude(cavity_height + ext_z + overlap, scale=1.05) {
                    rotate_z_copy(180) {
                         translate([0, sy / 2 - bevel -.0]) {
                              minkowski() {
                                   scale([sx - bevel * 2, sy * 2 / 5 - bevel * 2]) {
                                        translate([-0.5, -1]) {
                                             square(1);
                                        }
                                   }
                                   circle(r=bevel-.05, $fn=8);
                              }
                         }
                    }
                    scale([sx - bevel-.05, sy - bevel * 2]) {
                         translate([-0.5, -0.5]) {
                              square(1);
                         }
                    }
               }
          }
       }
}

module choc_stem() {

//   #translate([5.7/2,0,-3.4/2+2])difference(){
//    cube([1.25,3, 3.4], center= true);
//    translate([3.9,0,0])cylinder(d=7,3.4,center = true);
//    translate([-3.9,0,0])cylinder(d=7,3.4,center = true);
//  }
//  translate([-5.7/2,0,-3.4/2+2])difference(){
//    cube([1.25,3, 3.4], center= true);
//    translate([3.9,0,0])cylinder(d=7,3.4,center = true);
//    translate([-3.9,0,0])cylinder(d=7,3.4,center = true);
//  }
  translate([0,0,.6])lp_stem(1.6);
}


/// ----- helper functions
function rounded_rectangle_profile(size=[1,1],r=1,fn=32) = [
	for (index = [0:fn-1])
		let(a = index/fn*360)
			r * [cos(a), sin(a)]
			+ sign_x(index, fn) * [size[0]/2-r,0]
			+ sign_y(index, fn) * [0,size[1]/2-r]
];

function elliptical_rectangle(a = [1,1], b =[1,1], fn=32) = [
    for (index = [0:fn-1]) // section right
     let(theta1 = -atan(a[1]/b[1])+ 2*atan(a[1]/b[1])*index/fn)
      [b[1]*cos(theta1), a[1]*sin(theta1)]
    + [a[0]*cos(atan(b[0]/a[0])) , 0]
    - [b[1]*cos(atan(a[1]/b[1])) , 0],

    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + (180 -2*atan(b[0]/a[0]))*index/fn)
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    - [0, b[0]*sin(atan(b[0]/a[0]))]
    + [0, a[1]*sin(atan(a[1]/b[1]))],

    for(index = [0:fn-1]) // section left
     let(theta2 = -atan(a[1]/b[1])+180+ 2*atan(a[1]/b[1])*index/fn)
      [b[1]*cos(theta2), a[1]*sin(theta2)]
    - [a[0]*cos(atan(b[0]/a[0])) , 0]
    + [b[1]*cos(atan(a[1]/b[1])) , 0],

    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + 180 + (180 -2*atan(b[0]/a[0]))*index/fn)
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    + [0, b[0]*sin(atan(b[0]/a[0]))]
    - [0, a[1]*sin(atan(a[1]/b[1]))]
]/2;

function sign_x(i,n) =
	i < n/4 || i > n-n/4  ?  1 :
	i > n/4 && i < n-n/4  ? -1 :
	0;

function sign_y(i,n) =
	i > 0 && i < n/2  ?  1 :
	i > n/2 ? -1 :
	0;

//#square([18.16, 18.16], center = true);
//#square([41.3, 19.05], center = true);
//scale(1.03)difference(){// assume 1% from infill and 2% for easy removal
//translate([0,0,13/2+.1])cube([21,21,13], center = true);
//
// projection()
// translate([0,28,0])rotate([0,-90,0]){
