$fa = 1;
$fs = 0.4;
$fn = 50;

pcbLength = 89;
pcbWidth = 56;
pcbHeight = 17.5;
pcbThickness = 1.6;
pcbHoleEdgeSpacing = 3;
pcbHoleRadius = 1.625;
pcbColor = "blue";

cableOffset = 1;
screwRadius = 1.5;
screwRadiusBuffer = 0.25;
screwHeadRadius = 3;
screwHeadRadiusBuffer = 0.5;
screwHeadDepth = 2;
screwHeadDepthBuffer = 1;

buffer = 0.001;
tolerance = 1;
wallThickness = 2;

potentiometerHeight = 6.8;
potentiometerWidth = 9.8;
potentiometerLength = 11;
potentiometerBaseShaftDiameter = 7;
potentiometerBaseShaftLength = 5;
potentiometerShaftDiameter = 6;
potentiometerShaftLength = 7;

potentiometerHoleDiameter = potentiometerBaseShaftDiameter + 1;

rightPotVerticalOffset = 8;
rightPotHorizontalOffset = 0;
potentiometerSpacing = 15;

colorSwitchOffsetX = 0;
colorSwitchOffsetY = 5.5;
colorSwitchLength = 16;
colorSwitchWidth = 7;

patternSwitchOffset = 10.25;
patternSwitchLength = 16;
patternSwitchWidth = 6.75;

switchHeight = 8.25;

switchPaddleWidth = 3;
switchPaddleLength = 8;
switchPaddleHeight = 9;

switchPaddleHoleWidth = switchPaddleWidth + 1;
switchPaddleHoleLength = switchPaddleLength + 1;

cableThickness = 2.5;
cableWidth = 5;
strainReliefSpacing = 1;
strainReliefSpacingRadius = min(cableThickness / 4, strainReliefSpacing / 2);
strainReliefChannelHeightModifier = 0;
strainReliefChannelHeight = cableWidth + strainReliefChannelHeightModifier;

standoffLeftX = pcbHoleEdgeSpacing;
standoffRightX = pcbWidth - pcbHoleEdgeSpacing;
standoffBottomY = pcbHoleEdgeSpacing;
standoffTopY = pcbLength - pcbHoleEdgeSpacing;

pcbOffset = switchHeight + 0.25;

strainReliefLength = (cableThickness * 2) + wallThickness + strainReliefSpacing;
caseWidth = pcbWidth + (2 * tolerance) + (2 * wallThickness);
caseLength = pcbLength + (2 * tolerance) + (2 * wallThickness) + (strainReliefLength * 2);
lidHeight = wallThickness + pcbOffset + pcbThickness + cableWidth + cableOffset;

mountingLeftX = pcbHoleEdgeSpacing;
mountingRightX = pcbWidth - pcbHoleEdgeSpacing;
mountingBottomY = pcbHoleEdgeSpacing;
mountingTopY = pcbLength - pcbHoleEdgeSpacing + (strainReliefLength * 2);



screwRecessDepth = screwHeadDepth + screwHeadDepthBuffer + wallThickness;

baseHeight = pcbOffset + pcbThickness + pcbHeight + (2 * wallThickness) - lidHeight;

mountingColumnHeight = lidHeight + baseHeight - screwRecessDepth - wallThickness;

baseTabLength = 20;
baseTabHeight = wallThickness;


//translate([wallThickness + tolerance, wallThickness + tolerance, pcbOffset + wallThickness]) {
//  createPcb();
//}

// lid();

// translate([caseWidth, 0, lidHeight + baseHeight]) {
//  rotate([0, 180, 0]) {
//   base();
//  }
// }

base();

module base() {

  mountingScrewSupport = (screwHeadRadius + screwHeadRadiusBuffer + wallThickness) * 2;

