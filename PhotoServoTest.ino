#include <Servo.h>
Servo serRoll;
Servo serPitch;
int rollPin = 8;
int pitchPin = 9;

int rollVal = 90;
int pitchVal = 90;

int photoPinTL = A2;
int photoPinTR = A3;
int photoPinBL = A4;
int photoPinBR = A5;
float valTL;
float valTR;
float valBL;
float valBR;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  serRoll.attach(rollPin);
  serPitch.attach(pitchPin);
  serRoll.write(rollVal);
  serPitch.write(pitchVal);
}

void loop() {
  // put your main code here, to run repeatedly:
  valTL = analogRead(photoPinTL);
  valTR = analogRead(photoPinTR);
  valBL = analogRead(photoPinBL);
  valBR = analogRead(photoPinBR);

  //  serRoll.write(rollVal);
  //  serPitch.write(pitchVal);


  //      for (int i = 0; i <= 150; i++) {
  //      serRoll.write(i);
  //      serPitch.write(i);
  //      Serial.println(i);
  //      delay(150);
  //
  //    }
  //    for (int i = 180; i >= 0; i-=10) {
  //      serRoll.write(i);
  //      serPitch.write(i);
  //      Serial.println(i);
  //      delay(150);
  //  }

  String str = "TL: ";
  str += valTL;
  str += "\tTR: ";
  str += valTR;
  str += "\tBL: ";
  str += valBL;
  str += "\tBR: ";
  str += valBR;
  str += "\tRoll: ";
  str += rollVal;
  str += "\Pitch: ";
  str += pitchVal;
  //  Serial.println(str);
  delay(50);







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


//  lightValLeft = 0;
//  lightValRight = 0;
//
//  for (int i = 0; i < 10; i++) {
//    lightValLeft += analogRead(photoPin1);
//    lightValRight += analogRead(photoPin2);
//    delay(50);
//  }
//  lightValLeft /= 10.0;
//  lightValRight /= 10.0;
//
//  if (lightValLeft > lightValRight + 100) {
//    serVal++;
//  }
//  if (lightValRight > lightValLeft + 100) {
//    serVal--;
//  }
//  if (serVal > 180) {
//    serVal = 180;
//  }
//  if (serVal < 0) {
//    serVal = 0;
//  }
//  String str = "Photoresistor 1: ";
//  str += lightValLeft;
//  str += "\tPhotoresistor 2: ";
//  str += lightValRight;
//  str += "\tServo Val: ";
//  str += serVal;
//  Serial.println(str);
//  ser1.write(serVal);
//  delay(250);
