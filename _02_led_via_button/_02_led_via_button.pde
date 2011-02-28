// Example 01: Blinking LED

#define LED 12
#define BUTTON 7

int val = 0;

void setup()
{
  pinMode(LED, OUTPUT);
  pinMode(BUTTON, INPUT);
}

void loop()
{
  val = digitalRead(BUTTON);

  if(val == HIGH) {
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED, LOW);
  }
}
