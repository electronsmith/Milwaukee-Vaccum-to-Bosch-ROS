/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
*
* Bosch ROS Sander Dust Port Adapter
* Benjamen Johnson <workshop.electronsmith.com>
* 20220316
* openSCAD Version: 2019.05 
*******************************************************************************/
/*[Hidden]*/
ver = "ELECTRONSMITH V1_0";

// Control how smooth curves are
$fa=2;
$fs=0.1;

// Add a little to cuts to make it render properly
$dl = 0.01;

/*[Hose Parameters]*/
/*******************************************************************************
* Variables for the hose connector
*******************************************************************************/
// Min diameter of the hose connector
min_hose_dia = 31.1;

// Max diameter of the hose connector
max_hose_dia = 33.1;

// distance between min and max diameters
hose_connector_len = 40;

// Calculate how to scale the hose connector
hose_scale = max_hose_dia/min_hose_dia;

/*[Adapter Parameters]*/
/*******************************************************************************
* Variables for the adapter
*******************************************************************************/

// Height of the transition from Hose connector to the dust port connector
transition_height = 10;

// Adapter wall thickness
wall_thickness = 2.5;

/*[Dust Port Parameters (Advanced)]*/
/*******************************************************************************
* Variables ffor the dust port
*******************************************************************************/
// Length of the dust port connector
port_len = 25;

// Diameter of the dust port connector
port_dia = 29.2;

// Diameter of the O-ring used to keep the connector on
ring_dia = 30.2;

// How far is the O-ring from the end of the dust port
ring_dist = 19;

/*******************************************************************************
* Make it
*******************************************************************************/
min_outside_dia = min_hose_dia+2*wall_thickness;
max_outside_dia = max_hose_dia+2*wall_thickness;
port_outside_dia = port_dia+2*wall_thickness;

union(){
    //Hose connector
    difference(){
        cylinder(d2=min_outside_dia,d1=max_outside_dia,h=hose_connector_len);
        cylinder(d2=min_hose_dia,d1=max_hose_dia,h=hose_connector_len);
    } //difference
    
    // Transition
    translate([0,0,hose_connector_len])
    difference(){
        cylinder(d1=min_outside_dia,d2=port_outside_dia,h=transition_height);
        cylinder(d1=min_hose_dia,d2=port_dia,h=transition_height);
    } //difference

    // Port connector
    translate([0,0,hose_connector_len+transition_height])
    difference(){
        cylinder(d=port_outside_dia,h=port_len);
        cylinder(d=port_dia,h=port_len);
        
        //Cut out for O-ring
        translate([0,0,ring_dist])
        cylinder(d=ring_dia,h=port_len-ring_dist);
    } //difference
} //end union