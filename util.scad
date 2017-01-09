include <config.scad>

use <MCAD/regular_shapes.scad>


drawer();

module drawer() {
	union() {
		//the main body of the drawer
		difference() {
			translate([0,-0.01,0]) rotate([-90,0,0]) hexagon_tube(d_d + 0.02, d_w/2 + d_wt, d_wt);

			//limit height of side walls based on d_wh set in config.scad
			d_h = d_w * sqrt(3) / 2;
			wallstop = (d_wh / 100) * d_h;
			translate([-d_w,-0.1,-0.1 - d_h/2 + wallstop]) cube([d_w*2, d_d*2, d_w]);
		}

		//drawer back
		translate([0,d_d, 0]) rotate([-90,0,0]) drawer_face();
	}
}

	//drawer front
	rotate([90,0,0]) drawer_front();


module drawer_face() {
	hexagon_prism(d_wt, d_w/2 + d_wt);
}

module drawer_front() {
	ft = 3; //front panel thickness

	difference() {
		hull() {
			drawer_face();	
			translate([0, 0, d_wt]) hexagon_prism(ft, d_w/2 + d_wt - ft);
		}

		//accent groove
		translate([0,0, ft + d_wt - 0.5]) hexagon_tube(0.6, d_w/2 - ft, d_wt);
	}

	//handle
	translate([0, 0, ft]) difference() {
		rotate([0,-90,0]) translate([0, -d_w/6 - d_wt + ft, -2.5]) rotate([0,0,90]) hexagon_prism(5, d_w/4 + d_wt);

		translate([-d_w, -d_w, -d_w*2]) cube([d_w*2, d_w*2, d_w*2]);
	}

	//TODO: inscribe author info and config parameters on back of face
}
