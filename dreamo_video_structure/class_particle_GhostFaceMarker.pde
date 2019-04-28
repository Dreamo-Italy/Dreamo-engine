class GhostFaceMarker extends Particle {
  // color
  int indexShifting;
  boolean nextColor;
  //fading
  float opacity;
  final int INIT_OPACITY = 250;
  final int FINAL_OPACITY = 20;
  final int FADE_DURATION = 60; // ~= 2 seconds
  private boolean isFading;
  private int endFading;

 void init() {
   opacity = 255;
   indexShifting = 0;
   nextColor = false;
   isFading = false;
   endFading = 0;
 }

 void update() {
  //**** PARAMETERS FOR DIRECT INFLUENCE
  setParameter(0, audio_decisor.getInstantFeatures()[0]); //RMS istantaneo

  //**** COLORS
  if (nextColor && indexShifting < getPalette().COLOR_NUM) {indexShifting++; nextColor = false;}
  if (indexShifting >= getPalette().COLOR_NUM) indexShifting = 0;
  // **** OPACITY
  //println("RMS: " + getParameter(0));

  }


 void trace() {
  noStroke();
  fill(getPalette().getColor(indexShifting), opacity);

  // occhio left
  beginShape();
  vertex(694, 393);
  vertex(703, 393);
  vertex(703, 390);
  vertex(691, 390);
  endShape();
  // orecchio DX
  beginShape();
  vertex(495, 625);
  vertex(505, 626);
  vertex(511, 415);
  vertex(504, 414);
  endShape();
  // occhio right
  beginShape();
  vertex(571, 392);
  vertex(580, 393);
  vertex(580, 390);
  vertex(571, 389);
  endShape();
  // orecchio left
  beginShape();
  vertex(779, 628);
  vertex(792, 628);
  vertex(766, 419);
  vertex(759, 417);
  endShape();
 }

 public void fadeIn() {
   // if not already fading
   if (!isFading) {
     // set ending frames
     endFading = frameCount + FADE_DURATION;
     isFading = true; //now scene is fading
   } else {
     //continue fading
     if (frameCount <= endFading && opacity < INIT_OPACITY) {
       // fading not finished
       // increment opacity
       println("fading in");
        opacity += (float)(INIT_OPACITY - FINAL_OPACITY) / FADE_DURATION;
      } else {
       // fading finished
       isFading = false;
     }
   }
 }

 public void fadeOut() {
   // if the scene is not already fading
   if (!isFading) {
     //setending frames
     endFading = frameCount + FADE_DURATION;
     isFading = true; //now scene is fading
   } else {
     //continue fading
     if (frameCount <= endFading && opacity > FINAL_OPACITY ) {
       // fading not finished
       // increment opacity
       println("fading out");
       opacity -= (float)(INIT_OPACITY - FINAL_OPACITY) / FADE_DURATION;
     } else {
       // fading finished
       isFading = false;
     }
   }
 }
}