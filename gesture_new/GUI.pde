class GUI {
  PImage playingFrame;
  Kinect kinect;
  
  GUI (Kinect k) {
    kinect = k;  
  }
  PImage getPlayingFrame() {
    return this.playingFrame;
  }
  
  void setPlayingFrame(int[] pixelsColors) {
    this.playingFrame.pixels = pixelsColors;
    this.playingFrame.updatePixels();
    image(this.playingFrame, 0, 0);
  }
  
  void renderPlayingFrame() {
    this.playingFrame.loadPixels();
  }
  
  void drawInterface() {
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
  
  void drawCursors(DataProcessed dataProcessed) {
    // Showing highest pixel on beat part of Screen
    fill(255);
    if (dataProcessed.rhythmCursor_X != 0 && dataProcessed.rhythmCursor_Y != 0){
      ellipse(dataProcessed.rhythmCursor_X, dataProcessed.rhythmCursor_Y, 32, 32);
      stroke(255);  
    }
    
    // Showing highest pixel on beat part of Screen
    if(dataProcessed.chordCursor_X != 0 && dataProcessed.chordCursor_Y != 0){
      ellipse(dataProcessed.chordCursor_X, dataProcessed.chordCursor_Y, 32, 32);
      stroke(255);
    }
  
    // Showing highest pixel on beat part of Screen
    if(dataProcessed.melodyCursor_X != 0 && dataProcessed.melodyCursor_Y != 0){
      ellipse(dataProcessed.melodyCursor_X, dataProcessed.melodyCursor_Y, 32, 32);
      stroke(255);
    } 
  }
  
  void make_setup() {
    this.playingFrame = createImage(kinect.width, kinect.height, RGB); 
  }
   
}
