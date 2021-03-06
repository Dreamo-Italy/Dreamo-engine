import ddf.minim.*;
import ddf.minim.ugens.*;

class AudioManager

{
 //********* PRIVATE MEMBERS ***********
 private Minim minim;
 private AudioInput in=null; 
 private boolean initialized = false;
  
 //********* CONTRUCTORS ***********
 public AudioManager(){}
 
 public AudioManager(Object fileSystemHandler)
 {
   minim = new Minim(fileSystemHandler);
   in = minim.getLineIn(Minim.STEREO,1024,global_audioRate); //stereo stream, 1024 samples of buffer size
   if(in!=null) {initialized=true; mute();}
   else {println("AUDIO INPUT NOT AVAILABLE");} 
 }

 //********* PUBLIC METHODS ***********
 public void addListener(AudioListener l)
 { 
   if (isInitialized()) { in.addListener(l); }
   else{println("AUDIO FEATURE OBJECT NOT INITIALIZED");} 
 }
 
 public void enableMonitoring()
 {
    if (isInitialized()) { in.enableMonitoring(); }
    else{ println("AUDIO FEATURE OBJECT NOT INITIALIZED"); }   
 }
 
 public void disableMonitoring()
 {
    if (isInitialized()) { in.disableMonitoring(); }
    else { println("AUDIO FEATURE OBJECT NOT INITIALIZED"); }   
 }
 
 public boolean isMonitoring()
 {
   return in.isMonitoring();
 }
 
  public void mute()
 {
   in.mute();
 }
 
 public void unmute()
 {
   in.unmute();
 }
 
 public boolean isMuted()
 {
   return in.isMuted();
 }
 
 public void stop()
 {
  in.close();
  minim.stop();
 }
  
 //********* GETTERS ***********
 public float[] getSamples() { return in.mix.toArray(); }
 
 public int getBufferSize()
 {
   if(isInitialized()){return in.bufferSize();}
   else return 0;
 }
  
 public float getSampleRate()
 {
   if(isInitialized()){return in.sampleRate();}
   else return 0;
 }
 
 public boolean isInitialized() { return initialized; }
 
 public void setMasterGain(float value) 
 {
   in.setGain(value);
 }
 
 public float getMasterGain() 
 {
   return in.getGain();
 }
 
 // public void setMasterVolume(float value) 
 //{
 //  println("Old gain "+in.getVolume());
 //  in.setVolume(value);
 //  println("New gain "+in.getVolume());
 //}
 
 //public float getMasterVolume() 
 //{
 //  //return in.getVolume();
 //  return getMasterGain();
 //} 
}