  difference() {
    union() {
      difference() {
        // Shell
        translate([0, -strainReliefLength, 0]) {
         roundedCube(caseWidth, caseLength, baseHeight, wallThickness);
        }
        translate([0, -strainReliefLength, 0]) {
          translate([wallThickness, wallThickness, wallThickness]) {
           roundedCube(caseWidth - (2 * wallThickness), caseLength - (2 * wallThickness), baseHeight - wallThickness + buffer, wallThickness);
          }
        }
      }

      // Mounting screw supports
      translate([wallThickness + tolerance - (mountingScrewSupport / 2), wallThickness + tolerance - strainReliefLength - (mountingScrewSupport / 2), 0]) {
        translate([mountingLeftX, mountingBottomY, 0]) {
          roundedCube(mountingScrewSupport, mountingScrewSupport, screwRecessDepth, wallThickness);
        }
        translate([mountingRightX, mountingBottomY, 0]) {
          roundedCube(mountingScrewSupport, mountingScrewSupport, screwRecessDepth, wallThickness);
        }
        translate([mountingLeftX, mountingTopY, 0]) {
          roundedCube(mountingScrewSupport, mountingScrewSupport, screwRecessDepth, wallThickness);
        }
        translate([mountingRightX, mountingTopY, 0]) {
          roundedCube(mountingScrewSupport, mountingScrewSupport, screwRecessDepth, wallThickness);
        }
      }

      // Strain relief columns
      translate([(pcbWidth + (2 * tolerance) + (2 * wallThickness)) / 2 - wallThickness, pcbLength + (2 * tolerance) + wallThickness, 0]) {
        cube([(wallThickness * 2) + (cableThickness * 3) - wallThickness, wallThickness + (cableThickness * 2) + strainReliefSpacing, baseHeight]);
      }
      translate([(pcbWidth + (2 * tolerance) + (2 * wallThickness)) / 2 - (3 * cableThickness) - wallThickness, wallThickness - strainReliefLength, 0]) {
        cube([(wallThickness * 2) + (cableThickness * 3), wallThickness + (cableThickness * 2) + strainReliefSpacing, baseHeight]);
      }

      // Wall tabs
      translate([wallThickness, (caseLength - baseTabLength) / 2 - (baseTabLength / 2), 0]) {
        cube([wallThickness, baseTabLength, baseHeight + baseTabHeight]);
      }
      translate([caseWidth - (2 * wallThickness), (caseLength - baseTabLength) / 2 - (baseTabLength / 2), 0]) {
        cube([wallThickness, baseTabLength, baseHeight + baseTabHeight]);
      }

    }

    // Mounting screw holes
    translate([wallThickness + tolerance, wallThickness + tolerance - strainReliefLength, 0]) {
      translate([mountingLeftX, mountingBottomY, 0]) {
        mountingScrewRecess();
      }
      translate([mountingRightX, mountingBottomY, 0]) {
        mountingScrewRecess();
      }
      translate([mountingLeftX, mountingTopY, 0]) {
        mountingScrewRecess();
      }
      translate([mountingRightX, mountingTopY, 0]) {
        mountingScrewRecess();
      }
    }

  }

}


module mountingScrewRecess() {
  union() {
    cylinder(r=screwHeadRadius + screwHeadRadiusBuffer, h=screwHeadDepth + screwHeadDepthBuffer + buffer, center=false);
    translate([0, 0, screwHeadDepth + screwHeadDepthBuffer + buffer]) {
      cylinder(r=screwRadius + screwRadiusBuffer, h= 2 * wallThickness, center=false);
    }
  }
}


module lid() {

  rightPotHoleOffsetX = rightPotHorizontalOffset + (potentiometerWidth / 2);
  rightPotHoleOffsetY = rightPotVerticalOffset + (potentiometerLength / 2);
  leftSwitchHoleOffsetX = colorSwitchOffsetX + (colorSwitchWidth / 2) - (switchPaddleHoleWidth / 2);
  leftSwitchHoleOffsetY = switchPaddleHoleLength + colorSwitchOffsetY + (colorSwitchLength / 2) - (switchPaddleHoleLength / 2);
  rightSwitchHoleOffsetX = colorSwitchOffsetX + patternSwitchOffset + (patternSwitchWidth / 2) - (switchPaddleHoleWidth / 2);
  rightSwitchHoleOffsetY = switchPaddleHoleLength + colorSwitchOffsetY + (patternSwitchLength / 2) - (switchPaddleHoleLength / 2);

