public void initializeCP5()
{
  concertDDL = cp5.addDropdownList("concertList").setPosition(ddlX, ddlY);
  cp5.setFont(h4Font);
  cp5.setColorLabel(color(0, 0, 50));
  customize(concertDDL);
  customizeButton(cp5);
}

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList  
  ddl.setWidth(ddlW);
  ddl.setHeight(200);
  ddl.setBarHeight(ddlH);
  ddl.setItemHeight(40);
  ddl.hideArrow();
  ddl.setUpdate(false);

  ddl.captionLabel().set("SELECT CONCERT");
  ddl.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  ddl.setColorLabel(color(0, 0, 50));


  for (Event e : event.SelectAll()) 
  {
    ddl.addItem(e.EventName, Integer.parseInt(e.EventId));
  }
  ddl.setColorBackground(color(0, 0, 12));
  ddl.setColorForeground(color(0, 0, 20));
}

public void customizeButton(ControlP5 cp5)
{
  PImage[] pauseImgs = {
    loadImage("stopButtonA.png"), loadImage("stopButtonB.png"), loadImage("stopButtonB.png")
    };
    pause = cp5.addButton("stop")
      .setPosition(stopX, stopY)
        .setImages(pauseImgs)
          .updateSize()
            ;
  PImage[] playImgs = {
    loadImage("playButtonA.png"), loadImage("playButtonB.png"), loadImage("playButtonB.png")
    };
    play = cp5.addButton("play")
      .setPosition(playX, playY)
        .setImages(playImgs)
          .setBroadcast(false)
            .updateSize()
              ;

  descRadio = cp5.addRadioButton("descRadio")
    .setPosition(descX, descY)
      .setSize(descW, descH)
        .setColorBackground(color(0, 0, 12))
          .setColorForeground(color(0, 0, 20))
            .setColorActive(color(0, 0, 20))
              .addItem("Event Notes", 1);

  for (Toggle t : descRadio.getItems()) 
  {
    t.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  }

  concertViewBtn = cp5.addButton("concertView")
    .setPosition(concertViewX, viewY)
      .setSize(viewW, viewH)
        .setColorBackground(color(0, 0, 12))
          .setColorForeground(color(0, 0, 20))
            .setColorActive(color(0, 0, 12));
  concertViewBtn.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  songViewBtn = cp5.addButton("songView")
    .setPosition(songViewX, viewY)
      .setSize(viewW, viewH)
        .setColorBackground(color(0, 0, 12))
          .setColorForeground(color(0, 0, 20))
            .setColorActive(color(0, 0, 12))
              .setBroadcast(false);
  songViewBtn.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  PImage infoA = loadImage("infoIconA.png");
  PImage infoB = loadImage("infoIconB.png");

  infoRadio = cp5.addRadioButton("infoRadio")
    .setPosition(aboutX, aboutY)
      .setSize(30, 30)
        .addItem("Info", 1).setImages(infoA, infoA, infoB)
          ;
}

public void controlEvent(ControlEvent theEvent)
{
  if (theEvent.isFrom(concertDDL))
  {
    if (playing)
    {
      player.pause();
      player.cue(0);
    }
    aniInc = 0;
    radialGraphAlpha = 100;
    graphWinX = sideBarBgW;
    radialPlayBar = 0;
    g = 0;

    songViewBtn.setBroadcast(false);
    songView = false;

    play.setBroadcast(false);
    descRadio.deactivateAll();
    infoRadio.deactivateAll();

    eventName = theEvent.getGroup().getCaptionLabel().getText();
    bandName = event.SelectOneByName(eventName).Name;
    eventId = event.SelectOneByName(eventName).EventId;
    venue = event.SelectOneByName(eventName).Venue;
    date = event.SelectOneByName(eventName).Date;
    bandImage = loadImage(event.SelectOneByName(eventName).Image);
    bandImage.resize(bandImgW, 0);
    bandImgH = bandImage.height;
    songName = "";
    songId = "0";
    songDur = "";

    arcGraph = new ArcGraph(eventId, song);

    thread("loadLists");
    thread("buildWedges");    
    //    thread("combineImages");
    concertView = true;
  }

  if (theEvent.isFrom(descRadio)) 
  {
    if (descRadio.getArrayValue()[0] == 1)
    {      
      descLoad = true;
      infoLoad = false;      
    }
    else
    {
      descLoad = false;
    }
  }

  if (theEvent.isFrom(infoRadio)) 
  {
    if (infoRadio.getArrayValue()[0] == 1)
    {
      infoLoad = true;
      descLoad = false;
    }
    else
    {
      infoLoad = false;
    }
  }



//  else if (theEvent.isGroup()) 
//  {
//    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
//  }
}


public void play()
{
  playing = true;
  songState();
}

public void stop()
{
  playing = false;
  songState();
}

public void concertView()
{
  Ani.to(this, 3, "radialGraphAlpha", 100, Ani.QUINT_IN_OUT);
  Ani.to(this, 3, "graphWinX", sideBarBgW, Ani.QUINT_IN_OUT);
  player.pause();
  player.cue(0);
  Ani.to(this, 3, "aniInc", 0, Ani.QUINT_IN_OUT);
  Ani.to(this, 0.5, "radialPlayBar", 0, Ani.LINEAR);
  radialPlayBar = 0;
  g = 0;

  play.setBroadcast(false);  
  concertView = true;
  songView = false;
}

public void songView()
{
  Ani.to(this, 3, "radialGraphAlpha", 20, Ani.QUINT_IN_OUT);
  Ani.to(this, 3, "graphWinX", -90, Ani.QUINT_IN_OUT);
  songAni();
  play.setBroadcast(true);
  concertView = false;
  songView = true;
}

public void songAni()
{
  ani = 1;
  Ani.to(this, 3, "aniInc", 90, Ani.QUINT_IN_OUT);
}




public void songState()
{
  if (playing)
  {
    g = 2;
    player = minim.loadFile(songFileName);
    player.play();
    Ani.to(this, songLength, "radialPlayBar", 90, Ani.LINEAR);
    //    lineGraphPlayBarX = lineGraphX1.get(Integer.valueOf(songId));
    //    Ani.to(this, songLength, "lineGraphPlayBarX", lineGraphX2.get(Integer.valueOf(songId)), Ani.LINEAR);
  }
  else if (!playing)
  {
    player.pause();
    player.cue(0);
    //    lineGraphPlayBarX = sideBarBgW;
    //  Ani.to(this, 3, "aniInc", 0, Ani.QUINT_IN_OUT);
    Ani.to(this, 0.5, "radialPlayBar", 0, Ani.LINEAR);
    radialPlayBar = 0;
    g = 0;
  }
}
