class Harmony {
  SoundFile[] chords;
  int chordTrigger = 0;
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
  float beatDuration;
  
  Harmony (float b) {
    beatDuration = b;
  }
  
  int[] playChord(DataProcessed dataProcessed) {
    int x = dataProcessed.chordCursor_X;
    int y = dataProcessed.chordCursor_Y;
    int[] scale = this.scale;
    if (millis() > chordTrigger) {
      if (y > 0 && y < kinect.height/3){
        // Play II m7 chord
        chords[0].play(1.0, 1.0);
        chordTrigger = millis() + int(1000 * beatDuration/4);
        scale = harmonicMinor;
        return scale;
      } else if (y >= kinect.height/3 && y < 2*kinect.height/3) {
        // Play V 7 chord
        chords[1].play(1.0, 1.0);
        chordTrigger = millis() + int(1000 * beatDuration/4);
        scale = superLocrian;
        return scale;
      } else if (y >= 2*kinect.height/3 && y < kinect.height) {
        // Play I maj7 chord
        chords[2].play(1.0, 1.0);
        chordTrigger = millis() + int(1000 * beatDuration/4);
        scale = majorScale;
        return scale;
      }
    }
    
    return scale;
  }
  
  void make_setup(SoundFile chord1, SoundFile chord2, SoundFile chord3) {
    chords = new SoundFile[3];
    chords[0] = chord1;
    chords[1] = chord2;
    chords[2] = chord3; 
  }
}