  difference() {
    union() {
      difference() {
        // Shell
        translate([0, -strainReliefLength, 0]) {
          roundedCube(caseWidth, caseLength, lidHeight, wallThickness);
        }
        translate([0, -strainReliefLength, 0]) {
          translate([wallThickness, wallThickness, wallThickness]) {
            roundedCube(caseWidth - (2 * wallThickness), caseLength - (2 * wallThickness), lidHeight - wallThickness + buffer, wallThickness);
          }
        }
      }

      // Standoffs
      translate([wallThickness + tolerance - (screwRadius + (2 * wallThickness)) / 2, wallThickness + tolerance - (screwRadius + (2 * wallThickness)) / 2, 0]) {
        translate([standoffLeftX - wallThickness - tolerance, standoffBottomY - strainReliefLength + tolerance - (2 * wallThickness), wallThickness]) {
          roundedCube(wallThickness + (2 * tolerance) + screwRadius + (2 * wallThickness), screwRadius + (4 * wallThickness) + strainReliefLength, pcbOffset, wallThickness);
        }
        translate([standoffRightX - tolerance, standoffBottomY - strainReliefLength + tolerance - (2 * wallThickness), wallThickness]) {
          roundedCube(wallThickness + (2 * tolerance) + screwRadius + (2 * wallThickness), screwRadius + (4 * wallThickness) + strainReliefLength, pcbOffset, wallThickness);
        }
        translate([standoffLeftX - wallThickness -  tolerance, standoffTopY - tolerance, wallThickness]) {
          roundedCube(wallThickness + (2 * tolerance) + screwRadius + (2 * wallThickness), screwRadius + (4 * wallThickness) + strainReliefLength, pcbOffset, wallThickness);
        }
        translate([standoffRightX - tolerance, standoffTopY - tolerance, wallThickness]) {
          roundedCube(wallThickness + (2 * tolerance) + screwRadius + (2 * wallThickness), screwRadius + (4 * wallThickness) + strainReliefLength, pcbOffset, wallThickness);
        }
      }

      // Mounting screw columns
      translate([wallThickness + tolerance, wallThickness + tolerance - strainReliefLength, 0]) {
        translate([standoffLeftX - wallThickness - tolerance - (screwRadius + (2 * wallThickness)) / 2, standoffBottomY + tolerance - (2 * wallThickness) - (screwRadius + (2 * wallThickness)) / 2, 0]) {
          roundedCube(wallThickness + (2 * tolerance) + screwRadius + (2 * wallThickness), screwRadius + (4 * wallThickness), lidHeight, wallThickness);
        }
        translate([mountingLeftX, mountingBottomY, wallThickness]) {
          cylinder(r=screwRadius + wallThickness, h=mountingColumnHeight);
        }

        translate([standoffRightX - tolerance - (screwRadius + (2 * wallThickness)) / 2, standoffBottomY + tolerance - (2 * wallThickness) - (screwRadius + (2 * wallThickness)) / 2, 0]) {
          roundedCube(wallThickness + (2 * tolerance) + screwRadius + (2 * wallThickness), screwRadius + (4 * wallThickness), lidHeight, wallThickness);
        }
        translate([mountingRightX, mountingBottomY, wallThickness]) {
          cylinder(r=screwRadius + wallThickness, h=mountingColumnHeight);
        }

        translate([standoffLeftX - wallThickness -  tolerance - (screwRadius + (2 * wallThickness)) / 2, mountingTopY - (screwRadius + (4 * wallThickness)) / 2 + tolerance, 0]) {
          roundedCube(wallThickness + (2 * tolerance) + screwRadius + (2 * wallThickness), screwRadius + (4 * wallThickness), lidHeight, wallThickness);
        }
        translate([mountingLeftX, mountingTopY, wallThickness]) {
          cylinder(r=screwRadius + wallThickness, h=mountingColumnHeight);
        }

        translate([standoffRightX - tolerance - (screwRadius + (2 * wallThickness)) / 2, mountingTopY - (screwRadius + (4 * wallThickness)) / 2 + tolerance, 0]) {
          roundedCube(wallThickness + (2 * tolerance) + screwRadius + (2 * wallThickness), screwRadius + (4 * wallThickness), lidHeight, wallThickness);
        }
        translate([mountingRightX, mountingTopY, wallThickness]) {
          cylinder(r=screwRadius + wallThickness, h=mountingColumnHeight);
        }
      }

      // Strain relief columns
      translate([(pcbWidth + (2 * tolerance) + (2 * wallThickness)) / 2 - wallThickness - ((cableThickness * 3)), pcbLength + (2 * tolerance) + wallThickness, 0]) {
        cube([(wallThickness * 2) + (cableThickness * 3), wallThickness + (cableThickness * 2) + strainReliefSpacing, pcbOffset + pcbThickness + cableOffset + wallThickness + strainReliefChannelHeight]);
      }
      translate([(pcbWidth + (2 * tolerance) + (2 * wallThickness)) / 2 - wallThickness, wallThickness -strainReliefLength, 0]) {
        cube([(wallThickness * 2) + (cableThickness * 3), wallThickness + (cableThickness * 2) + strainReliefSpacing, pcbOffset + pcbThickness + cableOffset + wallThickness + strainReliefChannelHeight]);
      }
    }


    // Standoff screw holes
    translate([wallThickness + tolerance, wallThickness + tolerance, 0]) {
      translate([standoffLeftX, standoffBottomY, wallThickness]) {
        screwHole(pcbOffset);
      }
      translate([standoffRightX, standoffBottomY, wallThickness]) {
        screwHole(pcbOffset);
      }
      translate([standoffLeftX, standoffTopY, wallThickness]) {
        screwHole(pcbOffset);
      }
      translate([standoffRightX, standoffTopY, wallThickness]) {
        screwHole(pcbOffset);
      }
    }

    // Mounting screw holes
    translate([wallThickness + tolerance, wallThickness + tolerance - strainReliefLength, 0]) {
      translate([mountingLeftX, mountingBottomY, wallThickness]) {
        screwHole(mountingColumnHeight);
      }
      translate([mountingRightX, mountingBottomY, wallThickness]) {
        screwHole(mountingColumnHeight);
      }
      translate([mountingLeftX, mountingTopY, wallThickness]) {
        screwHole(mountingColumnHeight);
      }
      translate([mountingRightX, mountingTopY, wallThickness]) {
        screwHole(mountingColumnHeight);
      }
    }



    // Strain relief
    translate([(pcbWidth + (2 * tolerance) + (2 * wallThickness)) / 2, wallThickness -strainReliefLength, pcbOffset + pcbThickness + cableOffset + wallThickness]) {
      strainRelief();
    }
    translate([(pcbWidth + (2 * tolerance) + (2 * wallThickness)) / 2, pcbLength + (2 * tolerance) + wallThickness + strainReliefLength, pcbOffset + pcbThickness + cableOffset + wallThickness]) {
      rotate(180) {
        strainRelief();
      }
    }

    // Potentiometer cutouts
    translate([wallThickness + tolerance, wallThickness + tolerance, 0]) {
      translate([standoffRightX - rightPotHoleOffsetX, standoffTopY - rightPotHoleOffsetY, -buffer]) {
        cylinder(h = wallThickness + (2 * buffer), r = potentiometerHoleDiameter / 2);
      }
      translate([standoffRightX - rightPotHoleOffsetX - potentiometerSpacing, standoffTopY - rightPotHoleOffsetY, -buffer]) {
        cylinder(h = wallThickness + (2 * buffer), r = potentiometerHoleDiameter / 2);
      }

      // Switch cutouts
      translate([standoffLeftX + leftSwitchHoleOffsetX, standoffTopY - leftSwitchHoleOffsetY, -buffer]) {
        cube([switchPaddleHoleWidth, switchPaddleHoleLength, wallThickness + (2 * buffer)]);
      }
      translate([standoffLeftX + rightSwitchHoleOffsetX, standoffTopY - rightSwitchHoleOffsetY, -buffer]) {
        cube([switchPaddleHoleWidth, switchPaddleHoleLength, wallThickness + (2 * buffer)]);
      }
    }

  }

}

