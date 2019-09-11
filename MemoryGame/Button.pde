class Button {
  int myId;
  
  float myX;
  float myY;
  float mySize;
  
  color myColor;
  color myDarkColor;
  
  char [] mykeys = { '0', '1', '2', '3', '4', '5', '6', '7', '8'};
  boolean isLightOn = false;
  
  Button(int tempId, float tempX, float tempY, float tempSize, color tempColor) {
    myId = tempId;
    myX = tempX;
    myY = tempY;
    mySize = tempSize;
    myColor = tempColor;
    myDarkColor = lerpColor(0, myColor, 0.7);
  }
  
  void display() {
    if(isLightOn) {
      fill(myColor);
    } else {
      fill(myDarkColor);
    }
    
    rect(myX, myY, mySize, mySize);
  }
}
