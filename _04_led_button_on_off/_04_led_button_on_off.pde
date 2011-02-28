// Example 01: Blinking LED

#define LED 12
#define BUTTON 7

int val = 0;
int state = LOW;
int lastVal = LOW;

void setup()
{
  pinMode(LED, OUTPUT);
  pinMode(BUTTON, INPUT);
}

void loop()
{
  val = digitalRead(BUTTON);

  if (val == HIGH && lastVal == LOW) {
    state = 1 - state;
    digitalWrite(LED, state);
    delay(100);
  }
  lastVal = val;

  digitalWrite(LED, state);
}
