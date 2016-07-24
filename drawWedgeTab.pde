public void buildWedges()
{   
  wedgeLoad = false;
  
  float bioLength = biometricData.GetTotalBioLength(song.SelectAllByEvent(eventId));
  float bioWedgeIncrement = 350/bioLength;
  float bioRotation = radians(175);

  float audioLength = audio.GetAudioLength(song.SelectAllByEvent(eventId));
  float audioWedgeIncrement = 175/audioLength;
  float audioRotation = radians(87.5);  
  
  audioPGraphic.clear();
  audioLinePGraphic.clear();
  skinPGraphic.clear();  
  stLinePGraphic.clear();
  hrPGraphic.clear();
  hrLinePGraphic.clear();
  gsrPGraphic.clear();
  gsrLinePGraphic.clear();

  int counter = 0;
  areaGraphX1 = areaPad;
  for (Song sng : song.SelectAllByEvent(eventId))
  {
    int bioSongLength = biometricData.GetSongBioLength(sng.SongId);
    float bioWedgeLength = bioSongLength * bioWedgeIncrement;
    float areaGraphX2 = areaGraphWinW/(bioLength/bioSongLength);

    int audioSongLength = audio.GetAudioSongLength(sng.SongId);
    float audioWedgeLength = audioSongLength * audioWedgeIncrement;

    ArrayList<Float> gsrList = new ArrayList<Float>();
    ArrayList<Float> heartrateList = new ArrayList<Float>();  
    ArrayList<Float> skinTempList = new ArrayList<Float>();
    ArrayList<Float> audioList = new ArrayList<Float>();

    for (BiometricData bio : biometricData.SelectAllBySong(sng.SongId))
    {
      gsrList.add(bio.Gsr);
      heartrateList.add(bio.HeartRate);
      skinTempList.add(bio.SkinTemp);
    }
    //if exceptions for before and after concert
    if (counter > 0 && counter < song.SelectAllByEvent(eventId).size()-1)
    {
      for (AudioData aud : audio.SelectAllBySong(sng.SongId))
      {
        audioList.add(aud.Volume);
      }
    }

    Wedge wedge;
    LineGraph lineGraph;  
    //move the x position up each time you create a new song
    areaGraphX2 = areaGraphX1 + areaGraphX2;

    //if exceptions for before and after concert
    //    if (!sng.SongId.equals("0") && !sng.SongId.equals("18"))    
    if (counter > 0 && counter < song.SelectAllByEvent(eventId).size()-1)
    {
      
//      println(counter + " : " + song.SelectAllByEvent(eventId).size());
      wedge = new Wedge(graphWinW, graphWinH, audioList, bioWedgeLength, bioRotation, audioFill, audioLine);
      wedge.drawWedge(audioPGraphic);
//      audioWedgeList.add(audioPGraphic);      

      lineGraph = new LineGraph(audioTotalList, audioList, areaGraphX1, areaGraphX2, areaGraphY1, areaGraphY2, audioFill, audioLine);
      lineGraph.drawLineGraph(audioLinePGraphic); 
//      audioLineList.add(audioLinePGraphic);

//      lineGraphX1.add(Integer.valueOf(sng.SongId), areaGraphX1);
//      lineGraphX2.add(Integer.valueOf(sng.SongId), areaGraphX2);
    }
    //SKIN TEMPERATURE
    wedge = new Wedge(graphWinW, graphWinH, skinTempList, bioWedgeLength, bioRotation, skinFill, skinLine);
    wedge.drawWedge(skinPGraphic);
//    stWedgeList.add(skinPGraphic); 

    lineGraph = new LineGraph(stTotalList, skinTempList, areaGraphX1, areaGraphX2, areaGraphY1, areaGraphY2, skinLineFill, skinLine);
    lineGraph.drawLineGraph(stLinePGraphic);
//    stLineList.add(stLinePGraphic);

    //GSR
    wedge = new Wedge(graphWinW, graphWinH, gsrList, bioWedgeLength, bioRotation, gsrFill, gsrLine);
    wedge.drawWedge(gsrPGraphic);
//    gsrWedgeList.add(gsrPGraphic);

    lineGraph = new LineGraph(gsrTotalList, gsrList, areaGraphX1, areaGraphX2, areaGraphY1, areaGraphY2, gsrLineFill, gsrLine);
    lineGraph.drawLineGraph(gsrLinePGraphic);
//    gsrLineList.add(gsrLinePGraphic);

    //HEARTRATE
    wedge = new Wedge(graphWinW, graphWinH, heartrateList, bioWedgeLength, bioRotation, hrFill, hrLine);
    wedge.drawWedge(hrPGraphic);
//    hrWedgeList.add(hrPGraphic);

    lineGraph = new LineGraph(hrTotalList, heartrateList, areaGraphX1, areaGraphX2, areaGraphY1, areaGraphY2, hrLineFill, hrLine);
    lineGraph.drawLineGraph(hrLinePGraphic);
//    hrLineList.add(hrLinePGraphic);

    bioRotation = bioRotation-radians(bioWedgeLength);
    audioRotation = audioRotation-radians(audioWedgeLength);
    areaGraphX1 = areaGraphX2;
    counter++;
  }
  
  wedgeLoad = true;
}
////////////////////////////////////////NON IMPLEMENTED METHOD

