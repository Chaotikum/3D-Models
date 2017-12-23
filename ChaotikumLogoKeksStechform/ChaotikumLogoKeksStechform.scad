// Copyright (C) 2017 Ronny Bergmann <kellertuer@chaotikum.org>
//
// SPDX-License-Identifier: CC-BY-NC-4.0
//

wW = 15;
s=0.05;
// Cutter
rotate([0,0,180]) scale(1) {
  union() {
    color([1,.5,0])
    difference() {
      // Pins...
      linear_extrude(height = wW, convexity = 10)
        pinCut();
      // ... with sharpened edges
      translate([0,0,wW-1]) {
        difference() {
          linear_extrude(height=1)
            pinCut();
          union() {
            for(l = [0:s:1]) {
              translate([0,0,l])
                linear_extrude(height=s+s/2)
                  offset(delta=1-l)
                    shape();
            };
          };
        };
      };
    };
    // Cutter Top
    linear_extrude(height = 0.66, convexity = 10) {
      difference() {
        shape();
        offset(delta=-4) shape();
      };
    };
  };
};
  
// Top Printer 
translate([100,0,0]) rotate([0,0,180]) scale(1) {
  union() {
    color([1,.5,0])
    // Base plate
    linear_extrude(height = 3, convexity = 10)
      offset(delta=-0.5)
        shape();
    // > C _
    linear_extrude(height=wW, convexity=10) {
      union() {
          rotate([180,0,0])
          translate([-65,-57.2,0])
          import (file = "Parts/B-Holes.dxf");
          rotate([0,180,180])
          translate([58-65,46-57.2])
          text("C","Fira Sans",size=34,$fn=180);
      }
    }
    // Chip Outliner
    linear_extrude(height=0.66*wW, convexity=10) {
      difference() {
        offset(delta=-4.5)
          innerShape();
        offset(delta=-5)
          innerShape();
      }
    }
  }
}
module shape() {
  translate([-65,-57.2,0])
  union() {  
    import (file = "Parts/A-Base.dxf");
    import (file = "Parts/D-Feet.dxf");
  };
}
module innerShape() {
      translate([-65,-57.2,0])
  union() {  
    import (file = "Parts/A-Base.dxf");
  };
}

module pinCut() {
  difference() {
    offset(delta=1)
      shape();
    shape();
  };
}