module screwHole(height) {
  cylinder(h = height + buffer, r = screwRadius);
}

module createMeniscus(h, radius) {
  difference() {
    translate([radius / 2 + buffer, radius / 2 + buffer, 0]){
      cube([radius + (2 * buffer), radius + buffer, h + (2 * buffer)], center=true);
    }
    cylinder(h = h + (buffer * 4), r = radius, center = true);
  }
}

module createPcb() {
  color(pcbColor) {
    union() {
      difference() {
        cube([pcbWidth, pcbLength, pcbThickness]);
        translate([standoffLeftX, standoffBottomY, -buffer]) {
          cylinder(h = pcbThickness + (buffer * 2), r = pcbHoleRadius);
        }
        translate([standoffLeftX, standoffBottomY, pcbThickness / 2]) {
          rotate(180) {
            createMeniscus(h=pcbThickness, radius = pcbHoleEdgeSpacing);
          }
        }

        translate([standoffRightX, standoffBottomY, -buffer]) {
          cylinder(h = pcbThickness + (buffer * 2), r = pcbHoleRadius);
        }
        translate([standoffRightX, standoffBottomY, pcbThickness / 2]) {
          rotate(270) {
            createMeniscus(h=pcbThickness, radius = pcbHoleEdgeSpacing);
          }
        }
        translate([standoffLeftX, standoffTopY, -buffer]) {
          cylinder(h = pcbThickness + (buffer * 2), r = pcbHoleRadius);
        }
        translate([standoffLeftX, standoffTopY, pcbThickness / 2]) {
          rotate(90) {
            createMeniscus(h=pcbThickness, radius = pcbHoleEdgeSpacing);
          }
        }
        translate([standoffRightX, standoffTopY, -buffer]) {
          cylinder(h = pcbThickness + (buffer * 2), r = pcbHoleRadius);
        }
        translate([standoffRightX, standoffTopY, pcbThickness / 2]) {
          createMeniscus(h=pcbThickness, radius = pcbHoleEdgeSpacing);
        }
      }

      translate([standoffLeftX, standoffTopY - colorSwitchLength - colorSwitchOffsetY, 0]) {
        createColorSwitch();
      }
      translate([standoffLeftX + patternSwitchOffset, standoffTopY - colorSwitchLength - colorSwitchOffsetY, 0]) {
        createPatternSwitch();
      }

      translate([standoffRightX - potentiometerWidth, standoffTopY - potentiometerLength - rightPotVerticalOffset, 0]) {
        createPotentiometer();
      }
      translate([standoffRightX - potentiometerWidth - potentiometerSpacing, standoffTopY - potentiometerLength - rightPotVerticalOffset, 0]) {
        createPotentiometer();
      }

    }
  }
}

