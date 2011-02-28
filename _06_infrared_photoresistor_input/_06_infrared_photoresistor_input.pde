// Notes:
// This required 50K ohms on the infrared photoresistor to get a reading above 1.

#define LED 9
#define PHOTO 0

int val = 0;

void setup()
{
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
  pinMode(PHOTO, INPUT);
}

void loop()
{
  val = analogRead(PHOTO);
  if(val > 3){
    Serial.println(val);
  }
  analogWrite(LED, 20 + (val * 4));
  delay(20);
}
