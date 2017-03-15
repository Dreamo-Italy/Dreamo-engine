 import grafica.*;
 
 class DebugPlot
{
 //************ CONSTANTS **************
 
  final int plotNumber = 4;
  
 //********* PUBLIC MEMBERS ***********


  //********* PRIVATE MEMBERS ***********
  private int nPoints = 300;
  private int nBars = 512;
  private GPointsArray [] points;
  private GPointsArray surfacePoints;
  private GPlot [] plots;
  
  private color bgColor,red,green,white;
  
  //********* CONSTRUCTOR ***********
  
  public DebugPlot(PApplet p)
  { 
    bgColor = color(1,1,1,10);
    white = color(0,0,100,50);
    red = color(0,60,60,50);
    green = color(50,50,50,50);
   
   // Prepare the points for the plots 
   points = new GPointsArray[plotNumber+1]; 
   // Create new plots 
   plots = new GPlot[plotNumber];
   
   surfacePoints = new GPointsArray(nPoints);

   for(int i=0; i<plotNumber;i++)
   { 
     
     if(i!=4) points[i] = new GPointsArray(nPoints);
     //else points[i] = new GPointsArray(nBars); //bars for histogram
   
     plots[i] = new GPlot(p);
     plots[i].setPos(10, height-(i*220)-30);
  
     // Set the plots title and the axis labels
     plots[i].setMar(new float[] {50, 20, 50, 0});
     plots[i].setOuterDim(281,91);
     plots[i].setDim(280,160);
     //plots[i].getXAxis().setAxisLabelText("x ");
     //plots[i].getYAxis().setAxisLabelText("y ");
   
     // Set the colors
     //plots[i].setFixedYLim(true);
     //plots[i].setYLim(0, 1);
     //plots[i].getYAxis().setAxisLabelText("y axis");
     plots[i].setPointSize(1);
     plots[i].setBoxBgColor(bgColor);
     plots[i].setBgColor(bgColor);
     plots[i].setLabelBgColor(red);
     plots[i].setBoxLineColor(bgColor);
     plots[i].setLineColor(red);
     plots[i].setPointColor(red);
     plots[i].getXAxis().setLineColor(green);
     plots[i].getYAxis().setLineColor(green);
     plots[i].setAllFontProperties("",white,11);

    if(i!=4)
    {
     for(int j=0; j<nPoints;j++)   
      points[i].add(frameCount, 0);
    }
    else{
      for(int j=0; j<nBars;j++)   
      points[i].add(j, j/nBars);
    }
    
    plots[i].setPoints(points[i]);
     
   }
    
      
   plots[0].setTitleText("Gsr");
   plots[1].setTitleText("Ecg");
   plots[2].setTitleText("RMS");
   plots[3].setTitleText("Spectral Centroid");
   //plots[4].setTitleText("Frequency spectrum");
   //plots[4].startHistograms(GPlot.VERTICAL);

   
   for(int j=0; j<nPoints;j++)
     surfacePoints.add(frameCount, 0);
     
   // Change the second layer options - RMS
   plots[2].addLayer("AvgRMS", surfacePoints);
   plots[2].getLayer("AvgRMS").setPoints( surfacePoints );
   plots[2].getLayer("AvgRMS").setPointSize(1);
   plots[2].getLayer("AvgRMS").setPointColor( green ); 
   plots[2].getLayer("AvgRMS").setLineColor(green);
   
      // Change the second layer options - RMS
   
   plots[3].addLayer("AvgCentroid", surfacePoints);
   plots[3].getLayer("AvgCentroid").setPoints( surfacePoints );
   plots[3].getLayer("AvgCentroid").setPointSize(1);
   plots[3].getLayer("AvgCentroid").setPointColor( green ); 
   plots[3].getLayer("AvgCentroid").setLineColor(white);
  
  }
  
  public void update()
  {
    addNewPoints();  
    removeOldestPoints();
    drawPlots();
  }
  
  public void addNewPoints()
  {
    plots[0].addPoint( frameCount, global_gsr.getAbsolute());
    plots[1].addPoint( frameCount, global_ecg.getValue());
    
    plots[2].addPoint( frameCount, global_dyn.getRMS());    
    plots[2].getLayer("AvgRMS").addPoint( frameCount, global_dyn.getAvgRMS());
    
    //debug
    //plots[4].addPoint( frameCount, global_dyn.getRMS() );
    plots[3].addPoint( frameCount, global_timbre.getCentroidHz());
    plots[3].getLayer("AvgCentroid").addPoint(frameCount, global_timbre.getCentroidAvg());


  }
  
  public void removeOldestPoints()
  {
    for(int i=0; i<plotNumber;i++)
    {             
      plots[i].removePoint(0);
    }    
    plots[2].getLayer("AvgRMS").removePoint(0);
    plots[3].getLayer("AvgCentroid").removePoint(0);
    
  }
  
  public void drawPlots()
  {
     for(int i=0; i<plotNumber;i++)
    {        
      if(i!=4) plots[i].defaultDraw();
    }
    plots[2].getLayer("AvgRMS").drawPoints();
    plots[3].getLayer("AvgCentroid").drawPoints();
    
    /*
    plots[4].beginDraw();
    plots[4].drawBackground();
    plots[4].drawXAxis();
    plots[4].drawYAxis();
    plots[4].drawTitle();
    plots[4].drawHistograms();
    plots[4].endDraw();
    */
  }


}  