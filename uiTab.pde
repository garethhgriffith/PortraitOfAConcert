public void titleBar()
{
  fill(0, 0, 12);
  rect(0, 0, width, headerBgH);
}



public void sideBar()
{
  fill(0, 0, 20);
  rect(0, sideBarBgY, sideBarBgW, sideBarBgH);
}


public void titleBarInfo()
{
  fill(360);
  textSize(h1);
  textFont(h1Font);
  text(title, headPad, headPad + h1);
}




public void sideBarInfo()
{  
  fill(360);
  //Band name 
  textSize(h2); 
  textFont(h2Font); 
  text(bandName, sidePad, bandNameY); 
  //Venue
  textSize(h4);
  //  textFont(h4Font);
  text(venue, sidePad, venueY);
  //Date
  textSize(h4);
  text(date, sidePad, dateY);
  //Image
  image(bandImage, sidePad, bandImgY);
  //Image Copyright
  if (overImage(sidePad, sidePad + bandImgW, bandImgY, bandImgY + bandImgH) && eventId.equals("2"))
  {
    fill(0, 50);
    rect(sidePad, bandImgY + bandImgH - 20, bandImgW, 20);
    textFont(h5Font);
    fill(360);
    text("        Jefferson Waful, The View. 2014", sidePad, bandImgY + bandImgH - 5);
  }
  fill(360);
  //Song Details
  textSize(h3);
  textFont(h3Font);
  text("Song Details", sidePad, songDetailsY);
  stroke(300);
  strokeWeight(1.5);
  line(sidePad, songDetailsLineY, sideBarBgW - sidePad, songDetailsLineY);
  //Song
  textSize(h4);
  //  textFont(h4Font);
  text(songText, sidePad, songTextY);
  text(songName, songTextW, songTextY);
  //Duration
  text(durText, sidePad, durTextY);
  text(songDur, durTextW, durTextY);
  //Song Controls
  textSize(h3);
  textFont(h3Font);
  text(songContText, sidePad, songContTextY);
  line(sidePad, songContLineY, sideBarBgW - sidePad, songContLineY);
}

public boolean overImage(float topLeft, float botLeft, float topRight, float botRight)
{
  if (mouseX >= topLeft && mouseX <= botLeft && mouseY >= topRight && mouseY <= botRight)
  {
    return true;
  }
  else
  {
    return false;
  }
}
