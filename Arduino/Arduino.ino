/*
  Costco christmas tree controller.
*/

#define BIAS_PIN A7
#define INTENSITY_OUTPUT_PIN A8
#define INTENSITY_INPUT_PIN A5
#define SPEED_PIN A6
#define WHITE_PIN D2
#define COLOR_PIN D3
#define PATTERN_PIN D1

const int biasFrequency = 200; // PWM frequency for controlling bias between white and color.
const int intensityFrequency = 2000;  // PWM frequency for controlling intensity/brightness of LEDs.

float x; // Value to take the sine of.
float baseIncrement = 0.05;  // Base value to increment x by each time.

float intensityVal;
float speedVal;
int pattern = 0; // White/color fade vs white/color mix.
int whiteSelected = 0; // Set tree to only white.
int colorSelected = 0; // Set tree to only color.
int bias = 0; // Ratio of white to color.
int signalType = 0; // Mixed vs solid color.

unsigned long previousMillis = 0;
const long interval = 10; // Millisecond delay between reading inputs.

void setup() {
  pinMode(BIAS_PIN, OUTPUT);
  pinMode(INTENSITY_OUTPUT_PIN, OUTPUT);
  pinMode(WHITE_PIN, INPUT);
  pinMode(COLOR_PIN, INPUT);
  pinMode(PATTERN_PIN, INPUT);
}

void loop() {
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;

    intensityVal = analogRead(INTENSITY_INPUT_PIN);
    intensityVal++; // Set intensityVal to a value between 1 and 1024 instead of 0 and 1023.
    intensityVal = intensityVal / 1024; // Convert intensityVal to a range of [0, 1].

    speedVal = analogRead(SPEED_PIN);
    speedVal++; // Set speedVal to a value between 1 and 1024 instead of 0 and 1023.
    speedVal = speedVal / 1024; // Convert speedVal to a range of [0, 1].

    pattern = digitalRead(PATTERN_PIN);
    whiteSelected = digitalRead(WHITE_PIN);
    colorSelected= digitalRead(COLOR_PIN);

    float signal = sin(x); // Generate sine wave for color fade.
    x += baseIncrement * speedVal; // Increase value of x based on the speed setting.

    /*
      If pattern switch is set, convert signal to ratio based on speed setting.
    */
    if (pattern) {
      signal = (speedVal * 2) - 1;
    }

    /*
      If switch is set to solid white or color, convert signal to match and set signalType to reflect the setting.
    */
    if (whiteSelected || colorSelected) {
      signalType = 1;
      if (whiteSelected) {
        signal = -1;
      }
      else if (colorSelected) {
        signal = 1;
      }
    }
    else {
      signalType = 0;
    }

    outputSignals(signal, signalType, intensityVal);
  }
}

void outputSignals(float signal, int signalType, float intensity) {
  float bias;
  int biasVal;
  int brightnessVal;

  /*
    If switch is set to solid white or color, set bias value to match, otherwise convert signal bias value in range [0, 1].
  */
  if (signalType) {
    if (signal < 0) {
      bias = 0.0;
    }
    else {
      bias = 1.0;
    }
  }
  else {
    bias = 0.5 + 0.5 * signal;
  }

  biasVal = (int) (bias * 1023); // Scale bias value to match expected value range for pwm().
  brightnessVal = (int) (intensity * 1023); // Scale intensity value to match expected value range for pwm().

  pinMode(BIAS_PIN, OUTPUT);

  if (signalType) {
    digitalWrite(BIAS_PIN, (int) bias);
  }
  else {
    pwm(BIAS_PIN, biasFrequency, biasVal);
  }
  pwm(INTENSITY_OUTPUT_PIN, intensityFrequency, brightnessVal);
}
