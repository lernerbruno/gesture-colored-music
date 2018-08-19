//import org.openkinect.freenect.*;
//import org.openkinect.freenect2.*;
//import org.openkinect.processing.*;
//import org.openkinect.tests.*;
//import processing.sound.*;

//Kinect kinect;
//// Oscillator and envelope 
//TriOsc triOsc;
//Env env; 

//// Times and levels for the ASR envelope
//float attackTime = 0.001;
//float sustainTime = 0.004;
//float sustainLevel = 0.2;
//float releaseTime = 0.2;
//float a = 0;

//// This is an harmonic minor scale in MIDI notes.
//int[] midiSequence = { 
//  52,54,55,57,58,60,61,63,64,66,67,69,70,72,73,75,76,78
//}; 
////int note = 60;
//int note = 0;
//char[] pattern = {'T','T','S','T','T','T','S'};

//// Set the duration between the notes
//// medir a velocidade
//int duration = 200;
//// Set the note trigger
//int trigger = 0; 

//void settings() {
//  size(640, 480, P3D);
//}

//void setup() {
//  //kinect initialization
//  kinect = new Kinect(this); 
//  kinect.initDepth();
  
  //// Create triangle wave and envelope 
  //triOsc = new TriOsc(this);
  //env  = new Env(this);
//}

//void draw() {
//  background(0); 

//  //Translate and rotate
//  pushMatrix();
//  translate(width/2, height/2, -2250);
//  rotateY(a);
//  int[] depth = kinect.getRawDepth();
//  int skip = 8;
//  stroke(255);
//  strokeWeight(2);
//  beginShape(POINTS);
//  for ( int x = 0; x < kinect.width; x += skip ) {
//    for ( int y = 0; y < kinect.height; y += skip ) {
//      int offset = x + y*kinect.width;
//      PVector point = depthToPointCloudPos(x, y, depth[offset]);
//      float xoffset = map(x, 0, kinect.width/2, 0, 18);
//      float yoffset = map(x, 0, kinect.height/2, 0, 10);
//      //if (yoffset > 0 && yoffset < 1){
//      //   duration = 100; 
//      //}
//      //if (yoffset >= 1 && yoffset < 2){
//      //   duration = 200; 
//      //}
//      //if (yoffset >= 2 && yoffset < 3){
//      //   duration = 100; 
//      //}

//      if (xoffset > -1*pattern.length && xoffset < pattern.length) {
//        if(xoffset < 0){
//         int index = pattern.length + int(xoffset);
//         if(pattern[index] == 'T') {
//             note--;
//         } else {
//             note -= 2;
//         }
//        } else {
//           int index = int(xoffset);
//           if(pattern[index] == 'T') {
//             note++;
//           } else {
//             note += 2;
//           }
//        }
//      }
//      note = int(xoffset);
//      int flanger = int(yoffset);
//      if ((millis() > trigger) && note > 0 && note < midiSequence.length && point.z < 500) {

        // midiToFreq transforms the MIDI value into a frequency in Hz which we use 
        //to control the triangle oscillator with an amplitute of 0.8
        //triOsc.play(midiToFreq(midiSequence[int(yoffset)]), 0.8);
        //triOsc.play(midiToFreq(midiSequence[note], 0), 0.8);
        //triOsc.play(midiToFreq(midiSequence[note], flanger), 0.8);
        //triOsc.play(midiToFreq(note), 0.8);
    
        // The envelope gets triggered with the oscillator as input and the times and 
        // levels we defined earlier
        //env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
    
        //// Create the new trigger according to predefined durations and speed
        //trigger = millis() + duration;
    
        // Advance by one note in the midiSequence;
       // note++; 
       //if( note == 17) {
       //  note = 0; 
       //}

//      }
//      vertex(point.x, point.y, point.z);
//    }
//  }
  
//  endShape();

//  popMatrix();

//  fill(255);
//  text(frameRate, 50, 50);
//  a += 0.0015;
//}

//PVector depthToPointCloudPos(int x, int y, float depthValue) {
//  PVector point = new PVector();

//  point.z = (depthValue);
//  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx; 
//  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;

//  return point;
//}

//// This function calculates the respective frequency of a MIDI note
//float midiToFreq(int note, int flanger) {
//  return (pow(2, ((note-69)/12.0)))*440;
//}
