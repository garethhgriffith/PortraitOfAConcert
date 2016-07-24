public class CircleLineGraph
{
  private float x, y;
  private float angle;

  private ArrayList<Float> dataList;
  private float circleSize;
  private float circumference;
  private float rotation;
  private color lineColor;
  private color fillColor;
  private float pointSize;
  private float lineWeight;
  private int innerCirc;
  private int modVal;

  private PVector currentLoc;
  private PVector originLoc;  
  private PVector oldLoc;
  private PVector previousLoc;
  private PGraphics buffer;
  private PShape graph;
  private PImage img;

  private float a;


  public CircleLineGraph(ArrayList dataList, float circleSize, float circumference, float rotation, color fillColor, color lineColor, float pointSize, float lineWeight, int innerCirc, int modVal)
  {
    this.dataList = dataList;
    this.circleSize = circleSize;
    this.circumference = circumference;
    this.rotation = rotation;
    this.lineColor = lineColor;
    this.fillColor = fillColor;
    this.pointSize = pointSize;
    this.lineWeight = lineWeight;
    this.innerCirc = innerCirc;
    this.modVal = modVal;
    currentLoc = new PVector(0, 0);
    buffer = createGraphics(width, height, JAVA2D);
  }

  public PImage display()
  {
    buffer.beginDraw();
    buffer.background(0, 0);
    buffer.smooth();
    buffer.colorMode(HSB, 360, 100, 100, 100);
    buffer.translate(width/2, height/2);

    //this starts the circle at 12:00
    angle = radians(0)-rotation;
    previousLoc = currentLoc.get();

    for (int i = 0; i < dataList.size(); i++) 
    {
      //      if (i == 1)
      //      {
      //        originLoc = currentLoc.get();
      //      }

      oldLoc = currentLoc.get();
      x = cos(angle);
      y = sin(angle);
      currentLoc = new PVector(x, y);

      //swap with below code to zoom with mouse
      //      currentLoc.mult(dataList.get(i) + (mouseX*circleSize));
      currentLoc.mult(dataList.get(i) * (circleSize));

      /////////draw simple line graph/////
      //      buffer.stroke(lineColor);
      //      buffer.strokeWeight(3);
      //
      //      if (i % modVal == 0)
      //      {
      //        buffer.line(0, 0, currentLoc.x, currentLoc.y);
      //      }
      //
      //      if (i != 0)
      //      {
      //        buffer.line(currentLoc.x, currentLoc.y, oldLoc.x, oldLoc.y);
      //      }
      //
      //      if (i == dataList.size()-1)
      //      {
      //        buffer.line(currentLoc.x, currentLoc.y, originLoc.x, originLoc.y);
      //      }
      //////////end simple line graph/////////

      //////////draw graph with quad////////
      buffer.fill(fillColor);
      buffer.stroke(lineColor);
      buffer.quad(0, 0, 0, 0, oldLoc.x, oldLoc.y, currentLoc.x, currentLoc.y);
      ///////////end quad graph////////////

      ////////shape start//////////////
      //      buffer.noStroke();
      //      buffer.beginShape();
      //      buffer.stroke(150, 100);
      //      buffer.strokeWeight(1);
      //      buffer.fill(lineColor);
      //      buffer.vertex(0, 0);
      //      buffer.vertex(0, 0);
      //      //      buffer.fill(fade);
      //      buffer.vertex(oldLoc.x, oldLoc.y);
      //      buffer.vertex(currentLoc.x, currentLoc.y);
      //      buffer.endShape();
      ///////////end shape//////////////

      float dataLength = dataList.size();
      float increment = dataLength/circumference;
      angle = radians(i/increment)-rotation;
    }
    buffer.fill(45, 6, 90, 100);
    //    buffer.noStroke();
    buffer.ellipse(0, 0, innerCirc, innerCirc);
    buffer.noFill();
    buffer.endDraw();

    img = buffer.get(0, 0, buffer.width, buffer.height);
    return img;
  }

  public PShape displayPShape()
  {
    graph = createShape();
    graph.beginShape();
    graph.colorMode(HSB, 360, 100, 100, 100);
    //this starts the circle at 12:00
    angle = radians(0)-rotation;
    previousLoc = currentLoc.get();

    for (int i = 0; i < dataList.size(); i++) 
    {
      oldLoc = currentLoc.get();
      x = cos(angle);
      y = sin(angle);
      currentLoc = new PVector(x, y);
      currentLoc.mult(dataList.get(i) + (circleSize*500));

      ////////shape start//////////////            
      graph.stroke(150, 100);
      graph.strokeWeight(1);
      graph.fill(lineColor);
      graph.vertex(0, 0);
      graph.vertex(0, 0);
      //      graph.fill(fade);
      graph.vertex(oldLoc.x, oldLoc.y);
      graph.vertex(currentLoc.x, currentLoc.y);            
      ///////////end shape//////////////

      float dataLength = dataList.size();
      float increment = dataLength/circumference;
      angle = radians(i/increment)-rotation;
    }
    graph.endShape();
    return graph;
  }

  //  public PImage displayGraph()
  //  {    
  //    img = buffer.get(0, 0, buffer.width, buffer.height);
  //    return img;
  //  }
}