module createColorSwitch() {
  translate([0, 0, -switchHeight]) {
    cube([colorSwitchWidth, colorSwitchLength, switchHeight]);
  }
  translate([(colorSwitchWidth - switchPaddleWidth) / 2, (colorSwitchLength - switchPaddleLength) / 2, -switchHeight - switchPaddleHeight]) {
    cube([switchPaddleWidth, switchPaddleLength, switchPaddleHeight]);
  }
}

 module createPatternSwitch() {
   translate([0, 0, -switchHeight]) {
    cube([patternSwitchWidth, patternSwitchLength, switchHeight]);
  }
  translate([(patternSwitchWidth - switchPaddleWidth) / 2, (patternSwitchLength - switchPaddleLength) / 2, -switchHeight - switchPaddleHeight]) {
    cube([switchPaddleWidth, switchPaddleLength, switchPaddleHeight]);
  }
}

 module createPotentiometer() {
   translate([0, 0, -potentiometerHeight]) {
    cube([potentiometerWidth, potentiometerLength, potentiometerHeight]);
  }
  translate([potentiometerWidth / 2, potentiometerLength / 2, -potentiometerHeight - potentiometerBaseShaftLength]) {
    cylinder(h = potentiometerBaseShaftLength, r = potentiometerBaseShaftDiameter / 2);
  }
    translate([potentiometerWidth / 2, potentiometerLength / 2, -potentiometerHeight - potentiometerBaseShaftLength - potentiometerShaftLength]) {
    cylinder(h = potentiometerShaftLength, r = potentiometerShaftDiameter / 2);
  }
}

