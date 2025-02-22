use <scad-utils/morphology.scad> //for cheaper minwoski y-skew)
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>
//use <z-butt.scad>
// Choc Chord version Chicago Stenographer with sculpte Thumb cluter
// change stemrot
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
CheckCross = false;
GlobalDish = true;
GlobalStem = true;

//#translate([0,0,0])rotate([0,0,0])import("DES_T1x.stl");
mirror([0,0,0])keycap(
  keyID   = 9, //change profile refer to KeyParameters Struct
  Dish    = GlobalDish, //turn on dish cut
  Stem = GlobalStem,
  crossSection =false,
  visualizeDish = true, // turn on debug visual of Dish
  Sym     = false, //turn on 2ndrary filled symetry
  homeDot = false,
  fdm = true // generate chamfer for better fdm bed adhesion
);
//translate([0,0,0])rotate([0,0,0])
//keycap(
//  keyID   = 7, //change profile refer to KeyParameters Struct
//  Dish    = GlobalDish, //turn on dish cut
//  Stem = GlobalStem,
////  crossSection =true,
//  visualizeDish = false, // turn on debug visual of Dish
//  Sym     = false //turn on 2ndrary filled symetry
//);
//translate([0,19.05,0])rotate([0,0,0])
//keycap(
//  keyID   = 8, //change profile refer to KeyParameters Struct
//  Dish    = GlobalDish, //turn on dish cut
//  Stem = GlobalStem,
////  crossSection =true,
//  visualizeDish =false, // turn on debug visual of Dish
//  Sym     = false //turn on 2ndrary filled symetry
//);
//translate([-19,19.05/2,0])rotate([0,0,0])
//keycap(
//  keyID   = 3, //change profile refer to KeyParameters Struct
//  Dish    = GlobalDish, //turn on dish cut
//  Stem = GlobalStem,
////  crossSection =true,
//  visualizeDish = false, // turn on debug visual of Dish
//  Sym     = false //turn on 2ndrary filled symetry
//);
//////    #key_cavity(key= mx_al_tp_key, xu=1, yu=1);
////
//translate([-19,0,0])rotate([0,0,0])
//keycap(
//  keyID   = 1, //change profile refer to KeyParameters Struct
//  Dish    = GlobalDish, //turn on dish cut
//  Stem = GlobalStem,
//  visualizeDish = false, // turn on debug visual of Dish
//  Sym     = false //turn on 2ndrary filled symetry /
//);
//
//translate([-0,-19.05/2,0])rotate([0,0,0])mirror([1,0,0])
//keycap(
//  keyID   = 4, //change profile refer to KeyParameters Struct
//  Dish    = GlobalDish, //turn on dish cut
//  Stem = GlobalStem,
////  crossSection =true,
//  visualizeDish = false, // turn on debug visual of Dish
//  Sym     = false //turn on 2ndrary filled symetry
//);
//
//translate([-0,19.05/2,0])rotate([0,0,0])mirror([1,0,0])
//keycap(
//  keyID   = 5, //change profile refer to KeyParameters Struct
//  Dish    = GlobalDish, //turn on dish cut
//  Stem = GlobalStem,
////  crossSection =true,
//  visualizeDish = false, // turn on debug visual of Dish
//  Sym     = false //turn on 2ndrary filled symetry
//);
//translate([-20,0,0])rotate([0,0,0])mx_master_base(xu = 1, yu = 2);

//
//translate([0,34.0,0])mirror([0,1,0])
//keycap(
//  keyID   = 0, //change profile refer to KeyParameters Struct
//  Dish    = GlobalDish, //turn on dish cut
//  Stem = GlobalStem,
////  crossSection =true,
//  visualizeDish = false, // turn on debug visual of Dish
//  Sym     = false //turn on 2ndrary filled symetry
//);

//translate([-9,-17,0])import("chords.stl");
//translate([ 9,-17,0])mirror([1,0,0])import("chords.stl");
//import("chords.stl");

