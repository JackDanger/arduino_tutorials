// Based on: http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1254964306/0#0

/*
Plug:
                _____
               /
              /      0     --0v (ground)
    +5V  ---  0      0     --CLOCK
nothing  ---  0      0     --LATCH
nothing  ---  0      0     --SERIAL OUT
               _______ 


*/

/* INITIALIZATION */
// #include <ServoTimer1.h>
// ServoTimer1 servo1;

#define CLOCK 4 // set the CLOCK pin
#define LATCH 3 // set the LATCH pin
#define DATIN 2 // set the data in pin

#define COUNTDOWN 500

#define A      6
#define B      7
#define SELECT 8
#define START  9
#define UP     11
#define DOWN   12
#define LEFT   13
#define RIGHT  10

int timer_a       = 0;
int timer_b       = 0;
int timer_up      = 0;
int timer_down    = 0;
int timer_left    = 0;
int timer_right   = 0;
int timer_start   = 0;
int timer_select  = 0;

byte controller_data = 0;


/* SETUP */
void setup() {
  Serial.begin(57600);
  pinMode(LATCH, OUTPUT);
  pinMode(CLOCK, OUTPUT);
  pinMode(DATIN, INPUT);

  pinMode(A,      OUTPUT);
  pinMode(B,      OUTPUT);
  pinMode(SELECT, OUTPUT);
  pinMode(START,  OUTPUT);
  pinMode(UP,     OUTPUT);
  pinMode(DOWN,   OUTPUT);
  pinMode(LEFT,   OUTPUT);
  pinMode(RIGHT,  OUTPUT);

  digitalWrite(LATCH, HIGH);
  digitalWrite(CLOCK, HIGH);

}

/* THIS READS DATA FROM THE CONTROLLER */
void controllerRead() {
  controller_data = 0;
  digitalWrite(LATCH, LOW);
  digitalWrite(CLOCK, LOW);

  digitalWrite(LATCH, HIGH);
  delayMicroseconds(2);
  digitalWrite(LATCH, LOW);

  controller_data = digitalRead(DATIN);

  for (int i = 1; i <= 7; i ++) {
    digitalWrite(CLOCK, HIGH);
    delayMicroseconds(2);
    controller_data = controller_data << 1;
    controller_data = controller_data + digitalRead(DATIN) ;
    delayMicroseconds(4);
    digitalWrite(CLOCK, LOW);
  }

}

/* THE LED, SERVO, AND SERIAL MONITOR PROGRAM */
void loop() {

  controllerRead();

  if(controller_data != B11111111){
    Serial.println(controller_data, BIN);
  }


  // The DATIN port will transmit, one bit at a time,
  // a full byte of data corresponding to the 8 buttons:
  //  A      01111111
  //  B      10111111
  //  SELECT 11011111
  //  START  11101111
  //  UP     11110111
  //  DOWN   11111011
  //  LEFT   11111101
  //  RIGHT  11111110

  if (controller_data==B01111111){
    timer_a = COUNTDOWN;
    digitalWrite(A, HIGH);
  }
  if (controller_data==B10111111){
    timer_b = COUNTDOWN;
    digitalWrite(B, HIGH);
  }
  if (controller_data==B11011111){
    timer_select = COUNTDOWN;
    digitalWrite(SELECT, HIGH);
  }
  if (controller_data==B11101111){
    timer_start = COUNTDOWN;
    digitalWrite(START, HIGH);
  }
  if (controller_data==B11110111){
    timer_up = COUNTDOWN;
    digitalWrite(UP, HIGH);
  }
  if (controller_data==B11111011){
    timer_down = COUNTDOWN;
    digitalWrite(DOWN, HIGH);
  }
  if (controller_data==B11111101){
    timer_left = COUNTDOWN;
    digitalWrite(LEFT, HIGH);
  }
  if (controller_data==B11111110){
    timer_right = COUNTDOWN;
    digitalWrite(RIGHT, HIGH);
  }
 
  if (timer_a > 0){ timer_a--; }
  if (1 == timer_a) {
    digitalWrite(A, LOW);
  }

  if (timer_b > 0){ timer_b--; }
  if (1 == timer_b) {
    digitalWrite(B, LOW);
  }

  if (timer_select > 0){ timer_select--; }
  if (1 == timer_select) {
    digitalWrite(SELECT, LOW);
  }

  if (timer_start > 0){ timer_start--; }
  if (1 == timer_start) {
    digitalWrite(START, LOW);
  }

  if (timer_up > 0){ timer_up--; }
  if (1 == timer_up) {
    digitalWrite(UP, LOW);
  }

  if (timer_down > 0){ timer_down--; }
  if (1 == timer_down) {
    digitalWrite(DOWN, LOW);
  }

  if (timer_left > 0){ timer_left--; }
  if (1 == timer_left) {
    digitalWrite(LEFT, LOW);
  }
  if (timer_right > 0){ timer_right--; }
  if (1 == timer_right) {
    digitalWrite(RIGHT, LOW);
  }

} 
