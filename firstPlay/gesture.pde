import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import processing.sound.*;

Kinect kinect;
SoundFile[] beats;
SoundFile[] chords;
PImage img;

float minThreshold = 420;
float maxThreshold = 750;
// The trigger is an integer number in milliseconds so we 
// can schedule new events in the draw loop
int beatTrigger=0;
int chordTrigger=0;
int beatX = 0;
int beatY = 0;

void settings() {
  size(640, 480);
}

void setup() {
  //kinect initialization
  kinect = new Kinect(this); 
  kinect.initDepth();
  
  beats = new SoundFile[2];
  chords = new SoundFile[1];
  
  beats[0] = new SoundFile(this, "/Users/brunolerner/workspace/gesture-colored-music/firstPlay/samples/096_squeaky_hiphop.aif");
  beats[1] = new SoundFile(this, "/Users/brunolerner/workspace/gesture-colored-music/firstPlay/samples/096_round-hiphop.aif");

  chords[0] = new SoundFile(this, "/Users/brunolerner/workspace/gesture-colored-music/firstPlay/samples/092_stuttery-clicky-epiano-chord.aif");
  
  img = createImage(kinect.width, kinect.height, RGB);
}

void draw() {
  background(0); 
  img.loadPixels();
  //minThreshold = map(mouseX, 0, width, 0, 45000);
  //maxThreshold = map(mouseY, 0, height, 0, 45000);
  int[] depth = kinect.getRawDepth();
  int heightRecordBeat = kinect.height - 50;
  int heightRecordChord = kinect.height - 50;
  int chordX = 0;
  int chordY = 0;
  
  for ( int x = 0; x < kinect.width; x++ ) {
    for ( int y = 0; y < kinect.height; y++ ) {
      int offset = x + y*kinect.width;
      int d = depth[offset];
      
      if(d > minThreshold && d < maxThreshold && y > 50) {
        float green = map(d, minThreshold, maxThreshold, 0, 255); 
        img.pixels[offset] = color(0,255 - green,0);
      
        if ( x > 2*kinect.width/3 && y < heightRecordBeat) {
          heightRecordBeat = y; 
          beatX = x;
          beatY = y;
        }     
        
        if (x > kinect.width/3 && x < 2*kinect.width/3 && y < heightRecordChord){
          heightRecordChord = y;
          chordX = x;
          chordY = y;
        } 
        
        
      } else {
        img.pixels[offset] = color(0,0,0);
      }
    }
  }
  
  img.updatePixels();
  image(img, 0, 0);
  
  
  // Showing highest pixel on beat part of Screen
    fill(255);

  if (beatX != 0 && beatY != 0){
    ellipse(beatX, beatY, 32, 32);
    stroke(255);  
  }
  

  // Showing highest pixel on beat part of Screen
  if(chordX != 0 && chordY != 0){
    ellipse(chordX, chordY, 32, 32);
    stroke(255);
  }

  
  
  if( getChordAndBeatByPosition(beatX, beatY) == 10 && millis() > beatTrigger){
    beats[0].play(1.0, 1.0);
    beatTrigger = millis() + int(1000*beats[0].duration());
  }
  
  if( getChordAndBeatByPosition(beatX, beatY) == 20 && millis() > beatTrigger){
    beats[1].play(1.0, 1.0);
    beatTrigger = millis() + int(1000*beats[1].duration());
  }
  
  if ( getChordAndBeatByPosition(chordX,chordY) == 2 && millis() > chordTrigger){
    // Play II m7 chord
    chords[0].play(96.0/92.0, 1.0);
    chordTrigger = millis() + int(1000*chords[0].duration());
  } else if (getChordAndBeatByPosition(chordX,chordY) == 5 && millis() > chordTrigger) {
    // Play V 7 chord
    chords[0].play(96.0/92.0, 1.0);
    chordTrigger = millis() + int(1000*chords[0].duration());
  } else if (getChordAndBeatByPosition(chordX,chordY) == 1 && millis() > chordTrigger) {
  // Play I maj7 chord
    chords[0].play(96.0/92.0, 1.0);
    chordTrigger = millis() + int(1000*chords[0].duration());
  }
  
  // Draw Interface
  // Verticals
  line(kinect.width/3, kinect.height, kinect.width/3, 0);
  line(2*kinect.width/3, kinect.height, 2*kinect.width/3, 0);
  
  // Horizontal
  line(2*kinect.width/3, kinect.height/2, kinect.width, kinect.height/2);
  line(kinect.width/3, kinect.height/3, 2*kinect.width/3, kinect.height/3);
  line(kinect.width/3, 2*kinect.height/3, 2*kinect.width/3, 2*kinect.height/3);

  // Texts
  textSize(20);
  text("Melody", kinect.width/10, 50);
  text("Harmony", kinect.width - 375, 50);
  text("Rhythm", kinect.width - 150, 50);
  textSize(32);
  text("A", kinect.width - 120, 150);
  text("B", kinect.width - 120, 375);
  text("II m7", kinect.width - 360, 125);
  text("V 7", kinect.width - 360, 250);
  text("I maj7", kinect.width - 360, 400);


  // To debug minMax Threshold and find best ratio
  //fill(255);
  //textSize(32);
  //text(minThreshold + " " + maxThreshold, 10, 64);
}

int getChordAndBeatByPosition(int x, int y) {
  if(x > kinect.width/3 && x < 2*kinect.width/3) {
    if (y >= 0 && y < kinect.height/3){
      return 2;
    } else if (y >= kinect.height/3 && y < 2*kinect.height/3) {
      return 5;
    } else if (y >= 2*kinect.height/3 && y < kinect.height) {
      return 1;
    }
  } else if (x > 2*kinect.width/3) {
    if (y >= kinect.height/2) {
      return 10;
    } else {
      return 20;
    }
  }
  return 0;
}
