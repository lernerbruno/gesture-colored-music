//import org.openkinect.freenect.*;
//import org.openkinect.freenect2.*;
//import org.openkinect.processing.*;
//import org.openkinect.tests.*;
//import processing.sound.*;

//Kinect kinect;

//// Angle for rotation
//float a = 0;

//SinOsc[] sineWaves; // Array of sines
//float[] sineFreq; // Array of frequencies
//int numSines = 5; // Number of oscillators to use

//void setup() { //<>// //<>//
//  size(640, 480, P3D);
//  //kinect initialization
//  kinect = new Kinect(this); 
//  kinect.initDepth();
  
  
//  // sound waves initialization
//  sineWaves = new SinOsc[numSines]; // Initialize the oscillators
//  sineFreq = new float[numSines]; // Initialize array for Frequencies
  
//  for (int i = 0; i < numSines; i++) {
//    // Calculate the amplitude for each oscillator
//    float sineVolume = (1.0 / numSines) / (i + 1);
//    // Create the oscillators
//    sineWaves[i] = new SinOsc(this);
//    // Start Oscillators
//    sineWaves[i].play();
//    // Set the amplitudes for all oscillators
//    sineWaves[i].amp(sineVolume);
//  }
//}

//void draw() { //<>// //<>//
//  background(0); 

//  //PImage depthImage = kinect.getDepthImage();
//  //image(depthImage, 0, 0);
  
  
//    //Translate and rotate
//  pushMatrix();
//  translate(width/2, height/2, -2250);
//  //rotateY(a);

//  int[] depth = kinect.getRawDepth();
//  int skip = 16;
//  stroke(255);
//  strokeWeight(2);
//  beginShape(POINTS);
//  for ( int x = 0; x < kinect.width; x += skip ) {
//    for ( int y = 0; y < kinect.height; y += skip ) {
//      int offset = x + y*kinect.width;
//      PVector point = depthToPointCloudPos(x, y, depth[offset]);
//      if (point.z < 500){
//        // map y pos to [0, 1]
        //float yoffset = map(point.y, 0, kinect.height/2, 0, 1);
//        //Map yoffset logarithmically to 150 - 1150 to create a base frequency range
//        float frequency = 1000*yoffset+150;
//        //Use x pos mapped from -0.5 to 0.5 as a detune argument
//        float detune = map(point.x, 0, kinect.width/2, -0.5, 0.5);
  
    
//        for (int i = 0; i < numSines; i++) { 
//          sineFreq[i] = frequency * (i + 1 * detune);
//          // Set the frequencies for all oscillators
//          sineWaves[i].freq(sineFreq[i]);
//        }
//      } //<>// //<>//
//      vertex(point.x, point.y, point.z);
//    }
//  }
  
//  endShape();

//  popMatrix();

//  fill(255);
//  text(frameRate, 50, 50);

//  // Rotate
  //a += 0.0015;
//}

//PVector depthToPointCloudPos(int x, int y, float depthValue) {
//  PVector point = new PVector();

//  point.z = (depthValue);
//  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx; 
//  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;

//  return point;
//}
