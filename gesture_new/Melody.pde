

class Melody {
  int melodyTrigger = 0;
  
  float attackTime = 0.001;
  float sustainTime = 0.004;
  float sustainLevel = 0.2;
  float releaseTime = 0.2;
  int duration = 200;
  
  //Scales
  //52 is E
  // Put these arrays into an object
  int[] superLocrian = { 
    55,55,57,59,60,62,63,65,66,68,69,71,72,74,75
  }; 
  
  int[] harmonicMinor = {
    50,52,53,55,57,58,60,62,64,65,67,69,70,72,74
  };
  int[] majorScale = {
    48,50,52,53,55,57,59,60,62,64,65,67,69,71,72
  };
  int[] scale = {
  48,50,52,53,55,57,59,60,62,64,65,67,69,71,72
  };
  int kinectHeight;
  // Oscillator and envelope 
  TriOsc triOsc;
  Env env; 

  Melody(TriOsc to, Env e, int k) {
    triOsc = to;
    env = e;
    kinectHeight = k;
  }
  void playMelody(int[] scale, int pointY) {
     if (millis() > this.melodyTrigger){
        float mappedNote = map(pointY, 0, this.kinectHeight, 0, 18);
        int note = int(mappedNote);
        println(note);
        if(note > 0 && note < scale.length){
          this.triOsc.play(this.midiToFreq(scale[scale.length - 1 - note]), 0.8);
          this.env.play(this.triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
          
          // Create the new trigger according to predefined durations and speed
          this.melodyTrigger = millis() + duration;  
          println(this.melodyTrigger);
          println(millis());
        }
      }
  }
  
  // This function calculates the respective frequency of a MIDI note
  float midiToFreq(int note) { 
    return (pow(2, ((note-69)/12.0)))*440;
  }
  
  void make_setup() {
    this.triOsc.play(midiToFreq(52), 0.8);
    this.env.play(this.triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
  }
}
