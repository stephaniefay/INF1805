#include "event_driven.h"
#include "app.h"
#include "pindefs.h"

boolean buttonPressed[3];
int btIni[3];
long int timer = 0;

void button_listen (int pin) {  
  for (int i = 0; i < 3; i++) {

    if(btIni[i] == -1) {
      btIni[i] = pin;
      pinMode(pin, INPUT_PULLUP);
      return;
    }
    
  }
  
}

void timer_set (int ms) {
   timer = millis() + ms;   
}

void setup() {
  for (int i = 0; i < 3; i++) {
    btIni[i] = -1;
    buttonPressed[i] = false;
  }
  appinit();
}

void loop () {
  observerButtons();
  observerTime();
}

void observerButtons() {
  for (int id = 0; id < 3; id++) {
    if(btIni[id] != -1) {
      int bt = btIni[id];
      int val = digitalRead(bt);

      boolean verify;
      if((val == 0 && buttonPressed[id] == false) || (val != 0 && buttonPressed[id] == true)) {
        buttonPressed[id] = !buttonPressed[id];
        verify = true;
      } else verify = false;

      if (verify)
        button_changed(bt, val);
      }
      
    }
}


void observerTime() {
  if ((timer > 0) || (timer < 0)) {
    if (millis() >= timer) {
      timer = 0;
      timer_expired();
    }
  }
}
  

