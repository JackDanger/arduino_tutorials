// Taken from: http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1254964306/0#0

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

int latch = 2; // set the latch pin
int clock = 3; // set the clock pin
int datin = 4; // set the data in pin
byte controller_data = 0;
int ledpin = 9;


/* SETUP */
void setup() {
  Serial.begin(57600);
  pinMode(latch,OUTPUT);
  pinMode(clock,OUTPUT);
  pinMode(datin,INPUT);
  pinMode(ledpin, OUTPUT);

  digitalWrite(latch,HIGH);
  digitalWrite(clock,HIGH);

  // servo1.attach(10);

}

/* THIS READS DATA FROM THE CONTROLLER */
void controllerRead() {
  controller_data = 0;
  digitalWrite(latch,LOW);
  digitalWrite(clock,LOW);

  digitalWrite(latch,HIGH);
  delayMicroseconds(2);
  digitalWrite(latch,LOW);

  controller_data = digitalRead(datin);

  for (int i = 1; i <= 7; i ++) {
    digitalWrite(clock,HIGH);
    delayMicroseconds(2);
    controller_data = controller_data << 1;
    controller_data = controller_data + digitalRead(datin) ;
    delayMicroseconds(4);
    digitalWrite(clock,LOW);
  }

}

/* THE LED, SERVO, AND SERIAL MONITOR PROGRAM */
void loop() {

  controllerRead();

  Serial.println(controller_data, BIN);

  // if (controller_data==B11101111){
    // Serial.println("Button has been Pressed");   
     //}  else {
     //Serial.println("Button not pressed");
     //}

  //for REFERENCE:  
  //UP = 11110111
  //DOWN=11111011
  //LEFT=11111101
  //RIGHT=11111110
  //SELECT=11011111
  //START=11101111
  //A=01111111
  //B=10111111

  if (controller_data==B01111111){
   digitalWrite(ledpin, HIGH);
   }
 
  if (controller_data==B10111111){
   digitalWrite(ledpin, LOW);
  }
 
  // if (controller_data==B11110111){
  //  servo1.write(180);
  // }  
  // 
  // if (controller_data==B11111011){
  //  servo1.write(0);
  // }
  // 
  // if (controller_data==B11111110){
  //  servo1.write(90);
  // }

  delay(100);
} 
