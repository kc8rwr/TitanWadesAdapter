# Titan Wades Adapter

This is an adapter to attach a Titan extruder to a Mendel90 or other carriage expecting a Wades extruder. This may work with other extruders/carriages with similar mounting styles. Many parameters may be changed, perhaps making it work with less similar printers and/or extruders. If you are only looking for a ready to print solution without customizing anything STLs are available on [Thingiverse](https://www.thingiverse.com/thing:4340787). The Thingiverse page also includes an STL for a modified Mendel90 d-motor mount allowing the original DB15 connector to be used with the new extruder.

**Notes:**

* The hotend bolts to bottom of adapter just like with a Wades extruder. No additional groove mount bracket is necessary.
* The hotend attaches with 3 M3 bolts/washers as per the Wades design. Typically M3 washers are 7mm in diameter. This makes the heads of the bolts close to the hotend. That is not a problem with older J-head style hotends. It can make it hard to reach the bolts with an Allan wrench with newer hotends that have wider heat sinks. 9mm M3 washers are also available though less common. The bolt holes in the attached STLs are spaced for 9mm washers. This makes it a little easier to get a wrench in. 7mm washers might not extend far enough into the groove. Washer size is a configurable parameter in the scad file.
* I am using this with an all metal hotend that requires a fan. I did not want to run an extra wire for the fan. I am not using the probe connector on the PCB. Using a dremel I cut the trace between the probe connector and the thermistor ground. I then soldered a wire between that pin of the connector and the positive supply for the hotend and part cooling fan. At the other end of the ribbon cable I connected the wire that was supposed to be for the probe to ground. Then I connected the fan to what was supposed to be the probe connector and it is on whenever the printer is. This is not reflected in the first picture.

**Printing:**

* Best to add no supports via the slicer
* The stl files include a thin support shell for the groove mount which removes easily
* Print top/bottom halves separately
* Print the bottom half upside-down so there is no bridging
* Glue the halves together (ABS juice works well for this if you print it in ABS)
Run bolts through and tighten with nuts to keep it aligned and pressed together while drying

**This design was based on:**

* The adapter Thomas Sanladerer designed for his [review](https://toms3d.org/2016/04/24/review-e3d-titan-as-a-super-light-extruder/
) of the Titan. 
* [Wades Geared Extruder](https://reprap.org/wiki/Wade%27s_Geared_Extruder)
* The [E3D Titan](https://e3d-online.com/titan-extruder) Extruder
* And the [Mendel90](https://github.com/nophead/Mendel90) [RepRap](http://reprap.org)