//translate([0,0,0])rotate([0,0,-0])
//mirror([1,0,0])
//keycap(
//  keyID   = 2, //change profile refer to KeyParameters Struct
//  Stem = GlobalStem,
//  Dish    = GlobalDish, //turn on dish cut
//  visualizeDish = false, // turn on debug visual of Dish
//  Sym     = false //turn on 2ndrary filled symetry
//);

//-Parameters
wallthickness = 1.6; // was 1.6. bumped to 2 for inner col
topthickness = 3.4; //2 for phat 3 for chicago
stepsize = 60;  //resolution of Trajectory
step = 40;       //resolution of ellipes
fn = 60;          //resolution of Rounded Rectangles: 60 for output
layers = 50;    //resolution of vertical Sweep: 50 for output

//---Stem param
Tol    = 0.10;
stemRot = 0;
stemWid = 7.55;
stemLen = 5.55;
stemCrossHeight = 3.5;
extra_vertical  = 0.6;
StemBrimDep     = -1;
stemLayers      = 50; //resolution of stem to cap top transition
//#cube([18.16, 18.16, 10], center = true); // sanity check border


//heightDelta = -2.5; //for R2-4
heightDelta = 0.5; //for T1

//injection param
draftAngle = 0; //degree  note:Stem Only
//TODO: Add wall thickness transition?

keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx
    //Cornelius 0-5
    [17.16,  36.4,     4, 	   7, 13.5,    0,    0,    -8,     5,     0,   2,   2,      1,     6.,      1,    3.5,     2,       2], //T0R1 2u
    [17.16,  36.4,     6, 	   7,   11,    0,    0,    -8,    10,    -5,   2,   2,      1,   4.85,      1,    3.5,     2,       2], //T1R1 2u

    [17.16,  17.16,     6, 	   5,   11,  -.5,    0,    -9,     7,    10,   2,   2,      1,      5,      1,      3,     2,       2], //T0R1 1u
    [17.16,  17.16,     6, 	   5,   13,  -.5,    0,    -9,     7,     5,   2,   2,      1,      5,      1,    3.5,     2,       2], //T0R2 1u

    [17.16,  17.16,     4, 	   6,   12,   .5,    0,   -13,    -7,    10,   2,   2,      1,      5,      1,      2,     2,       2], //T1R1 1u
    [17.16,  17.16,     6, 	   5,   15,  -.5,    0,    -9,    -7,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //T1R2 1u

    //Colum 6-8
    [17.16,  17.16,   6.5, 	 6.5,11.55,   -.5,    0,     9,    -8,    -5,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4 8
    [17.16,  17.16,   6.5, 	 6.5, 9.75,   -.5,   .5,     4,    -9,    -5,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5,10.75,   -.5,    0,   -13,    -8,    -5,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    //T1 mod 9
    //[17.16,  17.16,   4., 	 6.5,  7,    -.25,   -0.5,   1,    -8,    0,   2,   2,      1,      5,      1,    3.5,     2,       2], //T1
    [17.16,  17.16,   4., 	 6.5,  7,    -.25,   -0.5,   1,    -0,    0,   2,   2,      1,      5,      1,    3.5,     2,       2], //T1 changes: reduced surface angle (y-skew)
];

dishParameters = //dishParameter[keyID][ParameterID]
[
//FFwd1 FFwd2 FPit1 FPit2  DshDep DshHDif ArcIn FArcFn FArcEx   BFwd1 BFwd2 BPit1 BPit2 BArcIn BArcFn BArcEx TanIn FTanf BTanf  expo PhiInit PhiFin
  //Column 0
  [  13,  5.5,    5,  -40,      4,    1.8,  10.5,    30,     2,       12,    8,   5,    -5,   10.5,    40,     2], //T1R1 2u
  [  13,  4.5,    7,  -39,      4,    1.8,  10.5,    15,     2,       13,    4,    8,  -30,   10.5,    20,     2], //T1R1 2u

  [   5,  4.4,    5,  -48,      5,      2,  10.5,    10,     2,        6,    4,    2,  -30,   10.5,    18,     2], //T0R1 1u
  [   5,  4.3,    5,  -48,      5,      2,  10.5,    10,     2,        6,    4,    2,  -30,   10.5,    18,     2], //T0R2 1u

  [   5,  4.4,    5,  -48,      4,    1.9,    11,    12,     2,      5.5,  3.5,    8,  -50,     11,    28,     2], //T1R1 1u
  [   5,  4.3,    5,  -48,      5,      2,  10.5,    10,     2,        6,    4,    2,  -30,   10.5,    18,     2], //T1R2 1u
  //Column 0 (keyID 6-8)
  [   6,    3.9,   18,  -50,      5,    1.8,   9.1,    15,     2,        5,  5.5,    5,  -55,    9.1,    15,     2], //R4
  [   5,  3.9,   10,  -55,      5,    1.8,   9.0,    15,     2,        5,  5.0,   10,  -55,    9.0,    15,     2], //R3
  [   6,    3.9,   10,  -50,      5,    1.8,   9.1,    15,     2,        6,    4,   13,   30,    9.1,    16,     2], //R2

  //[   5,  4.2,   8,  -55,      5,    1.8,  10.7,    15,     2,        5,   3.8,   8,   -55,    10.5,   15,     2], //T1 original
  [   5,  4.8,   2,  -55,      5,    1.8,  10.7,    15,     2,        5.5,   3.8,   2,   -55,    10.5,   15,     2], //T1
];

secondaryDishParam =
[
 //right TanIn FTanf BTanf  expo PhiInit FPhiFin BPhiFin Fkhifin, Bkhifin //left
  [  10,    7, 15.0,     2,   200,    200,    200,   80, 90,  4.05,   3,    8,     2,   213,    195,   191,   80, 90],
  [  10,    7, 15.0,     2,   200,    200,    200,   80, 90,  4.05,   3,    8,     2,   213,    195,   191,   80, 90],

  [  10,    7, 15.0,     2,   200,    200,    200,   80, 90,  4.05,   3,    8,     2,   213,    195,   191,   80, 90],
  [  10,    7, 15.0,     2,   200,    200,    200,   80, 90,  4.05,   3,    8,     2,   213,    195,   191,   80, 90],

  [  10,    7, 15.0,     2,   200,    200,    200,   80, 90,  4.05,   3,    8,     2,   213,    195,   191,   80, 90],
  [  10, 15.0, 15.0,     3,   200,    194,    194,   80, 90,  4.05,   3,    8,     2,   213,    195,   191,   80, 90],
  // column 0 (keyID 6-8)

  [   4.9,    2,    2,     2,   205,    195,    199,   80, 90,  4.05,   3,    8,     2,   213,    195,   191,   80, 90],
  [   4.9,    2,    2,     2,   207,    200,    200,   80, 90,  4.05,   3,    8,     2,   213,    195,   191,   80, 90],
  [   4.9,    2,    2,     2,   207,    199,    195,   80, 90,  4.05,   3,    8,     2,   213,    195,   191,   80, 90],

  //[   4.5, 2,    2,     2,   208,    207,    210,   80, 90,  4.05,   3,    8,     2,   210,    195,   191,   80, 90]
  [   4.5, 0,    0,     2,   208,    207,    210,   80, 90,  4.05,   3,    8,     2,   210,    195,   191,   80, 90]

];
function BottomWidth(keyID)  = keyParameters[keyID][0];  //
function BottomLength(keyID) = keyParameters[keyID][1];  //
function TopWidthDiff(keyID) = keyParameters[keyID][2];  //
function TopLenDiff(keyID)   = keyParameters[keyID][3];  //
function KeyHeight(keyID)    = keyParameters[keyID][4] + heightDelta;  //
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

function FrontForward1(keyID) = dishParameters[keyID][0];  //
function FrontForward2(keyID) = dishParameters[keyID][1];  //
function FrontPitch1(keyID)   = dishParameters[keyID][2];  //
function FrontPitch2(keyID)   = dishParameters[keyID][3];  //
function DishDepth(keyID)     = dishParameters[keyID][4];  //
function DishHeightDif(keyID) = dishParameters[keyID][5];  //
function InitArc(keyID)       = dishParameters[keyID][6];
function FrontFinArc(keyID)   = dishParameters[keyID][7];
function FrontArcExpo(keyID)  = dishParameters[keyID][8];
function BackForward1(keyID)  = dishParameters[keyID][9];  //
function BackForward2(keyID)  = dishParameters[keyID][10];  //
function BackPitch1(keyID)    = dishParameters[keyID][11];  //
function BackPitch2(keyID)    = dishParameters[keyID][12];  //
function BackInitArc(keyID)   = dishParameters[keyID][13];
function BackFinArc(keyID)    = dishParameters[keyID][14];
function BackArcExpo(keyID)   = dishParameters[keyID][15];

function TanInit(keyID)                   = secondaryDishParam[keyID][0];
function ForwardTanFin(keyID)             = secondaryDishParam[keyID][1];
function BackTanFin(keyID)                = secondaryDishParam[keyID][2];
function TanArcExpo(keyID)                = secondaryDishParam[keyID][3];
function TransitionAngleInit(keyID)       = secondaryDishParam[keyID][4];
function ForwardTransitionAngleFin(keyID) = secondaryDishParam[keyID][5];
function BackTransitionAngleFin(keyID)    = secondaryDishParam[keyID][6];
function ForwardFilAngle(keyID)           = secondaryDishParam[keyID][7];
function BackFilAngle(keyID)              = secondaryDishParam[keyID][8];

function TanInit2(keyID)                   = secondaryDishParam[keyID][9];
function ForwardTanFin2(keyID)             = secondaryDishParam[keyID][10];
function BackTanFin2(keyID)                = secondaryDishParam[keyID][11];
function TanArcExpo2(keyID)                = secondaryDishParam[keyID][12];
function TransitionAngleInit2(keyID)       = secondaryDishParam[keyID][13];
function ForwardTransitionAngleFin2(keyID) = secondaryDishParam[keyID][14];
function BackTransitionAngleFin2(keyID)    = secondaryDishParam[keyID][15];
function ForwardFilAngle2(keyID)           = secondaryDishParam[keyID][16];
function BackFilAngle2(keyID)              = secondaryDishParam[keyID][17];

function FrontTrajectory(keyID) =
  [
    trajectory(forward = FrontForward1(keyID), pitch =  FrontPitch1(keyID)), //more param available: yaw, roll, scale
    trajectory(forward = FrontForward2(keyID), pitch =  FrontPitch2(keyID))  //You can add more traj if you wish
  ];

function BackTrajectory (keyID) =
  [
    trajectory(backward = BackForward1(keyID), pitch =  -BackPitch1(keyID)),
    trajectory(backward = BackForward2(keyID), pitch =  -BackPitch2(keyID)),
  ];

function SFrontTrajectory(keyID) =
  [
    trajectory(forward = SFrontForward1(keyID), pitch =  SFrontPitch1(keyID)), //more param available: yaw, roll, scale
    trajectory(forward = SFrontForward2(keyID), pitch =  SFrontPitch2(keyID)),  //You can add more traj if you wish
  ];

function SBackTrajectory (keyID) =
  [
    trajectory(forward = SBackForward1(keyID), pitch =  SBackPitch1(keyID)),
    trajectory(forward = SBackForward2(keyID), pitch =  SBackPitch2(keyID)),
    trajectory(forward = 4, pitch =  -15),
    trajectory(forward = 6, pitch =  -5),
  ];
//------- function defining Dish Shapes
//helper function
function flip (singArry) = [for(i = [len(singArry)-1:-1:0]) singArry[i]];
function mirrorX (singArry) = [for(i = [len(singArry)-1:-1:0]) [-singArry[i][0], singArry[i][1]]];
function mirrorY (singArry) = [for(i = [len(singArry)-1:-1:0]) [singArry[i][0], -singArry[i][1]]];

//function ()

function Fade (Arry1, Arry2, t, steps, pows) =len(Arry1)==len(Arry2) ? [for(i = [0:len(Arry1)-1]) (1-pow(t/steps, pows))*Arry1[i]+pow(t/steps, pows)*Arry2[i]]: [[0,0]];

function Mix (a, b, t, steps, pows)= (1-pow(t/steps, pows))*a+pow(t/steps, pows)*b;
function smoothStart (init, fin, t, steps, power) =
  (1-pow(t/steps,power))*init + pow(t/steps,power)*fin ;

function smoothStop (init, fin, t, steps, power) =
  (fin-init)*(1-pow(1-t/steps,power))+init;

function smoothStep (init, fin, t, steps) =
  (fin - init)*(pow(t/steps,2)*3 - pow(t/steps,3)*2) + init;

function smootherStep (init, fin, t, steps) =
  (fin - init)*(6*pow(t/steps,5) - 15*pow(t/steps,4) +10* pow(t/steps,3)) + init;

function smoothestStep (init, fin, t, steps) =
  (fin - init)*(-20*pow(t/steps,7) + 70*pow(t/steps,6) - 84*pow(t/steps,5) +35*pow(t/steps,4)) + init;
function ellipse(a, b, d = 0, rot1 = 0, rot2 = 360) = [for (n = [0:step])let (t = rot1 + n*(rot2-rot1)/step) [a*cos(t)+a, b*sin(t)*(1+d*cos(t))]]; //Centered at a apex to avoid inverted face

function DishShape (a,b, phi = 200, theta, r, Sym = false) =
  concat(
//   [[c+a,b]],
    ellipse(a, b, d = 0, rot1 = 90, rot2 = phi),

    [for (n = [1:step/2])let(sig = atan(a*cos(phi)/-b*sin(phi)), t = theta*n/step*2)
     [ r*cos(-atan(-a*cos(phi)/b*sin(phi))-t)
      +a*cos(phi)
      -r*cos(sig)
      +a,

       r*sin(-atan(-a*cos(phi)/b*sin(phi))-t)
      +b*sin(phi)
      +r*sin(sig)]
    ],


    [[a,b*sin(phi)-r*sin(theta)*2]] //bounday vertex to clear ends
  );


function DishShape2 (a,b, phi = 200, theta, r, Sym = false) =
  concat(
//   [[c+a,b]],
    [[a,-(b*sin(phi)-r*sin(theta)*2)]], //bounday vertex to clear ends

mirrorY([for (n = [1:step/2])let(sig = atan(a*cos(phi)/-b*sin(phi)), t = theta*n/step*2)

       [ r*cos(-atan(-a*cos(phi)/b*sin(phi))-t)
        +a*cos(phi)
        -r*cos(sig)
        +a,

         r*sin(-atan(-a*cos(phi)/b*sin(phi))-t)
        +b*sin(phi)
        +r*sin(sig)]
      ]
    ),
    mirrorY(ellipse(a, b, d = 0,rot1 = 180, rot2 = phi)),
    ellipse(a, b, d = 0,rot1 = 180, rot2 = phi),
[for (n = [1:step/2])let(sig = atan(a*cos(phi)/-b*sin(phi)), t = theta*n/step*2)
     [ r*cos(-atan(-a*cos(phi)/b*sin(phi))-t)
      +a*cos(phi)
      -r*cos(sig)
      +a,

       r*sin(-atan(-a*cos(phi)/b*sin(phi))-t)
      +b*sin(phi)
      +r*sin(sig)]
    ],


    [[a,b*sin(phi)-r*sin(theta)*2]] //bounday vertex to clear ends
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
    ((1-t)/layers*TopWidShift(keyID)),   //X shift
    ((1-t)/layers*TopLenShift(keyID)),   //Y shift
    (t/layers*KeyHeight(keyID))    //Z shift
  ];

// function InnerTranslation(t, keyID, isInner=false) =
  // [
    // (0),//X shift
    // (0),   //Y shift
    // (t/layers*(isInner ? 0 : KeyHeight(keyID)-topthickness))    //Z shift
  // ];
function InnerTranslation(t, keyID, isInner=false) =
  [
    ((1-t)/layers*(isInner ? 0 : TopWidShift(keyID))),   //X shift
    ((1-t)/layers*(isInner ? -0.25 : TopLenShift(keyID))),   //Y shift
    (t/layers*(KeyHeight(keyID)-topthickness))    //Z shift
  ];

// function CapRotation(t, keyID, isInner=false) =
  // [
    // ((1-t)/layers*(isInner ? 0 : XAngleSkew(keyID))),   //X shift
    // ((1-t)/layers*(isInner ? -0.25 : YAngleSkew(keyID))),   //Y shift
//    ((1-t)/layers*ZAngleSkew(keyID))    //Z shift
// 0
  //];
function CapRotation(t, keyID, isInner=false) =
  [
    ((1-t)/layers*XAngleSkew(keyID)),   //X shift
    ((1-t)/layers*YAngleSkew(keyID)),   //Y shift
    ((1-t)/layers*(isInner ? 0 : ZAngleSkew(keyID)))    //Z shift
  ];

function CapTransform(t, keyID) =
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopWidthDiff(keyID)) + (1-pow(t/layers, WidExponent(keyID)))*BottomWidth(keyID) ,
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
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)+wallthickness) + (1-pow(t/layers, WidExponent(keyID)))*(BottomWidth(keyID) -wallthickness*2),
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)+wallthickness) + (1-pow(t/layers, LenExponent(keyID)))*(BottomLength(keyID)-wallthickness*2)
  ];

