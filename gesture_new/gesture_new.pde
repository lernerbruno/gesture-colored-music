import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import processing.sound.*;

Kinect kinect;
Harmony harmony;
Melody melody;
Rhythm rhythm;
GUI gui;  
DataProcessor dataProcessor;
MusicGenerator musicGenerator;
DataProcessed dataProcessed;

void settings() {
  size(640, 480);
}

void setup() {
  //kinect initialization
  kinect = new Kinect(this); 
  kinect.initDepth();
  
  // Melody
  TriOsc triOsc = new TriOsc(this);;
  Env env = new Env(this);
  melody = new Melody(triOsc, env, kinect.height);
  melody.make_setup();
  
  // Rhythm
  SoundFile sample1 = new SoundFile(this, "../samples/096_round-hiphop.aif");
  SoundFile sample2 = new SoundFile(this, "../samples/096_round-hiphop.aif");
  rhythm = new Rhythm();
  rhythm.make_setup(sample1, sample2);
  
  // Harmony
  SoundFile chord1 = new SoundFile(this, "../samples/2m7.aif");
  SoundFile chord2 = new SoundFile(this, "../samples/5M7.aif");
  SoundFile chord3 = new SoundFile(this, "../samples/1M7.aif");
  harmony = new Harmony(sample1.duration());
  harmony.make_setup(chord1, chord2, chord3);
  
  // User interface
  gui = new GUI(kinect);
  gui.make_setup();
   
  // Engine
  dataProcessor = new DataProcessor(kinect);
  musicGenerator = new MusicGenerator(harmony, melody, rhythm);
}

void draw() {
  background(0); 
  
  gui.renderPlayingFrame(); 
  DataProcessed dataProcessed = dataProcessor.process(); 
  gui.setPlayingFrame(dataProcessed.pixelsColors);
  gui.drawCursors(dataProcessed);
  
  musicGenerator.generate(dataProcessed);
  
  gui.drawInterface();
}
