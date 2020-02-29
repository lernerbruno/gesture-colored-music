class MusicGenerator {
  Harmony harmony;
  Melody melody;
  Rhythm rhythm;
  
  MusicGenerator(Harmony h, Melody m, Rhythm r) {
    harmony = h;
    melody = m;
    rhythm = r;
  }
  
  void generate(DataProcessed dataProcessed) {
    this.rhythm.playRhythm(dataProcessed);
    int[] scale = this.harmony.playChord(dataProcessed);
    this.melody.playMelody(scale, dataProcessed.melodyCursor_Y);
  }
}
