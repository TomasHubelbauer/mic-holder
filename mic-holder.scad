// Photo of the botton of the mic used as a trace template
// Uncomment if tweaking tracing, otherwise leave be, the polygon is traced now.
// color("red")
// scale(.1)
// surface(file="mic-stand.png", center=true);

// Microphone bottom width
width = 48;

// Microphone bottom height
height = 46;

// The height of the mic holder
// Selected at this value so that the test print would surpass the protruding
// USB port and reach the bottom of the mic to be able to test fit the shape.
size = 30;

// The thickness of the wall of the shape
thickness = 2;

// A quarter of the blueprint of the mic bottom
// The blueprint has a symmetry which makes it so that we can mirror this twice
// and get the whole shape.
module a(size) {
  linear_extrude(size)
  polygon([
    [0, 0],
    [width / 2, 0],
    [width / 2, 2],
    [width / 2 - .1, 4],
    [width / 2 - .2, 6],
    [width / 2 - 1.5, 12],
    [width / 2 - 3, 15],
    [width / 2 - 4, 16],
    [width / 2 - 5.3, 17],
    [width / 2 - 7, 18],
    [width / 2 - 8.5, 19],
    [width / 2 - 10.5, 20],
    [width / 2 - 13, 21],
    [width / 2 - 17, 22],
    [width / 2 - 21, 23],
    [0, height / 2],
  ]);
}

// A half of the mic bottom blueprint
module b(size) {
  a(size);
  mirror([1, 0, 0]) a(size);
}

// The entirety of the mic bottom blueprint
module c(size) {
  b(size);
  mirror([0, 1, 0]) b(size);
}

// The scale by which to grow the outer shell to achieve a so-thick wall
// The calculation takes the size with the walls and divides it by the actual
// size producing the scale factor needed to raise the dimensions to grow to
// the larger size.
factor = (width + thickness * 2) / width;

// The outer shell in which the microphone can sit snugly
difference() {
  // The scaled version of the mic outline offset to make room for the walls
  scale(factor)
  c(size);

  // The internal unscaled mic outline shape removed to carve out the space
  translate([0, 0, thickness])
  c(size + thickness);

  // A hole for the USB connector protrusion to be able to get through
  translate([0, 0, -thickness / 2])
  cylinder(thickness * 2, 10.5, 10.5);
}
