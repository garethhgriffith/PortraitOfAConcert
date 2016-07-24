import de.looksgood.ani.*;
import ddf.minim.*;
import controlP5.*;
import java.util.concurrent.*;

Minim minim;
AudioPlayer player;
AudioPlayer metaPlayer;
AudioMetaData meta;
ControlP5 cp5;
DropdownList concertDDL, aboutDDL;
Button concertViewBtn, songViewBtn, pause, play;
RadioButton descRadio, infoRadio;

private Event event = new Event();
private Song song = new Song();
private AudioData audio = new AudioData();
private BiometricData biometricData = new BiometricData();
private Wedge aniGsrWedge, aniHrWedge, aniStWedge, aniAudioWedge;
private LineGraph linePlayBar;
private SongList songList;
private TimeConverter timeConverter = new TimeConverter();

private ArcGraph arcGraph;
private float arcSWeight;


PGraphics skinPGraphic, audioPGraphic, gsrPGraphic, hrPGraphic;
PGraphics audioLinePGraphic, stLinePGraphic, gsrLinePGraphic, hrLinePGraphic, bioPGraphics;
PGraphics wedgeCombo;

private ArrayList<Float> gsrTotalList = new ArrayList<Float>();
private ArrayList<Float> hrTotalList = new ArrayList<Float>();
private ArrayList<Float> stTotalList = new ArrayList<Float>();
private ArrayList<Float> audioTotalList = new ArrayList<Float>();

private ArrayList<Float> lineGraphX1 = new ArrayList<Float>();
private ArrayList<Float> lineGraphX2 = new ArrayList<Float>();

private String eventId;
private String eventName;
private String songFileName;
private String songId;

private int songLength;


////////////////////////////////////////////////////////////////////////////////////UI Variables

//General UI Variables
private int h1, h2, h3, h4;
private int graphWinW, graphWinH;
private float headerBgH, sideBarBgY, sideBarBgW, sideBarBgH, graphWinX, graphWinY, graphWinYMid, descWinW, descWinH;
private float areaGraphWinY, areaGraphX1, areaGraphX2, areaGraphY1, areaGraphY2, areaPad;
private int areaGraphWinW, areaGraphWinH;
private float songZoomX;
private int songListX;

//Fonts
private PFont h1Font, h2Font, h3Font, /* h4Font,*/ h5Font;
ControlFont h4Font;
//Images
private PImage splashScreen, um2014_02_15, um2014_02_16, tauk2014_02_27, zakh2014_03_31, dataOverview, songInfo;
//Header UI Layout Variables
private int headPad;
private int concertCP5X, aboutCP5X, cp5H, cp5Y;
private int titleX, titleY, titleM, ddlX, ddlY, ddlW, ddlH, descW, descH, descX, descY, viewW, viewH, concertViewX, songViewX, viewY, aboutW, aboutH, aboutX, aboutY;

//Side UI Layout Variables
private int sidePad, lineSpace;
private float bandImgY;
private int bandImgW, bandImgH;
private float bandNameY, venueY, dateY, songDetailsY, songDetailsLineY, songTextY, durTextY;
private float songTextW, durTextW;
private float  songContTextY, songContLineY, buttonW, stopX, stopY, playX, playY;

//Header UI Text
private String title;

//Side UI Text
private String bandName, venue, date, songText, songName, durText, songDur, songContText;
private PImage bandImage;

//Colors
private color bg, bgTrans;
private color audioFill, gsrFill, hrFill, skinFill;
private color audioLineFill, gsrLineFill, hrLineFill, skinLineFill;
private color gsrLine, hrLine, skinLine, audioLine;

int ani = 0;
int g = 0;
int a  = 0;

float aniInc = 0;
float radialPlayBar = 0;
float lineGraphPlayBarX = 0;
float radialGraphAlpha = 100;
float arcAlpha = 50;

boolean splash = true;
boolean dataLoad = false;
boolean wedgeLoad = false;
boolean wedgeCombine = false;
boolean playing = false;
boolean descLoad = false;
boolean infoLoad = false;
boolean songView = false;
boolean concertView = true;
//////////////////////////////////////////////////////////////////////////////////////////SETUP
public void setup(  )
{ 
  size(1600, 900); 
  colorMode(HSB, 360, 100, 100, 100); 
  Ani.init(this); 
  minim = new Minim(this);

  cp5 = new ControlP5(this);

  eventId = "1"; 
  eventName = "Umphrey's McGee 02-15-2014";
  songId = "0";

  bg = color(299, 0, 9);
  bgTrans = color(bg, 75);
  audioFill = color(174, 53, 55, 100);
  skinFill = color(186, 97, 35, 75);
  hrFill = color(191, 95, 25, 75);
  gsrFill = color(207, 92, 15, 55);

  audioLineFill = color(174, 53, 55, 80);
  skinLineFill = color(186, 97, 35, 80);  
  hrLineFill = color(191, 95, 25, 80);
  gsrLineFill = color(207, 92, 15, 80);  

  gsrLine = color(8, 89, 38, 0);
  hrLine = color(9, 78, 67, 0);
  skinLine = color(15, 80, 77, 0);
  audioLine = color(31, 64, 85, 0); 

  initializeUI();

  skinPGraphic = createGraphics(graphWinW, graphWinH);
  audioPGraphic = createGraphics(graphWinW, graphWinH);
  gsrPGraphic = createGraphics(graphWinW, graphWinH);
  hrPGraphic = createGraphics(graphWinW, graphWinH);
  audioLinePGraphic = createGraphics(areaGraphWinW, areaGraphWinH);
  stLinePGraphic = createGraphics(areaGraphWinW, areaGraphWinH);
  hrLinePGraphic = createGraphics(areaGraphWinW, areaGraphWinH);
  gsrLinePGraphic = createGraphics(areaGraphWinW, areaGraphWinH);
  wedgeCombo = createGraphics(graphWinW, graphWinH);

  loadLists();
  buildWedges();
  combineImages();

  thread("loadLists");
  thread("buildWedges");
  thread("combineImages");

  initializeCP5();
  songList = new SongList(h4, color(0, 0, 50));
  arcGraph = new ArcGraph(eventId, song);
  arcSWeight = 0;

  playing = false;
}


