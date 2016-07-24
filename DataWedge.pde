public class Wedge
{
  private ArrayList<Float> dataList;
  private float wedgeArcLength;
  private float rotation;

  private float winW, winH, x, y, newX, newY;
  private float angle;

  private color fill;
  private color line; 
  
  private float scale = 0.75;

  public Wedge(float winW, float winH, ArrayList dataList, float wedgeArcLength, float rotation, color fill, color line)
  {
    this.winW = winW;
    this.winH = winH;
    this.dataList = dataList;
    this.wedgeArcLength = wedgeArcLength;
    this.rotation = rotation;
    this.fill = fill;
    this.line = line;
  }

  public void drawWedge(PGraphics buffer)
  {
    buffer.beginDraw();
    buffer.smooth();
    buffer.colorMode(HSB, 360, 100, 100, 100);

    float dataLength = dataList.size()-1;
    float increment = dataLength/wedgeArcLength;

    angle = radians(360)-rotation;
    x = winW/2 +  cos(angle) * dataList.get(0) * scale;
    y = winH/2 + sin(angle) * dataList.get(0) * scale;

    for (int i = 1; i < dataList.size(); i++) 
    {       
      angle = radians(i/increment)-rotation;

      newX = winW/2 +  cos(angle) * dataList.get(i) * scale;
      newY = winH/2 + sin(angle) * dataList.get(i) * scale;

//      buffer.noStroke();
      buffer.fill(fill);
      buffer.stroke(line);
      buffer.triangle(winW/2, winH/2, x, y, newX, newY);

      x = newX;
      y = newY;
    }
    buffer.endDraw();
  }


  public void drawAniWedge(float a, color circC)
  {    
    fill(fill); 
    //    stroke(line);
    //    noStroke();
    float dataLength = dataList.size()-1;
    float increment = dataLength/a;

    angle = radians(360)-rotation;
    x = winW/2 +  cos(angle) * dataList.get(0) * scale;
    y = winH/2 + sin(angle) * dataList.get(0) * scale;

    for (int i = 1; i < dataList.size(); i++) 
    { 
      angle = radians(i/increment)-rotation;

      newX = winW/2 +  cos(angle) * dataList.get(i) * scale;
      newY = winH/2 + sin(angle) * dataList.get(i) * scale;
      triangle(winW/2, winH/2, x, y, newX, newY);

      x = newX;
      y = newY;
    }

    fill(circC);
    noStroke();
    ellipse(winW/2, winH/2, 300 * scale, 300 * scale);
  }
  
  
  public void drawArcWedge(float a)
  {    
    fill(fill); 
    //    stroke(line);
    //    noStroke();
    float dataLength = dataList.size()-1;
    float increment = dataLength/a;

    angle = radians(360)-rotation;
    x = winW/2 +  cos(angle) * dataList.get(0) * scale;
    y = winH/2 + sin(angle) * dataList.get(0) * scale;

    for (int i = 1; i < dataList.size(); i++) 
    { 
      angle = radians(i/increment)-rotation;

      newX = winW/2 +  cos(angle) * dataList.get(i) * scale;
      newY = winH/2 + sin(angle) * dataList.get(i) * scale;
      triangle(winW/2, winH/2, x, y, newX, newY);

      x = newX;
      y = newY;
    }

    fill(45, 6, 90);
    noStroke();
    ellipse(winW/2, winH/2, 300 * scale, 300 * scale);
  }
  
  



  public void drawPlayBar(color circFill, color stroke)
  {
    stroke(stroke);
    strokeWeight(4);
    rotate(radians(360)-rotation);
    line(0, 0, 400, 0);

    fill(circFill);
    noStroke();
    ellipse(0, 0, 300 * scale, 300 * scale);
  }


  //DRAW WITH VERTEX INSTEAD
  //public void drawWedge(PGraphics buffer)
  //  {
  //    buffer.beginDraw();
  ////    buffer.background(0,50);
  //    buffer.smooth();
  //    buffer.colorMode(HSB, 360, 100, 100, 100);
  //    buffer.beginShape();
  //    
  //    angle = radians(360)-rotation;
  //    x = width/2 +  cos(angle) * dataList.get(0);
  //    y = height/2 + sin(angle) * dataList.get(0);
  //
  //    for (int i = 1; i < dataList.size(); i++) 
  //    {
  //      float dataLength = dataList.size()-1;
  //      float increment = dataLength/wedgeArcLength;
  //      
  //      angle = radians(i/increment)-rotation;
  //      newX = width/2 +  cos(angle) * dataList.get(i);
  //      newY = height/2 + sin(angle) * dataList.get(i);
  //
  //      buffer.fill(fill);
  //      buffer.stroke(line);
  ////      buffer.line(x, y, newX, newY);
  //      buffer.vertex(x, y);
  //      buffer.vertex(newX, newY);
  //
  //      x = newX;
  //      y = newY;
  //    }
  //    buffer.vertex(width/2, height/2);
  //    buffer.endShape();
  //    buffer.endDraw();
  ////    image(buffer, 0, 0);
  //  }
}
