#define LED_PIN 13
#define KEY1 A1
#define KEY2 A2
#define KEY3 A3

int state;
unsigned long old;
unsigned long dif1;
unsigned long dif2;
int but1;
int but2;
int timez;

void setup() {
  // put your setup code here, to run once:
  pinMode(LED_PIN, OUTPUT);
  pinMode(KEY1, INPUT_PULLUP);
  pinMode(KEY2, INPUT_PULLUP);
  pinMode(KEY3, INPUT_PULLUP);
  
  Serial.begin(9600);
  
  state = 1;
  old = millis();
  timez = 1000;
  
  but1 = digitalRead(KEY1);
  but2 = digitalRead(KEY2);

  dif1 = millis();
  delay(600);
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
  if(now>=old+timez) {
    old = now;
    state = !state;
    digitalWrite(LED_PIN, state);
  }
  
  Serial.println(timez);

    boolean flag1 = false;
    boolean flag2 = false;
  
  if(digitalRead(KEY1) != but1) {
    dif1 = millis();
    flag1 = true;
  } 
  
  Serial.println(timez);
  
  if(digitalRead(KEY2) != but2) {
    dif2 = millis();
    flag2 = true;
  } 
  
  Serial.println(flag1);
  Serial.println(flag2);
  
  

  if (dif2 - dif1 <= 500) {
    digitalWrite(LED_PIN, HIGH);
    while(1);
  }
  

  }

