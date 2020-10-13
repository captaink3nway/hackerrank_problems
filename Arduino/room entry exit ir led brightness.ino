int c=0;
void setup() {
  
  Serial.begin(9600);
  pinMode(9,INPUT);
  pinMode(10,INPUT);
  pinMode(11,OUTPUT);

}

void loop() {
 while(c>=0 & c<256) 
 {
  int n1=digitalRead(9);
  int n2=digitalRead(10);
  if (n1==LOW & n2==HIGH)
  {
    delay(100);
      c=c+51;
      analogWrite(11,c);
      delay(1000);
      }
  if (n2==LOW & n1==HIGH)
  {
      c=c-51;
      analogWrite(11,c);
      delay(1000);
  }
 }
 if(c>255){
  Serial.print("FULL");
  analogWrite(11,255);
  c=255;
 }
 if(c<0){
  Serial.print("Already empty");
  analogWrite(11,0);
  c=0;
 }
}