public void drawLinePlayBar(float xPos)
{
  stroke(bgTrans);
  strokeWeight(4);
  line(xPos, height - areaPad, xPos, height - (areaPad + areaGraphWinH));
}




//public void buildWedge()
//{
//  PGraphics wedge = createGraphics(width, height, P2D);
//  double bioLength = biometricData.GetTotalBioLength(song.SelectAllByEvent(eventId));
//  double bioIncrement = 360/bioLength;
//  float bioRotation = radians(180);   
//
//  String songId = "0";
//
//  int songLength = biometricData.GetSongBioLength(songId);
//  float gsrWedgeLength = (float)(songLength * bioIncrement);
//  ArrayList<Float> gsrList = new ArrayList<Float>();
//  for (BiometricData bio : biometricData.SelectAllBySong(songId))
//  {
//    gsrList.add(bio.HeartRate);
//  }
//  Wedge thisWedge = new Wedge(gsrList, gsrWedgeLength, bioRotation, gsrFill);
//
//  gsrWedgeList.add(thisWedge.drawWedge(wedge));
//}







public void drawAniWedge()
{ 
  float bioLength = biometricData.GetTotalBioLength(song.SelectAllByEvent(eventId));  
  float bioIncrement = 360/30;
  float bioRotation = radians(50);   

  //  int songLength = biometricData.GetSongBioLength(songId);
  //  songLength = audio.GetAudioSongLength(songId);

  float wedgeLength = songLength * bioIncrement;

  ArrayList<Float> gsrList = new ArrayList<Float>();
  ArrayList<Float> hrList = new ArrayList<Float>();
  ArrayList<Float> stList = new ArrayList<Float>();
  ArrayList<Float> audioList = new ArrayList<Float>();
  for (BiometricData bio : biometricData.SelectAllBySong(songId))
  {
    gsrList.add(bio.Gsr);
    hrList.add(bio.HeartRate);
    stList.add(bio.SkinTemp);
  }
  for (AudioData aud : audio.SelectAllBySong(songId))
  {
    audioList.add(aud.Volume);
  }

  aniGsrWedge = new Wedge(graphWinW, graphWinH, gsrList, aniInc, bioRotation, gsrFill, gsrLine);
  aniHrWedge = new Wedge(graphWinW, graphWinH, hrList, aniInc, bioRotation, hrFill, hrLine);
  aniStWedge = new Wedge(graphWinW, graphWinH, stList, aniInc, bioRotation, skinFill, skinLine);
  aniAudioWedge = new Wedge(graphWinW, graphWinH, audioList, aniInc, bioRotation, audioFill, audioLine);
}
