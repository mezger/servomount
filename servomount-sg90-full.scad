$fn=100;

/* SG90 mini servo */
sg90mount();


module sg90mount()
{
    space=0.25; 
    sh=22.75+space; //Servo Höhe des Quaders
    sb=12.75+space; //Servo Breite
    sl=22.75+space; //Servo Länge des Quaders

    tcx=4.9;  //oberer Klotz X
    tcy=4;    //oberer Klotz y

    mcx=tcx;  //mittlerer Klotz X
    mcy=9.5;  //mittlerer Klotz Y

    tl=sl+2*tcx;//Servo Länge total mit Halter
    hw=2.6;   //Stärke des Servohalters

    wall=2.2; //Sockelstärke
    nose=1;   //Stärke der Haltenase

    
    difference()
    {
        union()
        {
            //Sockel
            cube([tl, sh, wall]);

            //obere Klötze
            translate([0,sh-tcy,wall]) cube([tcx,tcy,sb]);
            translate([tl-tcx,sh-tcy,wall]) cube([tcx,tcy,sb]);

            //mittlere Klötze
            translate([0,sh-tcy-hw-mcy,wall]) cube([mcx,mcy,sb]);
            translate([tl-mcx,sh-tcy-hw-mcy,wall]) cube([mcx,mcy,sb]);
            
            //Nasen mittlere Klötze
            translate([0,sh-tcy-hw-mcy,wall+sb]) cube([mcx+nose,mcy,nose]);
            translate([tl-mcx-nose,sh-tcy-hw-mcy,wall+sb]) cube([mcx+nose,mcy,nose]);
            
            //unterer Klotz
            translate([tcx,-wall,0]) cube([sl,wall,sb+wall]);
            translate([tcx,-wall,sb+wall]) cube([sl,wall+nose,nose]);
            
            //Stützen für unteren Klotz
            hull()
            {
                translate([mcx-wall,0,0]) cube([wall,sh-tcy-hw-mcy,wall]);
                rotate([90,0,0]) translate([mcx-wall,0,0]) cube([wall,sh-tcy-hw-mcy+wall,wall]);
            }
            hull()
            {
                translate([mcx+sl,0,0]) cube([wall,sh-tcy-hw-mcy,wall]);
                rotate([90,0,0]) translate([mcx+sl,0,0]) cube([wall,sh-tcy-hw-mcy+wall,wall]);
            }
        }
        //Bohrungen Sockel
        translate([9,sh/2,0]) cylinder(d=2.5, h=wall);
        translate([9,sh/2,wall-1]) cylinder(d1=2.5, d2=4, h=1);
        translate([tl-9,sh/2,0]) cylinder(d=2.5, h=wall);
        translate([tl-9,sh/2,wall-1]) cylinder(d1=2.5, d2=4, h=1);
        
        //Bohrungen seitlich im mittleren Klotz
        translate([mcx,sh-tcy-hw-mcy/2,wall+sb/2]) rotate([0,-90,0]) cylinder(d=2.5, h=mcx);
        translate([mcx,sh-tcy-hw-mcy/2,wall+sb/2]) rotate([0,-90,0]) cylinder(d1=4, d2=2.5, h=1);
        translate([tl,sh-tcy-hw-mcy/2,wall+sb/2]) rotate([0,-90,0]) cylinder(d=2.5, h=mcx);
        translate([tl-mcx+1,sh-tcy-hw-mcy/2,wall+sb/2]) rotate([0,-90,0]) cylinder(d1=2.5, d2=4, h=1);
        
        //Bohrungen für Servo mittlerer Klotz
        translate([mcx/2,sh-tcy-hw,wall+sb/2]) rotate([90,0,0]) cylinder(d=2,h=5);
        translate([tl-mcx/2,sh-tcy-hw,wall+sb/2]) rotate([90,0,0]) cylinder(d=2,h=5);
        
        //Bohrungen für Servo oberer Klotz
        translate([mcx/2,sh,wall+sb/2]) rotate([90,0,0]) cylinder(d=2,h=4);
        translate([tl-mcx/2,sh,wall+sb/2]) rotate([90,0,0]) cylinder(d=2,h=4);
        
        //Bohrungen unterer Klotz
        translate([9,0,wall+sb/2]) rotate([90,0,0]) cylinder(d=2.5, h=wall);
        translate([9,0,wall+sb/2]) rotate([90,0,0]) cylinder(d1=4, d2=2.5, h=1);
        translate([tl-9,0,wall+sb/2]) rotate([90,0,0]) cylinder(d=2.5, h=wall);
        translate([tl-9,0,wall+sb/2]) rotate([90,0,0]) cylinder(d1=4, d2=2.5, h=1);
   }
}
