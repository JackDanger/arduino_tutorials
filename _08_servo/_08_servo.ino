// Sweep
// by BARRAGAN <http://barraganstudio.com> 
// This example code is in the public domain.


#include <Servo.h> 
 
Servo myservo;  // create servo object to control a servo 
                // a maximum of eight servo objects can be created 
 
int pos = 0;    // variable to store the servo position 
int potpin = 0
void setup() 
{ 
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
} 
 
 
void loop() 
{ 
  val = analogRead(potpin);
  myservo.write(val / 6);  // goes from 0 degrees to 180 degrees 
  delay(15);                       // waits 15ms for the servo to reach the position 
}
