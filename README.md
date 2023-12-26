# Costco pre-lit Christmas tree replacement controller

I purchased a Costco pre-lit Christmas tree, and was disappointed to find the
mixed light pattern oscillated between white and color by passing through an
"off" state. Christmas trees should not be dark, so I set out to create a
replacement controller to allow the lights to fade directly between white and
color. Additionally, I wanted to include persistent controls to replace the
momentary buttons used by the stock controller.

## Functionality

The controller has 4 modes: solid white, solid color, oscillating between white
and color, and pastel. The brightness can be controlled, as can the speed of
oscillation and ratio of white to color generating the pastel.

## Structure

This repository is structured by separating the discrete "components" of the
project. There is a LTSpice model, a KiCad model/PCB layout, an OpenSCAD model and
associated stl file exports, and the arduino code.

## Parts

The following parts are required:

| Quantity | Part            | Description                                                      | Link                  |
| -------- | --------------- | ---------------------------------------------------------------- | --------------------- |
| 1        | Arduino         | Seeed Studio XIAO SAMD21                                         | [link][arduino]       |
| 1        | H-bridge        | Adafruit DRV8871 DC Motor Driver Breakout Board                  | [link][hbridge]       |
| 1        | DC-DC converter | Valefod 6 Pack LM2596 DC to DC High Efficiency Voltage Regulator | [link][dcdcconverter] |
| 2        | Capacitor       | 1uF ceramic                                                      | [link][capacitor]     |
| 1        | Capacitor       | 10uF ceramic                                                     | [link][capacitor]     |
| 1        | Capacitor       | 100nF ceramic                                                    | [link][capacitor]     |
| 8        | Resistor        | 10k ohm, 1/4 watt                                                | [link][transistor]    |
| 3        | Resistor        | 220 ohm, 1/4 watt                                                | [link][transistor]    |
| 4        | Diode           | 1N4148                                                           | [link][diode]         |
| 3        | Transistor      | 2N3904                                                           | [link][transistor]    |
| 2        | Potentiometer   | 10K ohm, linear                                                  | [link][potentiometer] |
| 1        | Switch          | ALCO Miniature Slide Switch 2P3T Model MHS-233                   | [link][2p3tswitch]    |
| 1        | Switch          | 2P2T                                                             |                       |
| 2        | Screw terminal  | 2 Pin 5mm/0.2inch Pitch Screw Terminal Block Connector TN-T03B   | [link][screwterminal] |
| 1        | Connector       | Male in-line Costco Christmas tree proprietary                   |                       |
| 1        | Connector       | Female in-line Costco Christmas tree proprietary                 |                       |
| 1        | Case            | Custom-design, 3D printed                                        |                       |
| 4        | Screw           | M3*6                                                             | [link][screw]         |
| 4        | Screw           | M3*10                                                            | [link][screw]         |

The switches I used were ones I had laying around. The 2P3T appears to be out of
manufacture, and the 2P2T has no identifying marks. If a PCB is to be
manufactured it should be customized to fit whatever switches are actually used.

I was not able to find a source for the proprietary in-line connectors. They are
close to the standard connector many Christmas lights use, but are not
compatible. You can remove the connectors from the existing controller if you
do not want to be able to switch back to it later, or you may be able to get a
replacement controller or switch as a warranty claim.

## Possible changes/upgrades

The bulk of the discrete components form a NOT and two AND logic gates. This
could be replaced by IC logic gates. Alternatively, the hardware-based (logic
gates) signal mixing could instead be implemented in software. Switching the
2P2T switch to another 2P3T would allow for adding an additional mode of
operation: switching instead of fading between color and white.

All 4 capacitors included are not required. Both 1uF capacitors serve to smooth
the reading from the potentiometers. The 10uF and 100nF capacitors are added as
decoupling capacitors.




[arduino]: https://www.amazon.com/gp/product/B08745JBRP
[hbridge]: https://www.amazon.com/gp/product/B06Y4VRXN4
[dcdcconverter]: https://www.amazon.com/gp/product/B076H3XHXP
[capacitor]: https://www.amazon.com/gp/product/B094HRK8QX
[diode]: https://www.amazon.com/gp/product/B0CKRMK45V
[transistor]: https://www.amazon.com/gp/product/B07G46LNCG
[potentiometer]: https://www.adafruit.com/product/4133
[2p3tswitch]: https://www.mouser.com/ProductDetail/Apem/MHS233?qs=i1KciFEqNAaoyIvbsKUxzQ%3D%3D
[screwterminal]: https://www.amazon.com/dp/B088LVP6ML
[screw]: https://www.amazon.com/gp/product/B0BPM8J5F5
