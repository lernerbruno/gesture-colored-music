import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import processing.sound.*;

Kinect kinect;
PImage img;

float minThreshold = 420;
float maxThreshold = 750;

void settings() {
  size(640, 480);
}

void setup() {
  //kinect initialization
  kinect = new Kinect(this); 
  kinect.initDepth();
  
  img = createImage(kinect.width, kinect.height, RGB);
  
}

void draw() {
  background(0); 
  img.loadPixels();
  //minThreshold = map(mouseX, 0, width, 0, 45000);
  //maxThreshold = map(mouseY, 0, height, 0, 45000);
  int[] depth = kinect.getRawDepth();
  int closeRecord = 4500;
  int heightRecord = kinect.height ;
  int rX = 0;
  int rY = 0;
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  for ( int x = 0; x < kinect.width; x++ ) {
    for ( int y = 0; y < kinect.height; y++ ) {
      int offset = x + y*kinect.width;
      int d = depth[offset];
      
      if(d > minThreshold && d < maxThreshold && x> 50 && y > 50) {
        float green = map(d, minThreshold, maxThreshold, 0, 255); 
        img.pixels[offset] = color(0,255 - green,0);
      
        sumX += x;
        sumY += y;
        totalPixels++;
        
        //if ( d < closeRecord ) {
        // closeRecord = d; 
        // rX = x;
        // rY = y;
        //}
        
        
        if ( y < heightRecord) {
          heightRecord = y; 
          rX = x;
          rY = y;
        }
      } else {
        img.pixels[offset] = color(0,0,0);
      }
    }
  }
  
  img.updatePixels();
  image(img, 0, 0);
  
  float avgX = sumX / totalPixels;
  float avgY = sumY / totalPixels;
  
  fill(150, 0, 255);
  ellipse(avgX, avgY, 64, 64);
  fill(255);
  ellipse(rX, rY, 32, 32);
  
  //fill(255);
  //textSize(32);
  //text(minThreshold + " " + maxThreshold, 10, 64);
}
