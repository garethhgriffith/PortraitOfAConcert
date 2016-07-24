public class LineGraph
{
  private ArrayList<Float> chartData, totalData;
  private float[] xAxis, yAxis, yAxisTotal;
  private color fillColor, lineColor;

  private float plotX1;
  //  private float plotY1 = height * 0.86805555555555555555555555555556;
  float plotY1;
  private float plotX2; 
  //  private float plotY2 = height * 0.97222222222222222222222222222222;
  float plotY2;

  public LineGraph(ArrayList<Float> totalData, ArrayList<Float> chartData, float plotX1, float plotX2, float plotY1, float plotY2, color fillColor, color lineColor)
  {
    this.totalData = totalData;
    this.chartData = chartData;
    this.fillColor = fillColor;
    this.lineColor = lineColor;
    this.plotX1 = plotX1;
    this.plotX2 = plotX2;
    this.plotY1 = plotY1;
    this.plotY2 = plotY2;
    loadAxisArrays();
  }


  //  public void drawDataPoints()
  //  {
  //    //    fill(100);
  //    rectMode(CORNERS);
  //    rect(plotX1, plotY1, plotX2, plotY2);
  //    fill(fillColor);
  //    beginShape();
  //
  //    //    stroke(lineColor);
  //    //    noFill();
  //    float chartMin = min(yAxis);
  //    float chartMax = max(yAxis);
  //    float xMin = min(xAxis);
  //    float xMax = max(xAxis);
  //
  //    for (int i = 0; i < chartData.size(); i++)
  //    {
  //      //      float value = chartData.get(i);
  //      float x = map(xAxis[i], xMin, xMax, plotX1, plotX2 );
  //      println(xAxis[i] + " : " + x);
  //      println(plotX2);
  //      float y = map(yAxis[i], chartMin, chartMax, plotY2, plotY1);
  //      strokeWeight(1);
  //      //      point(x, y);
  //      //      strokeWeight(.5);
  //      curveVertex(x, y);
  //    }
  //    vertex(plotX2, plotY2);
  //    vertex(plotX1, plotY2);
  //    endShape(CLOSE);
  //  }

  public void drawLineGraph(PGraphics lineGraph)
  {
    lineGraph.beginDraw();
    lineGraph.fill(fillColor);
    lineGraph.noStroke();
    lineGraph.beginShape();

    //draw the area graph
    float chartMin = min(yAxisTotal);
    float chartMax = max(yAxisTotal);
    float xMin = min(xAxis);
    float xMax = max(xAxis);
    for (int i = 0; i < chartData.size(); i++)
    {
      float x = map(xAxis[i], xMin, xMax, plotX1, plotX2);
      float y = map(yAxis[i], chartMin, chartMax, plotY2, plotY1);
      
      lineGraph.vertex(x, y);
      
    }    
    lineGraph.vertex(plotX2, plotY2);
    lineGraph.vertex(plotX1, plotY2);
    lineGraph.endShape(CLOSE);


    //draw the minute lines
    //    for (int i = 0; i < chartData.size(); i++)
    //    {
    //      float x = map(xAxis[i], xMin, xMax, plotX1, plotX2);
    //      float y = map(yAxis[i], chartMin, chartMax, plotY2, plotY1);
    //
    //      lineGraph.stroke(lineColor);
    //      lineGraph.line(x, y, x, plotY2);
    //    }

    lineGraph.endDraw();
    //    image(lineGraph, 0, 0);
  }



  public void loadAxisArrays()
  {
    xAxis = new float[chartData.size()];
    yAxis = new float[chartData.size()];
    yAxisTotal = new float[totalData.size()];

    //load the data of the current song into arrays
    float x = 0;  
    for (int i = 0; i < chartData.size(); i++)
    {
      xAxis[i] = x;
      yAxis[i] = chartData.get(i);
      x++;
    }

    //load all of the data so you can get the max and min values later
    for (int i = 0; i < totalData.size(); i++)
    {
      yAxisTotal[i] = totalData.get(i);
    }
  }

 
}
