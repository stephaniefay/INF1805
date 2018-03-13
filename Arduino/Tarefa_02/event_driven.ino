#include "event_driven.h"
#include "app.h"
#include "pindefs.h"

long int now;
boolean timerIsUp = false;
boolean buttonPressed = false;
int timer = 0;
int bt_listener = 0;

void button_listen (int pin) {  
  pinMode(pin, INPUT_PULLUP);
  
}

void timer_set (int ms) {
   now = millis();
   timer = ms;
   timerIsUp = true;
   
}

void setup() {
  appinit();
  
  pinMode(LED4, OUTPUT);
}

void loop () {
  
  boolean newButton = digitalRead(KEY1);
  if(buttonPressed != newButton) {
    buttonPressed = newButton.
    button_changed(KEY1, 1);
  }
  
  if ((timerIsUp && millis()) >= (now + timer)) {
    timerIsUp = false;
    timer_expired();
  }
}
