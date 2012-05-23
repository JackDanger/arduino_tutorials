
#include <SPI.h>
#include <Firmata.h>
#include <Ethernet.h>

/* MACs
0x90, 0xA2, 0xDA, 0x00, 0x80, 0x76
0x90, 0xA2, 0xDA, 0x00, 0x7E, 0x0D
*/

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x80, 0x76 };
//unsigned int udpPort = 8888;
const unsigned int tcpPort = 80;
IPAddress ip(192, 168, 1, 177);
boolean gotAMessage = false; // whether or not you got a message from the client yet

const char statusCode = 's';
const char httpCode = 'h';

char verb[4];
int writer;

EthernetServer server(tcpPort);

void setup() {
  Serial.begin(9600);
  Serial.println("starting up...");
  Ethernet.begin(mac);
  Serial.print("Arduino eth0 address: ");
  Serial.println(Ethernet.localIP());
  Serial.println("");
//  Serial.print(boardStatus());
}

void loop() {
  EthernetClient client = server.available();
  if (client) {
    Serial.println("new client");
    while (client.connected()) {
      if (client.available()) {
        char incoming = client.read();
        record(incoming);
        if (timeForWeb()) greetViaHttp();
        Serial.print(incoming);
      } else {
        Serial.println("client unavailable");
        client.stop();
      }
    }
    delay(20);
    client.stop();
    Serial.println("client disconnected");
  }
}

void record(char c) {
  for(int i = 0; i < 3; i++)
    verb[i] = verb[i+1];
  verb[3] = c;
}

boolean timeForWeb() {
  return verb[0] == 'G' &&
         verb[1] == 'E' &&
         verb[2] == 'T' &&
         verb[3] == ' ';
}

void greetViaHttp() {
  server.write("HTTP/1.1 200 OK\n");
  server.write("Content-Length: 88;\n");
  server.write("\n");
  server.write("<html>");
  server.write("<div style='margin: 30% auto 0 0; text-align:center;'>Running on Arduino.</div>");
  server.write("<div style='margin: 1em auto 0 0;'><pre>");
  setWriter(&server);
  boardStatus();
  server.write("</pre></div>");
  server.write("</html>");
}

void write(String str) {
  if (int(writer) == int(&Serial))
    Serial.print(str);
  else if (int(writer) == int(&server)) {
    char c[str.length()+1];
    str.toCharArray(c, str.length()+1);
    write(c);
  }
}

void write(char str[]) {
  if (int(writer) == int(&Serial))
    Serial.print(str);
  else if (int(writer) == int(&server))
    server.write(str);
}

void setWriter(EthernetServer *server){
  writer = int(&server);
}

void boardStatus() {
  write('status:\n');
//  char buf[2];
//  for (int i = 0; i < 8; i++) {
//    str += " pin ";
//    if (i < 10) str += ' ';
//    str += itoa(i, buf, 10);
//    str += ": ";
//    str += digitalRead(i);
//    str += "/";
//    str += itoa(analogRead(i), buf, 10);
//    str += "\n";
//  }
//  str += "\n";
}

