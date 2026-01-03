/*
  Titan Wades Adapter

  Leif Burrow
  Unforgettability.net
  2020/05
  
  Parametric script to generate a 3d-model of an adapter for attaching a Titan or compatible extruder to
  a carriage which is designed for a Wades or similar extruder.

  This script was designed and tested for a Mendel90 Strudy variant.  Parameters may need adjustment for other printers.

  To avoid bridges or support in the hotend mount this model may be split between a top part and bottom part. For convenience
  the script can generate the top and bottom parts separately, divided in the best spot.

  The mounting bolts alone would probably hold everything together. I printed the part in ABS and used "ABS Juice" (ABS scraps
  disolved in acetone) to glue it together. Just apply a little ABS juice then quickly insert bolts with washers and nuts into
  each bolt hole and tighten them down to hold it together tightly while it dries.  If you are not inserting the small hotend
  bolts at this time be careful not to get any ABS Juice in the nut traps. The screw and filament holes may be easily drilled
  out if ABS gets in them but the hex shaped nut traps are not as easy to clear. I found that when ABS Juice squirted into
  the nut traps gently inserting a drill bit and twisting removed it without the pushing the sticky ABS against the nut trap walls.

  I printed two versions of this part, one for 3mm and one for 1.75mm filament. The goal was to build up two extruder/hotend
  assemblies which are identical in every  way except filament size so that they may be easily swapped as needed.  I have added
  optional front/back supports  which the original Wades extruder did not have. Besides potentially adding a little stability
  and support for the extruder motor these "cross supports" may be labeled using the "cross_support_label..." variables making
  it easy to identify which is which at a glance. Unfortunately OpenScad is not really aware of the size of text objects. This
  makes automatic positioning very difficult. I have included a couple of variables for moving the text in/out, left/right. If you
  change the text then adjust these parameters until it looks right.

  It would not do well to split the model in the middle of the hotend groove mount. That part must be strong. Therefore there is no
  way to print the top without having an overhang or support.  I have not had good luck using my slicer's generated supports. It has
  printed well enough without support that with some filing and sanding I could get the extruder to fit.  This still leaves it a bit
  "chewed up looking". What I have found works much better is to add a support shell around the outside of the groove as part of the
  model. If the thickness of this shell is set just right it prints perfectly yet is very easy to remove. The thickness of this shell
  is one of the settable parameters. Setting it to 0 to print without a shell.

  This mount uses 3 M3 screws, nuts and washers to hold the hotend just like a Wades extruder. This worked well with the older J-head
  hotends. I have found that newer hotends with metal heat sinks can done but it's kind of tricky to mount because the fins get in
  the way of the allen wrench. Using larger washers allows the bolts to be farther from the hotend making this easier. The typical
  washers for which Wades was designed are 7mm in diameter. The biggest I managed to find in M3 were 9mm. This only moves the bolt
  1mm farther out but even that seems to be enough to help.  Alternatively, if you would prefer to use the ordinary 7mm
  washers or if you have even larger ones there is a parameter for washer size. Just set it accordingly.

  Typically on a Mendel90 both mounting holes have traps for hex head bolts. The bolts extend downwards through the Wades extruder,
  through the carriage and are fastened under the carriage via wing nuts.  This works great with the older J-head hotends.
  Unfortunately newer hotends require fans on their heatsinks and this gets in the way of the bolt and wingnut.  The usual solution
  is to omit the hex trap on the right side and instead run the bolt on that side up from under the carriage and have the wingnut on top.
  The countersink_left_mount and countersink_right_mount parameters turn the left and right mounting bolt hex traps on/off respectively.

  The standard Mendel90 carriage also has hex traps on the bottom for the extruder mounting bolt holes. Another idea I might try is to
  glue nuts into these traps. Then I would trim a pair of thumbscrews to exactly the length necessary to bolt the extruder on without
  extending down into the fan area.  That way it would not be necessary to fumble around underneath the carriage to insert the bolt.

  Similarly, the nuts that hold the hotend are flush with the base of the adapter. The extruder must slide right over them. This means
  there cannot be any extra length to the bolts that hold the hotend on. They must fill the nut for stability but extend no farther
  when fully tightened. I did this mostly by trial and error with a cheap screw cutter.
  
  This model is contained within a module with many parameters. Custom versions may be generated by editing the call at the bottom
  of the file. Alternatively this file may be left unmodified by referencing this file within a second one via a use statement and
  calling the titan_wades_adapter() method with arguments.

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

*/

