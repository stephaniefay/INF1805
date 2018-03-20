#include "event_driven.h"
#include "app.h"
#include "pindefs.h"

long bt1 = -1;
long bt2 = -1;
int led = 1;

double timeBetweenBlink = 1000;

void appinit (void) {
  Serial.begin(9600);
  timer_set(timeBetweenBlink);

  pinMode(LED4, OUTPUT);

  button_listen(KEY1);
  button_listen(KEY2);
  button_listen(KEY3);
}

void button_changed (int p, int v) {
  Serial.println ("Estado do Botao alterado");

  if(p == KEY1 && v == 0){
    bt1 = millis();
    timeBetweenBlink -= 10;
  }
  else if (p == KEY2 && v == 0){
    bt2 = millis();
    timeBetweenBlink += 10;
  }

  if(bothButtonsPressed())
    while(1);

  Serial.println(timeBetweenBlink);
    
}

boolean bothButtonsPressed(){
   if(bt1 != -1 && bt2 != -1)
    return checkInterval();

  return false;
}

boolean checkPressed(){
  if(bt1 != -1 && bt2 != -1)
    return true;
  return false;
}

boolean checkInterval(){
  long intervalo = abs(bt1 - bt2);

  if(intervalo < 500)
    return true;
  return false;
}

void timer_expired(void) {
  led = !led;
  digitalWrite(LED4, led);
  
  timer_set(timeBetweenBlink);
}
