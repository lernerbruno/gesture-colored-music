class DataProcessed {
  int rhythmCursor_X;
  int rhythmCursor_Y;
  int melodyCursor_X;
  int melodyCursor_Y;
  int chordCursor_X;
  int chordCursor_Y;
  int heightRecordBeat;
  int heightRecordChord;
  int heightRecordMelody;
  int[] pixelsColors;
  
  // h = kinect.height - 50;
  DataProcessed(int h, int pixelsLength) {
    this.rhythmCursor_X = 0;
    this.rhythmCursor_Y = 0;
    this.melodyCursor_X = 0;
    this.melodyCursor_Y = 0;
    this.chordCursor_X = 0;
    this.chordCursor_Y = 0;
    this.heightRecordBeat = h;
    this.heightRecordChord = h;
    this.heightRecordMelody = h;
    this.pixelsColors = new int[pixelsLength];
  }
  
  void resetParams(int h) {
    this.heightRecordBeat = h;
    this.heightRecordChord = h;
    this.heightRecordMelody = h;
  }
  
  void setRhythmCursor(int x, int y) {
    this.rhythmCursor_X = x;
    this.rhythmCursor_Y = y;
  }
  
  void setMelodyCursor(int x, int y) {
    this.melodyCursor_X = x;
    this.melodyCursor_Y = y;
  }
  
  void setChordCursor(int x, int y) {
    this.chordCursor_X = x;
    this.chordCursor_Y = y;
  }
  
  void setHeighestRhythm(int h) {
    this.heightRecordBeat = h;
  }
  
  void setHeighestMelody(int h) {
    this.heightRecordMelody = h;
  }
  
  void setHeighestChord(int h) {
    this.heightRecordChord = h;
  }
  
  void setPixelColorAt(int index, int pixelColor) {
    this.pixelsColors[index] = pixelColor; 
  }
  
  int getHeighestRhythm() {
    return this.heightRecordBeat;
  }
  
  int getHeighestChord() {
    return this.heightRecordChord; 
  }
  
  int getHeighestMelody() {
    return this.heightRecordMelody; 
  }
}