////////////////////////////////////////////////////////////////////////////////////////////DRAW
public void draw() 
{
  background(bg);
  smooth();

  if (mousePressed == true)
  {
    splash = false;
  }

  if (splash == true)
  {
    cp5.hide();  
    displaySplash();
    
  }
  else 
  {
    cp5.show();  
    if (!dataLoad || !wedgeLoad || !wedgeCombine)
    {  
      fill(bgTrans);
      noStroke();
      rect(sideBarBgW, headerBgH, graphWinW, graphWinH);
      fill(200);
      textSize(h1);
      textAlign(CENTER);
      textFont(h2Font);
      text("Loading...", graphWinW/2 + sideBarBgW, graphWinH/2 + headerBgH);
      showUIOnly();
    } else if (descLoad)
    {
      showAll();
      infoRadio.deactivateAll();

      fill(bgTrans);
      noStroke();
      switch(Integer.valueOf(eventId))
      {
      case 1:       
        rect(sideBarBgW, headerBgH, graphWinW, graphWinH);   
        image(um2014_02_15, sideBarBgW, headerBgH);
        //THIS WILL BREAK IF THE WINDOW SIZE EVER CHANGES
        if (overImage(357, 950, 300, 677))
        {
          rect(357, 660, 593, 20);
          textFont(h5Font);
          fill(360);
          text("           The Fillmore in Silver Springs, Maryland. The Fillmore Silver Spring. Web. 2014", 357, 675);
        }
        break;

      case 2:
        rect(sideBarBgW, headerBgH, graphWinW, graphWinH);   
        image(um2014_02_16, sideBarBgW, headerBgH);
        //THIS WILL BREAK IF THE WINDOW SIZE EVER CHANGES
        if (overImage(357, 950, 300, 677))
        {
          rect(357, 660, 593, 20);
          textFont(h5Font);
          fill(360);
          text("           The Fillmore in Silver Springs, Maryland. The Fillmore Silver Spring. Web. 2014", 357, 675);
        }
        break;

      case 3:
        rect(sideBarBgW, headerBgH, graphWinW, graphWinH);   
        image(tauk2014_02_27, sideBarBgW, headerBgH);
        break;

      case 4:
        rect(sideBarBgW, headerBgH, graphWinW, graphWinH);   
        image(zakh2014_03_31, sideBarBgW, headerBgH);
        break;
      }
    } else if (infoLoad)
    {
      showAll();
      descRadio.deactivateAll();

      if (songView)
      {
        image(songInfo, sideBarBgW, headerBgH);
      }
      if (concertView)
      {
        image(dataOverview, sideBarBgW, headerBgH);
      }
    } else
    {
      showAll();
    }
  }
}

public void displaySplash()
{
  image(splashScreen, 0, 0);
}


//this method is not working properly with the thread
//don't know why
//removed it and just used displayWedges()
public void combineImages()
{
  wedgeCombine = false;

  wedgeCombo.clear();
  wedgeCombo.beginDraw();
  wedgeCombo.image(audioPGraphic, 0, 0);
  wedgeCombo.image(skinPGraphic, 0, 0);
  wedgeCombo.image(hrPGraphic, 0, 0);
  wedgeCombo.image(gsrPGraphic, 0, 0);
  wedgeCombo.endDraw();

  wedgeCombine = true;
}



public void displayWedges()
{    
  //  image(wedgeCombo, 0, 0);
  image(audioPGraphic, 0, 0);
  image(skinPGraphic, 0, 0);
  image(hrPGraphic, 0, 0);
  image(gsrPGraphic, 0, 0);
}

public void displayLines()
{
  //  image(audioLinePGraphic, sideBarBgW, areaGraphWinY);
  image(stLinePGraphic, sideBarBgW, areaGraphWinY);  
  image(hrLinePGraphic, sideBarBgW, areaGraphWinY);
  image(gsrLinePGraphic, sideBarBgW, areaGraphWinY);
}


//loads the data lists so the wedges can be drawn
public void loadLists()
{
  dataLoad = false;
  for (Song sng : song.SelectAllByEvent (eventId))
  {
    for (AudioData aud : audio.SelectAllBySong (sng.SongId))
    {
      audioTotalList.add(aud.Volume);
    }
  }

  for (Song sng : song.SelectAllByEvent (eventId))
  {
    for (BiometricData bio : biometricData.SelectAllBySong (sng.SongId))
    {
      gsrTotalList.add(bio.Gsr);
      hrTotalList.add(bio.HeartRate);
      stTotalList.add(bio.SkinTemp);
    }
  }

  dataLoad = true;
}
