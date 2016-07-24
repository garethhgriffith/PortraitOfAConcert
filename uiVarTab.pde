

public void initializeUI()
{
  /////THESE VARIABLES CAN BE ALTERED TO MAKE THE SKETCH "RESPONSIVE"
  /////BACKGROUND IMAGES ARE ALREADY RESPONSIVE. TYPE AND PADDING IS NOT
  //Fonts
  h1Font = loadFont("AlrightSans-Black-30.vlw");
  h2Font = loadFont("AlrightSans-Regular-30.vlw");
  h3Font = loadFont("AlrightSans-Regular-20.vlw");

  //PFont pfont = loadFont("AlrightSans-Medium-14.vlw");
  PFont pfont = createFont("AlrightSans-Medium-v3.otf", 14, true);
  h4Font = new ControlFont(pfont);
  h5Font = loadFont("AlrightSans-Light-15.vlw");
  //Images
  splashScreen = loadImage("splashScreen.png");
  um2014_02_15 = loadImage("um2014_02_15.png");
  um2014_02_16 = loadImage("um2014_02_16.png");
  tauk2014_02_27 = loadImage("tauk2014_02_27.png");
  zakh2014_03_31= loadImage("zakh2014_03_31.png"); 
  dataOverview = loadImage("dataOverview.png");
  songInfo = loadImage("songInfo.png");
  //General
  headPad = 20;
  sidePad = 20;
  areaPad = 20;
  lineSpace = 5;
  h1 = 30;
  h2 = 26;
  h3 = 18;
  h4 = 14;
  //Header
  headerBgH = height * 0.08333333333333333333333333333333;
  cp5H = 25;
  cp5Y = (int)headerBgH/2 + cp5H/2;
  concertCP5X = 500;   
  //Side bar
  sideBarBgY = headerBgH;
  sideBarBgW = width * 0.19814814814814814814814814814815;
  sideBarBgH = height - headerBgH;
  //Graph Window
  graphWinW = (int)(width - sideBarBgW);
  graphWinH = (int)(height - headerBgH);
  graphWinX = sideBarBgW;
  graphWinY = headerBgH;
  //Description Overlay
  descWinW = graphWinW;
  descWinH = graphWinH/2;
  //Area Graph
  areaGraphWinY = (int)((graphWinH * 0.85454545454545454545454545454545) + headerBgH);  
  areaGraphWinW = (int)(graphWinW - areaPad);
  areaGraphWinH = (int)(((graphWinH * 0.97575757575757575757575757575758) + headerBgH) - areaGraphWinY);
  areaGraphX1 = areaPad;
  areaGraphY1 = 0; 
  areaGraphY2 = areaGraphWinH;
  //Song Zoom
  songZoomX = sideBarBgW;
  //Song List
  songListX = (int)(sideBarBgW + areaPad);
  graphWinYMid = graphWinH/2 + headerBgH;

  /////BE CAREFUL WHEN CHANGING VARIABLES BELOW AS THEY DRAMATICALLY 
  /////ALTER THE UI LAYOUT...THE VARIABLES ABOVE SHOULD BE ASSESSED
  /////BEFORE MESSING AROUND HERE

  //Title
  title = "PORTRAIT OF A CONCERT";
  titleX = headPad;
  titleY = headPad + h1;
  //Header Drop Down  
  ddlW = 215;
  ddlH = 50;
  //  ddlH = (int)headerBgH - 10;
  ddlX = (int)(sideBarBgW + areaPad) + 200;
  ddlY = (int)headerBgH/2 + ddlH/2 + 1;
  //Header Buttons
  descW = 150; 
  descH = 50;
  descX = ddlX + ddlW;
  descY = (int)headerBgH/2 - descH/2;

  viewW = 150;
  viewH = 50;
  concertViewX = descX + descW;
  songViewX = concertViewX + viewW;
  viewY = (int)headerBgH/2 - viewH/2;

  aboutW = 30;
  aboutH = 30;
  aboutX = width - headPad - aboutW;
  aboutY = (int)headerBgH/2 - aboutH/2;
  //Event
  bandNameY = headerBgH + sidePad + h2;
  venueY = bandNameY + h3 + lineSpace;
  dateY = venueY + h3 + lineSpace;
  bandName = "Umphrey's McGee";
  venue = "The Filmore - Silver Spring, MD";
  date = "February 15, 2014"; 
  //Event Picture
  bandImgY = dateY + 20;
  bandImgW = (int)sideBarBgW - (sidePad*2);
  bandImage = loadImage("um2014_02_15.JPG");
  bandImage.resize(bandImgW, 0);
  bandImgH = bandImage.height;
  //Song Details Header
  songDetailsY = bandImgY + bandImgH + 30;
  songDetailsLineY = songDetailsY + lineSpace + 5;
  //Song Name
  songText = "Song:        ";
  songTextY = songDetailsY + h2; 
  songTextW = textWidth(songText);
  songName = "";
  //Song Duration
  durText = "Duration:         ";
  durTextY = songTextY + h3 + lineSpace;
  durTextW = textWidth(durText);  
  songDur = "";
  //Song Controls
  songContText = "Song Controls";
  songContTextY = durTextY + 50;
  songContLineY = songContTextY + lineSpace + 5;
  //Song Play Buttons
  buttonW = 50;
  playX = sidePad;
  playY = songContTextY + 20;
  stopX = stopX + buttonW + 20;
  stopY = songContTextY + 20;
}
