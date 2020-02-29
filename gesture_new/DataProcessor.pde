class DataProcessor {
 Kinect kinect;
 DataProcessed dataProcessed;
 
 float minThreshold = 420;
 float maxThreshold = 750;

 DataProcessor(Kinect k) {
  kinect = k;
 }
 
 DataProcessed process() {
   dataProcessed = new DataProcessed(kinect.height - 50, kinect.width * kinect.height);
   int[] depth = kinect.getRawDepth();
   
   for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        int offset = x + y*kinect.width;
        int d = depth[offset];
        
        if(d > minThreshold && d < maxThreshold && y > 50) {
          float green = map(d, minThreshold, maxThreshold, 0, 255); 
          dataProcessed.setPixelColorAt(offset, color(0,255 - green,0));
        
          if (x > 2*kinect.width/3 && y < dataProcessed.getHeighestRhythm()) {
            dataProcessed.setHeighestRhythm(y);
            dataProcessed.setRhythmCursor(x, y);
          }     
          
          if (x > kinect.width/3 && x < 2*kinect.width/3 && y < dataProcessed.getHeighestChord()){
            dataProcessed.setHeighestChord(y);
            dataProcessed.setChordCursor(x, y);
          } 
          
          if (x > 0 && x < kinect.width/3 && y < dataProcessed.getHeighestMelody()){
            dataProcessed.setHeighestMelody(y);
            dataProcessed.setMelodyCursor(x, y);
          } 
        } else {
          dataProcessed.setPixelColorAt(offset, color(0,0,0));
        }
      }
    }
    return dataProcessed;
 }
}
