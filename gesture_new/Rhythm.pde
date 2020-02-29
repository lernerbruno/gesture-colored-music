class Rhythm {
  SoundFile[] beats;
  int beatTrigger = 0;
  
  Rhythm() {
    
  }
  
  void playRhythm(DataProcessed dataProcessed) {
    int x = dataProcessed.rhythmCursor_X;
    int y = dataProcessed.rhythmCursor_Y;
    if(millis() > beatTrigger) {
      if (x > 2*kinect.width/3) {
        if (y >= kinect.height/2) {
          beats[0].play(1.0, 0.3);
          beatTrigger = millis() + int(1000*beats[0].duration());
        } else {
          beats[1].play(1.0, 0.3);
          beatTrigger = millis() + int(1000*beats[1].duration());
        }
      }  
    }
  }
  
  void make_setup(SoundFile sample1, SoundFile sample2) {
    beats = new SoundFile[2];
    beats[0] = sample1;
    beats[1] = sample2;
  }
}