module strainRelief() {
  difference() {
    union() {
      translate([0, -wallThickness, 0]) {
        cube([cableThickness, wallThickness + cableThickness, strainReliefChannelHeight]);
      }
      translate([cableThickness - buffer, 0, 0]) {
        cube([cableThickness * 2 + buffer, cableThickness, strainReliefChannelHeight]);
      }
      translate([cableThickness * 2, cableThickness - buffer, 0]) {
        cube([cableThickness, strainReliefSpacing + cableThickness + buffer, strainReliefChannelHeight]);
      }
      translate([-wallThickness, cableThickness + strainReliefSpacing, 0]) {
        cube([(cableThickness * 3) + buffer, cableThickness, strainReliefChannelHeight]);
      }

      translate([cableThickness + (cableThickness / 4),  -(cableThickness / 4), strainReliefChannelHeight / 2]) {
        rotate(90) {
          createMeniscus(h=strainReliefChannelHeight, radius=(cableThickness / 4));
        }
      }
      translate([(cableThickness * 2) - strainReliefSpacingRadius, cableThickness + strainReliefSpacing - strainReliefSpacingRadius, strainReliefChannelHeight / 2]) {
        createMeniscus(h=strainReliefChannelHeight, radius=strainReliefSpacingRadius);
      }
      translate([(cableThickness * 2) - strainReliefSpacingRadius, cableThickness + strainReliefSpacingRadius, strainReliefChannelHeight / 2]) {
        rotate(270) {
          createMeniscus(h=strainReliefChannelHeight, radius=strainReliefSpacingRadius);
        }
      }
      translate([-cableThickness / 4, -(wallThickness - (cableThickness / 4)), strainReliefChannelHeight / 2]) {
        rotate(270) {
          createMeniscus(h=strainReliefChannelHeight, radius=cableThickness / 4);
        }
      }
      translate([cableThickness + (cableThickness / 4), -(wallThickness - (cableThickness / 4)), strainReliefChannelHeight / 2]) {
        rotate(180) {
          createMeniscus(h=strainReliefChannelHeight, radius=cableThickness / 4);
        }
      }
      translate([-wallThickness + (cableThickness / 4), cableThickness + strainReliefSpacing - (cableThickness / 4), strainReliefChannelHeight / 2]) {
        rotate(90) {
          createMeniscus(h=strainReliefChannelHeight, radius=cableThickness / 4);
        }
      }
      translate([-wallThickness + (cableThickness / 4), (cableThickness * 2) + strainReliefSpacing + (cableThickness / 4), strainReliefChannelHeight / 2]) {
        rotate(180) {
          createMeniscus(h=strainReliefChannelHeight, radius=cableThickness / 4);
        }
      }

    }
    translate([cableThickness / 4, cableThickness - (cableThickness / 4), strainReliefChannelHeight / 2]) {
      rotate(90) {
        createMeniscus(h=strainReliefChannelHeight, radius=(cableThickness / 4));
      }
    }
    translate([(cableThickness * 3) - (cableThickness / 4), (cableThickness* 2 + strainReliefSpacing ) - (cableThickness / 4), strainReliefChannelHeight / 2]) {
      createMeniscus(h=strainReliefChannelHeight, radius=(cableThickness / 4));
    }

    translate([(cableThickness * 3) - (cableThickness / 4), cableThickness / 4, strainReliefChannelHeight / 2]) {
      rotate(270) {
        createMeniscus(h=strainReliefChannelHeight, radius=(cableThickness / 4));
      }
    }
  }
}

module roundedCube(x, y, z, radius) {
  difference() {
    cube([x, y, z]);
    translate([radius, radius, z / 2]) {
      rotate([0, 0, 180]) {
        createMeniscus(h=z + (2 * buffer), radius=(radius));
      }
    }
    translate([radius, y - radius, z / 2]) {
      rotate([0, 0, 90]) {
        createMeniscus(h=z + (2 * buffer), radius=(radius));
      }
    }
    translate([x - radius, y - radius, z / 2]) {
      createMeniscus(h=z + (2 * buffer), radius=(radius));
    }
    translate([x - radius, radius, z / 2]) {
      rotate([0, 0, 270]) {
        createMeniscus(h=z + (2 * buffer), radius=(radius));
      }
    }
  }
}
