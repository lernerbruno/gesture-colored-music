import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import processing.sound.*;

Kinect kinect;
SoundFile[] beat;
SoundFile chord;
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
  
  beat = new SoundFile[2];
  
  beat[0] = new SoundFile(this, "/Users/brunolerner/workspace/gesture-colored-music/firstPlay/samples/096_squeaky_hiphop.aif");
  beat[1] = new SoundFile(this, "/Users/brunolerner/workspace/gesture-colored-music/firstPlay/samples/096_round-hiphop.aif");

  chord = new SoundFile(this, "/Users/brunolerner/workspace/gesture-colored-music/firstPlay/samples/092_stuttery-clicky-epiano-chord.aif");
  img = createImage(kinect.width, kinect.height, RGB);
  
}

void draw() {
  background(0); 
  img.loadPixels();
  //minThreshold = map(mouseX, 0, width, 0, 45000);
  //maxThreshold = map(mouseY, 0, height, 0, 45000);
  int[] depth = kinect.getRawDepth();
  //int closeRecord = 4500;
  int heightRecord = kinect.height - 50;
  boolean playChord = false;
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  for ( int x = 0; x < kinect.width; x++ ) {
    for ( int y = 0; y < kinect.height; y++ ) {
      int offset = x + y*kinect.width;
      int d = depth[offset];
      
      if(d > minThreshold && d < maxThreshold && y > 50) {
        float green = map(d, minThreshold, maxThreshold, 0, 255); 
        img.pixels[offset] = color(0,255 - green,0);
      
        //sumX += x;
        //sumY += y;
        //totalPixels++;
        //if ( d < closeRecord ) {
        // closeRecord = d; 
        // rX = x;
        // rY = y;
        //}
        if ( x > 2*kinect.width/3 && y < heightRecord) {
          heightRecord = y; 
          beatX = x;
          beatX = y;
        }     
        
        if (x > kinect.width/3 && x < 2*kinect.width/3){
          playChord = true;
        } else {
          playChord = false;
        }
        
        
      } else {
        img.pixels[offset] = color(0,0,0);
      }
    }
  }
  
  img.updatePixels();
  image(img, 0, 0);
  
  // To calculate de average Point
  
  //float avgX = sumX / totalPixelZs;
  //float avgY = sumY / totalPixels;
  //fill(150, 0, 255);
  //ellipse(avgX, avgY, 64, 64);
  fill(255);
  
  // Showing highest pixel on Screen
  ellipse(beatX, beatX, 32, 32);
  stroke(255);
  
  if( beatX > 2*kinect.width/3 && millis() > beatTrigger && beatX >= kinect.height/2){
    beat[0].play(1.0, 1.0);
    beatTrigger = millis() + int(1000*beat[0].duration());
  }
  
  if( beatX > 2*kinect.width/3 && millis() > beatTrigger && beatX < kinect.height/2){
    beat[1].play(1.0, 1.0);
    beatTrigger = millis() + int(1000*beat[1].duration());
  }
  
  if (playChord && millis() > chordTrigger){
    chord.play(96.0/92.0, 1.0);
    chordTrigger = millis() + int(1000*beat[1].duration());
  }
  // Draw Interface
  // Verticals
  line(kinect.width/3, kinect.height, kinect.width/3, 0);
  line(2*kinect.width/3, kinect.height, 2*kinect.width/3, 0);
  
  // Horizontal
  line(2*kinect.width/3, kinect.height/2, kinect.width, kinect.height/2);
  line(kinect.width/3, kinect.height/3, 2*kinect.width/3, kinect.height/3);
  line(kinect.width/3, 2*kinect.height/3, 2*kinect.width/3, 2*kinect.height/3);

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
