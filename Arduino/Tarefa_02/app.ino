#include "event_driven.h"
#include "app.h"
#include "pindefs.h"

int oldBt1;
int oldBt2;

void appinit (void) {
  timer_set(1000);
  Serial.begin(9600);  

  button_listen(KEY1);
  button_listen(KEY2);
  button_listen(KEY3);

}

void button_changed (int p, int v) {

  digitalWrite(LED4, v);
  button_listen(pin);
    
    
  
}

void timer_expired(void) {
  Serial.println ("Tempo Expirou!!");
  digitalWrite(LED4, LOW);
  
  timer_set(1000);
}