function StemTranslation(t, keyID) =
  [
    0,   //X shift
    0,   //Y shift
    stemCrossHeight+.1 + (t/stemLayers*(KeyHeight(keyID)- topthickness - stemCrossHeight-.1))    //Z shift
  ];

function StemRotation(t, keyID) =
  [
    ((1-t)/stemLayers*XAngleSkew(keyID)),   //X shift
    ((1-t)/stemLayers*YAngleSkew(keyID)),   //Y shift
    ((1-t)/stemLayers*ZAngleSkew(keyID))    //Z shift
  ];

function StemTransform(t, keyID) =
  [
    pow(t/stemLayers, StemExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemWid - 2*slop),
    pow(t/stemLayers, StemExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemLen - 2*slop)
  ];

function StemRadius(t, keyID) = pow(t/stemLayers,3)*3 + (1-pow(t/stemLayers, 3))*1;
  //Stem Exponent

//

function FTanRadius(t, keyID) = pow(t/stepsize,TanArcExpo(keyID) )*ForwardTanFin(keyID) + (1-pow(t/stepsize, TanArcExpo(keyID) ))*TanInit(keyID);

function BTanRadius(t, keyID) = pow(t/stepsize,TanArcExpo(keyID) )*BackTanFin(keyID)  + (1-pow(t/stepsize, TanArcExpo(keyID) ))*TanInit(keyID);

