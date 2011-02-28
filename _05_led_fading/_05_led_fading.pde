#define RED 9
#define GRN 8
#define BLU 7

int active = 0;
int i = 0;

void setup()
{
  pinMode(RED, OUTPUT);
  pinMode(GRN, OUTPUT);
  pinMode(BLU, OUTPUT);
}

void loop()
{
  for (active = 7; active < 10; active++) {
    for (i = 0; i < 63; i++) {
      analogWrite(active, i);
      delay(10);
    }
  }
  for (active = 7; active < 10; active++) {
    for (i = 63; i >= 0; i--) {
      analogWrite(active, i);
      delay(10);
    }
  }

}