/* [Main] */

//the diameter of filament or ptfe liner tube to be used with this extruder
filament_diameter = 1.75;//[1.75, 2.85, 3, 4, 6.25]

//total width (left/right) of the adapter
width = 66;

//depth (front/back) of the adapter, not counting front/back cross supports
depth = 28;

//thickness up/down of the base of the adapter (note - if the top and bottom are printed separately it must be thick enough to include top and bottom nut traps with space in between
thickness = 9;

//generate the top part, the bottom part or the whole model
side = "both"; // [top,bottom,both]

/* [Hotend Mount] */

//the diameter of the hotend hole
hotend_diameter = 16;

//height of the lip at the top of the hotend (distance from groove to top)
hotend_lip_height = 4;

//how deep into the hotend is the groove at the top
hotend_groove_depth = 2;

//the diameter of the wide part of the hotend hole
extruder_diameter = 16;

//the height of the groove
extruder_lip_height = 3.5;

//nut trap diameter for the hotend mount
hot_nut_diameter = 6.5;

//thickness of a hotend nut, dept of the nut trap
hot_nut_height = 2.4;

//diameter of the hotend bolts
hot_bolt_diameter = 3.2;

//diameter of the hotend mounting washers
washer_diameter = 9;

/* [Extruder Mount] */

//distance between the center of the filament hole and the wedge which keeps the extruder from spinning around it's mount. Change for mounting a different width of extruder.
extruder_stop = 14;//[5:0.25:20]

//distance between the top of the adapter base and the bottom of the groove in the extruder mount
extruder_groove_raise = 4;

//how deep the extruder mount groove goes towards the filament hole
extruder_groove_depth = 2;

//how tall is the extruder mount grove
extruder_groove_height = 6;

//the thickness of the extruder lip support. It should be just thick enough to print cleanly yet be easy to remove. A value of 0.6 worked well for me but this may vary.
extruder_lip_support = 0.6;

//print a skin this thick across the filament hole right at the top of the extruder mounting hole. For single-piece printing, this allows the printer to bridge across the hole rather than stopping in mid-air at the center. It may be easily drilled out for use.
filament_hole_support_skin = 0.5;

/* [Carriage Mount] */

//should the left-hand mounting bolt hole include a trap for the head at top
countersink_left_mount = true; // [true,false]

//if there is a trap on the left is it hex vs round
mount_bolt_hex_left = true; // [true,false]

//should the right-hand mounting bolt hole include a trap for the head at top
countersink_right_mount = false; // [true, false]

//if there is a trap on the right is it hex vs round
mount_bolt_hex_right = false; // [true,false]

//how far apart are the mounting holes
mount_bolt_spacing = 50;

//diameter of the mounting holes
mount_bolt_diameter = 4.5;

//head diameter for round headed mounting bolts
mount_bolt_head_diameter = 7.5;

//head height for round headed mounting bolts
mount_bolt_head_height = 2.4;

//head height for hex headed mounting bolts
mount_bolt_hex_head_height = 2.4;

//head height for round headed mounting bolts
mount_bolt_hex_diameter = 8.5;

/* [Front/Back Wings] */

//length of the front/back cross supports, 0 for none, front and back use the same length
cross_support_length = 10;

//how wide left/right should the front/back cross suppports be
cross_support_width = 20;

//text to etch into the cross supports - good for labeling the filament width
cross_support_label="1.75";

//left-side offset to begin the cross support label text
cross_support_label_loffset = 1;

//text offset from the outer (front/back) edge of the cross support
cross_support_label_ooffset = 2;
                         

