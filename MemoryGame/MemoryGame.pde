PFont fo;
PFont bo;
PImage img;
PImage fini;

Button [] buttons = new Button[8];

SimonToneGenerator simonTones;

int [] simonSentence = new int [32];
int positionInSentence = 0;
int currentLengthOfTheSentence = 0;
int talkTime = 420;
int timeOut = 0;

boolean isSimonsTurn = false;
boolean isWrong = false;
boolean isGameStarted = true;
boolean isScoreNeeded = true; 

int level=0;
int start;
int count; 
int startTime; // The (last) time when the mouse have been clicked
final int DISPLAY_DURATION = 1000; // in milliseconds = 1s
 
void setup() {
  size(900,900);
  fo = createFont("Avenir Medium.ttf", 32);
  bo = createFont("Avenir Bold.ttf", 32);
  img = loadImage("Bare Conductive LOGO.png");
  fini = loadImage("Game Asset.png");
  
  buttons[0] = new Button(0,0,0,300,#C81E28);
  buttons[1] = new Button(1,300,0,300,#009e77);
  buttons[2] = new Button(2,600,0,300,#E6BE00);
  buttons[3] = new Button(3,0,300,300,#E6BE00);
  buttons[4] = new Button(4,600,300,300,#009e77);
  buttons[5] = new Button(5,0,600,300,#009e77);
  buttons[6] = new Button(6,300,600,300,#E6BE00);
  buttons[7] = new Button(7,600,600,300,#C81E28);
  
  simonTones = new SimonToneGenerator(this);
  
  start = millis();
  count=0;
}


  
void draw() {
   noStroke();
   smooth();
   
   if (isGameStarted){
     fill(0);
     textSize(25);
     textAlign(CENTER, CENTER);
     textFont(fo);
     text ("Play", 430,515);
     triangle(470, 510, 470, 530, 490, 520);
   }
    
   if( (millis()-start) >= 1000 ){
     start = millis();
     count++;
   }

  simonTones.checkPlayTime();
   
  if(simonTones.isPlayingTone == false) setButtonLightsOff();
  if (isSimonsTurn) simonSays();
  
  for(Button currentButton : buttons) {
    currentButton.display();
  }  
} 
 
void simonSays() {
  if(millis() >= timeOut) {
    int simonsWord = simonSentence[positionInSentence];
    simonTones.playTone(simonsWord, 420);
    buttons[simonsWord].isLightOn= true;
    
    if(positionInSentence < currentLengthOfTheSentence) {
      positionInSentence++;
    } else {
      isSimonsTurn = false;
      positionInSentence = 0;
    }
    
    timeOut = millis() + 420 + 55;
  } 
}
 
  
void keyPressed() {
  if(isSimonsTurn == false) {
    if ((key == '8')) {
      simonStartsNewGame();
      isGameStarted = false; 
    }
    
    else if ((key == '0')) { 
      buttons[0].isLightOn = true;

      if(simonSentence[positionInSentence] != 0) {
        simonTones.playTone(8, 420);
        isWrong = true;
      } else {
        simonTones.playTone(0, 420);
      }
    } 
    
    else if ((key == '1')) {
      buttons[1].isLightOn = true;
      
      if(simonSentence[positionInSentence] != 1) {
        simonTones.playTone(8, 420);
        isWrong = true;
      } else {
        simonTones.playTone(1, 420);
      }
    }
    
    else if ((key == '2')) {    
      buttons[2].isLightOn = true;
      
      if(simonSentence[positionInSentence] != 2) {
        simonTones.playTone(8, 420);
        isWrong = true;
      } else {
        simonTones.playTone(2, 420);
      }
    }
    
    else if ((key == '3')) {
      buttons[3].isLightOn = true;
      
      if(simonSentence[positionInSentence] != 3) {
        simonTones.playTone(8, 420);
        isWrong = true;
      } else {
        simonTones.playTone(3, 420);
      }
    }
    
    else if ((key == '4')) {
      buttons[4].isLightOn = true;
      
      if(simonSentence[positionInSentence] != 4) {
        simonTones.playTone(8, 420);
        isWrong = true;
      } else {
        simonTones.playTone(4, 420);
      }
    }
    
    else if ((key == '5')) {    
      buttons[5].isLightOn = true;
      
      if(simonSentence[positionInSentence] != 5) {
        simonTones.playTone(8, 420);
        isWrong = true;
      } else {
        simonTones.playTone(5, 420);
      }
    }
    
    else if ((key == '6')) {    
      buttons[6].isLightOn = true;
      
      if(simonSentence[positionInSentence] != 6) {
        simonTones.playTone(8, 420);
        isWrong = true;
      } else {
        simonTones.playTone(6, 420);
      }
    }
    
    else if ((key == '7')) {    
      buttons[7].isLightOn = true;
      
      if(simonSentence[positionInSentence] != 7) {
        simonTones.playTone(8, 420);
        isWrong = true;
      } else {
        simonTones.playTone(7, 420);
      }
    }
  }
}


void keyReleased() {  
  if(isSimonsTurn == false) {
    simonTones.stopTone();
    setButtonLightsOff();
      
    if(isWrong) {        
      fill(180);
      rect(300,300,300,300);
        
      textFont(fo);
      textAlign(CENTER);
      textSize(30);
      fill(255);
      text("Level" , 450, 395); 
        
      textFont(bo);
      textAlign(CENTER);
      textSize(80);
      fill(255);
      text(level , 450, 463);
        
      textFont(fo);
      textSize(20);
      textAlign(CENTER);
      text("Time: " + count + " secs", 450, 490);
        
      level=0;
      count=0;
      isGameStarted=true;
      isWrong = false;
    }
    
    if(positionInSentence < currentLengthOfTheSentence) {
      positionInSentence++;
    } else {
      if(currentLengthOfTheSentence == simonSentence.length-1) {
        fill(180);
        rect(300,300,300,300);
        image(fini, 300, 300, 300, 300);
            
        textFont(fo);
        textAlign(CENTER);
        textSize(30);
        fill(255);
        text("Level" , 450, 350); 
        
        textFont(bo);
        textAlign(CENTER);
        textSize(50);
        fill(255);
        text(level+1 , 450, 400);
        
        textSize(20);
        textAlign(CENTER);
        text("Time: " + count + " secs", 450, 500);
        
        fill(255);
        textSize(40);
        text("Congrats!", 450, 450);
        
        level=0;
        count=0;
        isGameStarted=true;
        isWrong = false;
      } else {
        currentLengthOfTheSentence++;
        level++;
        println(level);
        
        if(currentLengthOfTheSentence <6) talkTime = 420;
        else if(currentLengthOfTheSentence < 14) talkTime = 320;
        else talkTime = 220;
        
        positionInSentence = 0;
        timeOut = millis() + 1000;
        isSimonsTurn = true;
      }
    }
  }
}

void setButtonLightsOff() {
  for(Button currentButton : buttons) {
    currentButton.isLightOn = false;
  }  
}

void simonStartsNewGame() {
  background (180, 180, 180);
  image(img, 350, 420, 200, 60);
  
  makeNewSentence();
  timeOut = millis() + 1000;
  isSimonsTurn = true;
}

void makeNewSentence() {
  for(int i = 0; i<simonSentence.length; i++) {
    simonSentence[i] = int(random(0,8));
  }
  
  positionInSentence = 0;
  currentLengthOfTheSentence = 0;
  
  println(join(nf(simonSentence, 0), ", "));  
}
