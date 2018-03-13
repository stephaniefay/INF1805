#define LED_PIN 13
#define KEY1 A1
#define KEY2 A2
#define KEY3 A3

int state;
unsigned long old;
unsigned long dif1 = 1000;
unsigned long dif2 = 1000;
int but1;
int but2;
int delayBetween = 1000;

void setup() {
  // put your setup code here, to run once:
  pinMode(LED_PIN, OUTPUT);
  pinMode(KEY1, INPUT_PULLUP);
  pinMode(KEY2, INPUT_PULLUP);
  pinMode(KEY3, INPUT_PULLUP);
  
  Serial.begin(9600);
  
  state = 1;
  
  dif1 = 1000 + millis();
  dif2 = millis();
  
}

void loop() {
  // put your main code here, to run repeatedly:
  /*int but = digitalRead(A2);
  
  if (but == 0) {
    if (digitalRead(LED_PIN)==0)
        digitalWrite(LED_PIN, HIGH);
  } else {
  digitalWrite(LED_PIN, HIGH);
  delay(1000);
  digitalWrite(LED_PIN, LOW);
  delay(1000);
  }*/
  /*unsigned long now = millis();
  if(now>=old+1000){
    old = now;
    state = !state;
    digitalWrite(LED_PIN, state);
  }*/
  
  unsigned long now = millis();
  
  int b1 = digitalRead(KEY1);
  int b2 = digitalRead(KEY2);
  
  if((now>=old+delayBetween) && (b1 == 0)) {
    delayBetween -= 10;
    but1 = now;
  }

  if ((now>=old+delayBetween) && (b2 == 0)) {
    delayBetween += 10;
    but2 = now; 
  }
  
  if (now >= old + delayBetween) {
    old = now;
    state = !state;
    digitalWrite(LED_PIN, state);
  }
  
  int interval = abs(but1 - but2);
  if (interval <= 500) {
    while(1);
  }

  }

