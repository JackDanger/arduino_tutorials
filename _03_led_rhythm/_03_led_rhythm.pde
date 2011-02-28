// Example 01: Blinking LED

#define LED 12
#define BUTTON 7
#define COUNTDOWN 100000000
#define BEAT      10000000

int val = 0;
int pattern = 0;

void setup()
{
  pinMode(LED, OUTPUT);
  pinMode(BUTTON, INPUT);
}

void loop()
{
  val = digitalRead(BUTTON);

  if(val == HIGH) {
    pattern = COUNTDOWN;
  }

  if(pattern < 1 || ((pattern % BEAT) > (BEAT/2))){
    digitalWrite(LED, HIGH);
    pattern = pattern - 1;
  } else {
    digitalWrite(LED, LOW);
  }
}