module titan_wades_adapter(hotend_diameter = 16,
									hotend_lip_height = 4,
									hotend_groove_depth = 2,
									extruder_diameter = 16,
									extruder_lip_height = 3.5,
									extruder_lip_support = 0.6,
									filament_hole_support_skin = 0.4,
									extruder_groove_raise = 4,
									extruder_groove_depth = 2,
									extruder_groove_height = 6,
									hot_nut_diameter = 6.5,
									hot_nut_height = 2.4,
									hot_bolt_diameter = 3.2,
									washer_diameter = 9,
									countersink_left_mount = true,
									countersink_right_mount = false,
                           mount_bolt_spacing = 50,
									mount_bolt_diameter = 4.5,
									mount_bolt_head_diameter = 7.5,
									mount_bolt_head_height = 2.4,
									mount_bolt_hex_head_height = 2.4,
									mount_bolt_hex_diameter = 8.5,
									mount_bolt_hex_left = true,
									mount_bolt_hex_right = false,
									filament_diameter = 3,
									width = 66,
									depth = 28,
									thickness = 9,
									side = "both",
                           cross_support_length=10,
                           cross_support_width=20,
                           cross_support_label="3",
                           cross_support_label_loffset=7,
                           cross_support_label_ooffset=2,
                           extruder_stop=14){

	$fn = 360;

	difference(){
		union(){
			linear_extrude(height = thickness){
				//main left/right body
				hull(){
					for (t=[[width/2 - 3.5, depth/2 - 3.5], [-width/2 + 3.5, depth/2 - 3.5], [-width/2 +3.5, -depth/2 + 3.5], [width/2 - 3.5, -depth/2 + 3.5]])
						{
							translate(t)
								{
									circle(d=7);
								}
						}
				}
				//optional front/back cross supports
				if (cross_support_length > 0 && cross_support_width > 0){
					hull(){
						for (t=[[cross_support_width/2 - 3.5, cross_support_length + (depth/2) - 3.5], [-cross_support_width/2 + 3.5, cross_support_length + (depth/2) - 3.5], [-cross_support_width/2 +3.5, -cross_support_length - (depth/2) + 3.5], [cross_support_width/2 - 3.5, -cross_support_length - (depth/2) + 3.5]])
							{
								translate(t)
									{
										circle(d=7);
									}
							}
					}
				}
			}
			//optional extruder stop
			if (0 < extruder_stop){
				translate([extruder_stop, -0.33*depth, thickness+5]){
					rotate([-90, 0, 0]){
						linear_extrude(height=depth*0.66){
							polygon([[0, 0], [5, 5], [0, 5]]);
						}
					}
				}
			}  
			translate([0, 0, thickness - 1]){
				cylinder(d=extruder_diameter - (2 * extruder_groove_depth), h = extruder_groove_raise + extruder_groove_depth + extruder_groove_height + 1);
				difference(){
					cylinder(d=extruder_diameter, h = extruder_groove_raise + extruder_lip_height + extruder_groove_height + 1);
					translate([0, 0, 1 + extruder_groove_raise]){
						cylinder(d = extruder_diameter + (extruder_lip_support==0 ? 1 : -1*extruder_lip_support*2), h = extruder_groove_height);
					}
				}
			}
		}
		translate([0, 0, -1]){
			for (a=[20, 150, 270]){
				rotate(a){
					translate([0, (hotend_diameter/2) + (washer_diameter/2) - hotend_groove_depth, 0]){
						cylinder(d=hot_bolt_diameter, h=thickness + 2);
						translate([0, 0, thickness + 1 - hot_nut_height]){
							cylinder(d=hot_nut_diameter, $fn = 6, h = hot_nut_height * 2);
						}
					}
				}
			}
			cylinder(d = hotend_diameter, h=hotend_lip_height + 1); //hotend mount hole
			//filament hole
			translate([0, 0, (0 < filament_hole_support_skin ? 1 + filament_hole_support_skin : 0) + hotend_lip_height]){
				cylinder(d = filament_diameter, h=thickness + extruder_groove_raise + extruder_groove_height + 0 - (0 < filament_hole_support_skin ? filament_hole_support_skin : -1));
			}
			translate([mount_bolt_spacing/-2, 0, 0])
				{
					cylinder(d=mount_bolt_diameter, h=thickness + 2);
					if (countersink_left_mount){
						translate([0, 0, thickness - (mount_bolt_hex_left ? mount_bolt_hex_head_height : mount_bolt_head_height)]){
							cylinder(d = mount_bolt_hex_left ? mount_bolt_hex_diameter : mount_bolt_head_diameter, h = 2 + (mount_bolt_hex_left ? mount_bolt_hex_head_height : mount_bolt_head_height), $fn = mount_bolt_hex_left ? 6 : $fn);
						}
					}
				}
			translate([mount_bolt_spacing/2, 0, 0])
				{
					cylinder(d=mount_bolt_diameter, h=thickness + 2);
					if (countersink_right_mount){
						translate([0, 0, thickness - (mount_bolt_hex_right ? mount_bolt_hex_head_height : mount_bolt_head_height)]){
							cylinder(d = mount_bolt_hex_right ? mount_bolt_hex_diameter : mount_bolt_head_diameter, h = 2 + (mount_bolt_hex_right ? mount_bolt_hex_head_height : mount_bolt_head_height), $fn = mount_bolt_hex_right ? 6 : $fn);
						}
					}
				}
		}
		if ("both" != side){
			division = ((thickness - max(hot_nut_height, mount_bolt_head_height) - hotend_lip_height) / 2) + hotend_lip_height;
			assert(division > 0, "Cannot split, no vertical space between topside nut traps and bottomside hotend opening");
			if ("top" == side){
				translate([-width/2 - 1, -depth/2 - cross_support_length - 1, -1]){
					cube([width+2, depth+(2*cross_support_length)+2, division]);
				}
			}
			if ("bottom" == side){
				translate([-width/2 - 1, -depth/2 -cross_support_length - 1, division]){
					cube([width+2, depth+(2*cross_support_length)+2, 100]);
				}
			}
		}
		//filament size label (only available if front/back cross supports exist)
		if (cross_support_width > 0 && cross_support_length > 0){
			for (i=[[0, thickness-2], [180, 2]]){
				let (t=i.x, z=i.y){
					translate([0, 0, z]){
						for (angle=[0, 180]){
							rotate([0, t, angle]){
								linear_extrude(height = 3){
									translate([(-cross_support_width/2) + cross_support_label_loffset, -(depth/2) - (cross_support_length) + cross_support_label_ooffset]){
										resize([0, 6.6], auto=true){
											text(text=cross_support_label);
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}


titan_wades_adapter(
	filament_diameter = filament_diameter,
	width = width,
	depth =depth,
	thickness = thickness,
	side = side,
	hotend_diameter = hotend_diameter,
	hotend_lip_height = hotend_lip_height,
	hotend_groove_depth = hotend_groove_depth,
	extruder_diameter = extruder_diameter,
	extruder_lip_height = extruder_lip_height,
	hot_nut_diameter = hot_nut_diameter,
	hot_nut_height = hot_nut_height,
	hot_bolt_diameter = hot_bolt_diameter,
	washer_diameter = washer_diameter,
	extruder_stop = extruder_stop,
	extruder_groove_raise = extruder_groove_raise,
	extruder_groove_depth = extruder_groove_depth,
	extruder_groove_height = extruder_groove_height,
	extruder_lip_support = extruder_lip_support,
	filament_hole_support_skin = filament_hole_support_skin,
	countersink_left_mount = countersink_left_mount,
	mount_bolt_hex_left = mount_bolt_hex_left,
	countersink_right_mount = countersink_right_mount,
	mount_bolt_hex_right = mount_bolt_hex_right,
	mount_bolt_spacing = mount_bolt_spacing,
	mount_bolt_diameter = mount_bolt_diameter,
	mount_bolt_head_diameter = mount_bolt_head_diameter,
	mount_bolt_head_height = mount_bolt_head_height,
	mount_bolt_hex_head_height = mount_bolt_hex_head_height,
	mount_bolt_hex_diameter = mount_bolt_hex_diameter,
	cross_support_length = cross_support_length,
	cross_support_width = cross_support_width,
	cross_support_label = cross_support_label,
	cross_support_label_loffset = cross_support_label_loffset,
	cross_support_label_ooffset = cross_support_label_ooffset
);
