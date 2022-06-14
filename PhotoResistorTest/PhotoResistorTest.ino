#include <Servo.h>
Servo ser1;
int serPin = 2;
int serVal = 180;
int lightValLeft;
int lightValRight;

int photoPin1 = A0;
int photoPin2 = A1;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  ser1.attach(serPin);
  ser1.write(serVal);
}

void loop() {
  // put your main code here, to run repeatedly:


  lightValLeft = analogRead(photoPin1);
  lightValRight = analogRead(photoPin2);

  if (lightValLeft > lightValRight+100) {
    serVal++;
  }
  if (lightValRight > lightValLeft+100) {
    serVal--;
  }
  if (serVal > 180) {
    serVal = 180;
  }
  if (serVal < 0) {
    serVal = 0;
  }
  String str = "Photoresistor 1: ";
  str += lightValLeft;
  str += "\tPhotoresistor 2: ";
  str += lightValRight;
  str += "\tServo Val: ";
  str += serVal;
  Serial.println(str);
  ser1.write(serVal);
  delay(250);






}




//  ser1.write(180);
//    lightValLeft = analogRead(photoPin1);
//    lightValRight = analogRead(photoPin2);
//    String str = "Photoresistor 1: ";
//    str += lightValLeft;
//    str += "\tPhotoresistor 2: ";
//    str += lightValRight;
//    Serial.println(str);
//    delay(250);
//    Serial.println("Photoresistor 1: " + lightValLeft + "\tPhotoresistor 2: " + lightValRight);
//
//    for (int i = 0; i <= 150; i++) {
//      ser1.write(i);
//      Serial.println(i);
//      delay(50);
//
//    }
//    for (int i = 180; i >= 0; i-=10) {
//      ser1.write(i);
//      Serial.println(i);
//      delay(500);
//  }