function ForwardTanTransition(t, keyID) =(1-pow(t/stepsize, TanArcExpo(keyID)))*TransitionAngleInit(keyID) +  pow(t/stepsize,TanArcExpo(keyID))*ForwardTransitionAngleFin(keyID);

function BackTanTransition(t, keyID) = (1-pow(t/stepsize, TanArcExpo(keyID) ))*TransitionAngleInit(keyID)  +  pow(t/stepsize,TanArcExpo(keyID))*BackTransitionAngleFin(keyID);

///----- KEY Builder Module
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, crossSection = CheckCross, Dish = true, SecondaryDish = false, Stem = false, StemRot = 0, homeDot = false, Stab = 0, Legends = false, Sym = false, fdm = false) {

  //Set Parameters for dish shape
  FrontPath = quantize_trajectories(FrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
  BackPath  = quantize_trajectories(BackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);

  //Scaling initial and final dim tranformation by exponents
  function FrontDishArc(t) =  pow((t)/(len(FrontPath)),FrontArcExpo(keyID))*FrontFinArc(keyID) + (1-pow(t/(len(FrontPath)),FrontArcExpo(keyID)))*InitArc(keyID);
  function BackDishArc(t)  =  pow((t)/(len(FrontPath)),BackArcExpo(keyID))*BackFinArc(keyID) + (1-pow(t/(len(FrontPath)),BackArcExpo(keyID)))*InitArc(keyID);
  FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i],
    Sym ? DishShape2( a= DishDepth(keyID), b= FrontDishArc(i), phi = ForwardTanTransition(i, keyID) , theta= 60, r = FTanRadius(i, keyID)) : DishShape( a= DishDepth(keyID), b= FrontDishArc(i), phi = ForwardTanTransition(i, keyID)  , theta= 60, r = FTanRadius(i, keyID))
  ) ];
  BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],
    Sym ? DishShape2(DishDepth(keyID), BackDishArc(i), phi = BackTanTransition(i, keyID), theta= 60, r = BTanRadius(i, keyID)) : DishShape(DishDepth(keyID), BackDishArc(i), phi = BackTanTransition(i, keyID), theta= 60, r = BTanRadius(i, keyID))
  ) ];
