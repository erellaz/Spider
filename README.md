# Telescope Spider design
OpenScad parametric designs of telescope spiders and secondary mirror holders. Various styles. 

![Vanes styles](Vanes_styles.PNG)

## What is this?
Most reflector telescopes need a secondary mirror to be supported in front of the primary mirror. The support system, called spider, has 2 parts: a collimation system connected to the secondary and some vanes extending from the collimation system to the tube or truss assembly.
This directory offers various design styles for the collimation system and vane connections, allowing for 3, 4, 6 or 8 vanes.
The designs are parametric to easily scale to any secondary mirror size, and to be sized to the desired hardware (screws). The design is agnostic to the unit system. I usually design in metric but use imperial sizes for the hardware. You can do any combination.

## Recommended workflow
1. Open the files provided in OpenScad (an open source-software). You can then change the parametric dimensions at the beginning of the file to adjust exactly to your project requirements. You do not need to modify any of the OpenScad code to change any dimension (this is the beauty of parametric designs) but you could certainly customize the design yourself if additional features are needed (this is beauty of open-source).
2. Optional but highly recommended: 3D print a prototype to verify size and function. Iterate 1 to 2 until you are perfectly satisfied. 3D printed prototypes are cheap and easy to iterate, machining metal takes time and is expensive.
3. Comment the $fn line in the OpenScad file (just add // in front, so the lines starts with //$fn). If you forget this step your object will be faceted rater than solid in the next step, hence very difficult to machine, more expensive, or even rejected by the machine shop.
4. Open FreeCad (another open-source software), do: file>new, file>import from OpenScad,import your OpenScad file, then: file>export to .step file.
5. Get your object machined in metal with a CNC router:
  - load your stepfile to one of the online machining service. Get an instant quote, add information to tap holes, choose a finish and coating. Get the finished part delivered in days.
  - send the stepfile to your favorite machinist.
  - machine it yourself, maybe at your local maker-space or college workshop.

## Notes
As a reference, I have been using Aluminum 6061, Black Anodize, and usually tap the holes myself by hand.

## More ressources on this
Visit http://erellaz.com

