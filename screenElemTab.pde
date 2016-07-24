public void showUIOnly()
{

  textAlign(LEFT);
  titleBar();
  sideBar();
  titleBarInfo();
  tint(360, 100);
  sideBarInfo();
}

public void showAll()
{
  displayLines();
  noStroke();
  tint(360, 100);
  if (aniInc > 0 && aniInc <= 90)//if we are not showing a song
  {
    if (ani == 1 && Integer.valueOf(songId) > 0)
    {
      pushMatrix();
      translate(songZoomX, graphWinY-50);
      drawAniWedge();
      aniAudioWedge.drawAniWedge(aniInc, bg);
      aniStWedge.drawAniWedge(aniInc, bg);
      aniHrWedge.drawAniWedge(aniInc, bg);    
      aniGsrWedge.drawAniWedge(aniInc, bg);
      popMatrix();
    }

    if (g == 2)
    {
      pushMatrix();
      translate(graphWinW/2 + songZoomX, graphWinH/2 + graphWinY-50);
      rotate(radians(radialPlayBar));    
      aniAudioWedge.drawPlayBar(bg, bgTrans);
      popMatrix();

      //        pushMatrix();
      //        translate(sideBarBgW, 0);
      //        drawLinePlayBar(lineGraphPlayBarX);
      //        popMatrix();
    }
  }

  pushMatrix();
  translate(graphWinX, graphWinY-50);
  tint(360, radialGraphAlpha);
  displayWedges();
  arcGraph.drawArcs(graphWinW/2, graphWinH/2, arcSWeight, bg, bgTrans, songId);
  noStroke();
  fill(bg);
  ellipse(graphWinW/2, graphWinH/2, 300 * 0.75, 300 * 0.75);
  popMatrix();

  rect(0, graphWinY, 560, graphWinH - (areaGraphWinH + areaPad));
  titleBar();
  sideBar();
  titleBarInfo();
  tint(360, 100);
  sideBarInfo();

  songList.display(song.SelectAllByEvent(eventId), songListX, graphWinYMid);

  if (songList.Update && playing)
  { 
    player.pause();
    player.cue(0);

    Ani.to(this, 0.5, "radialPlayBar", 0, Ani.LINEAR); 
    lineGraphPlayBarX = sideBarBgW; 
    songViewBtn.setBroadcast(true);
    songId = songList.getSongId();
    songName = songList.getSongName();    
    songFileName = songList.getSongFileName();
    metaPlayer = minim.loadFile(songFileName);
    meta = metaPlayer.getMetaData();
    songDur = timeConverter.convertMsToMinSecs(meta.length());
    songLength = meta.length()/1000;
    arcSWeight = 425;
    player = minim.loadFile(songFileName);
    
    songViewBtn.setBroadcast(true);
  }
  else if (songList.Update)
  {
    lineGraphPlayBarX = sideBarBgW;
    songId = songList.getSongId();
    songName = songList.getSongName();    
    songFileName = songList.getSongFileName();
    metaPlayer = minim.loadFile(songFileName);
    meta = metaPlayer.getMetaData();
    songDur = timeConverter.convertMsToMinSecs(meta.length());
    songLength = meta.length()/1000;
    arcSWeight = 425;
    player = minim.loadFile(songFileName);

    songViewBtn.setBroadcast(true);
  }
}