//  for(i=[0:len(FrontPath)-1])echo ( len(transform(FrontPath[i], DishShape2( a= DishDepth(keyID), b= FrontDishArc(i), phi = TransitionAngleInit(keyID), theta= 60
//    , r = FTanRadius(i, keyID)))), TanTransition(i, keyID));



  //builds
  difference(){
    union(){
      difference(){
        if (Sym == false)
          skin([for (i=[0:layers-1]) transform(translation(CapTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(CapTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]); //outer shell
        else
          skin([for (i=[0:layers-1]) transform(translation(CapTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(CapTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]); //outer shell
        //Cut inner shell
        if(Stem == true){
          // translate([0,0,-.001])skin([for (i=[0:layers-1]) transform(translation(InnerTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(InnerTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]);
          translate([0,0,-.001])skin([for (i=[0:layers-1]) transform(translation(InnerTranslation(i, keyID, true)) * rotation(CapRotation(i, keyID, true)), elliptical_rectangle(InnerTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]);
          // translate([0,0,-.001])skin([for (i=[0:layers-1]) transform(translation(InnerTranslation(i, keyID, false)) * rotation(CapRotation(i, keyID, false)), elliptical_rectangle(InnerTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]);

        }
      }
      if(Stem == true){
        translate([0,0,StemBrimDep])rotate(stemRot)difference(){
          //cylinderical Stem body
          cylinder(d =5.5,KeyHeight(keyID)-StemBrimDep, $fn= 32);
          skin(StemCurve);
          skin(StemCurve2);
        }

     }
    //cut for fonts and extra pattern for light?
     if(visualizeDish == true && Dish == true){
      #translate([-TopWidShift(keyID),.0001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      #translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(BackCurve);
     }
    }

    //Cuts

    //Fonts
    if(cutLen != 0){
      translate([sign(cutLen)*(BottomLength(keyID)+CapRound0i(keyID)+abs(cutLen))/2,0,0])
        cube([BottomWidth(keyID)+CapRound1i(keyID)+1,BottomLength(keyID)+CapRound0i(keyID),50], center = true);
    }
    if(Legends ==  true){
      #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([-1,-5,KeyHeight(keyID)-2.5])linear_extrude(height = 1)text( text = "ver2", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      //  #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,-3.5,0])linear_extrude(height = 0.5)text( text = "Me", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      }
    if(fdm == true){
      h=2; //height of the cutting cube
      cut_distance=0; //distance from origin
      translate([-BottomWidth(keyID)/2,0,-0.25])
        rotate([45,0,90]) cube([20,20,h], center=true);
      translate([BottomWidth(keyID)/2,0,-0.22])
        rotate([-45,0,90]) cube([20,20,h], center=true);
    }

   //Dish Shape
    if(Dish == true){
      translate([-TopWidShift(keyID),.0001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(BackCurve);


     if(SecondaryDish == true){
       #translate([BottomWidth(keyID)/2,-BottomLength(keyID)/2,KeyHeight(keyID)-SDishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(SBackCurve);
       mirror([1,0,0])translate([BottomWidth(keyID)/2,-BottomLength(keyID)/2,KeyHeight(keyID)-SDishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(SBackCurve);

     }
   }
     if(crossSection == true) {
       translate([-15,-25,-.1])cube([15,50,15]);
     }
  }
  //Homing dot
  if(homeDot == true)translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-.25])sphere(d = 1);
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
  [
    trajectory(forward = 5.25)  //You can add more traj if you wish
  ];

  StemPath  = quantize_trajectories(StemTrajectory(),  steps = 1 , loop=false, start_position= $t*4);
  StemCurve  = [ for(i=[0:len(StemPath)-1])  transform(StemPath[i],  stem_internal()) ];


function StemTrajectory2() =
  [
    trajectory(forward = .5)  //You can add more traj if you wish
  ];

  StemPath2  = quantize_trajectories(StemTrajectory2(),  steps = 10, loop=false, start_position= $t*4);
  StemCurve2  = [ for(i=[0:len(StemPath2)-1])  transform(StemPath2[i]*scaling([(1.1-.1*i/(len(StemPath2)-1)),(1.1-.1*i/(len(StemPath2)-1)),1]),  stem_internal()) ];



module choc_stem(draftAng = 5) {
  stemHeight = 3.1;
  dia = .15;
  wids = 1.2/2;
  lens = 2.9/2;
  module Stem() {
    difference(){
      translate([0,0,-stemHeight/2])linear_extrude(height = stemHeight)hull(){
        translate([wids-dia,-3/2])circle(d=dia);
        translate([-wids+dia,-3/2])circle(d=dia);
        translate([wids-dia, 3/2])circle(d=dia);
        translate([-wids+dia, 3/2])circle(d=dia);
      }

    //cuts
      translate([3.9,0])cylinder(d1=7+sin(draftAng)*stemHeight, d2=7,3.5, center = true, $fn = 64);
      translate([-3.9,0])cylinder(d1=7+sin(draftAng)*stemHeight,d2=7,3.5, center = true, $fn = 64);
    }
  }

  translate([5.7/2,0,-stemHeight/2+2])Stem();
  translate([-5.7/2,0,-stemHeight/2+2])Stem();
}


/// ----- helper functions
function rotation2d(v=[0,0], rot=0) = [v[0]*cos(rot)-v[1]*sin(rot), v[0]*sin(rot)+v[1]*cos(rot)];

function rounded_rectangle_profile(size=[1,1],r=1,fn=32) = [
	for (index = [0:fn-1])
		let(a = index/fn*360)
			r * [cos(a), sin(a)]
			+ sign_x(index, fn) * [size[0]/2-r,0]
			+ sign_y(index, fn) * [0,size[1]/2-r]
];
//Mix (a, b, t, steps, pows)

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
lp_key = [
//     "base_sx", 18.5,
//     "base_sy", 18.5,
     "base_sx", 17.65,
     "base_sy", 16.5,
     "cavity_sx", 16.1,
     "cavity_sy", 14.9,
     "cavity_sz", 1.6,
     "cavity_ch_xy", 1.6,
     "indent_inset", 1.5
     ];

/*Tester */
