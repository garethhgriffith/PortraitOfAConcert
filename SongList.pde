public class SongList
{
  private int fontSize;
  private color fontColor;
  private PGraphics textBox;
  private PGraphics textSelect;
  private float top;
  private float textH;
  private int songListX;
  private int songListW;
  private String songName;
  private String songFileName;
  private String songId;
  private boolean Update;

  //  public SongList(PFont font, int fontSize, color fontColor)
  public SongList(int fontSize, color fontColor)
  {    
    this.fontSize = fontSize;
    this.fontColor = fontColor;
  }

  public void display(ArrayList<Song> songList, int songListX, float graphWinMidY)
  {
    this.songListX = songListX;
    float scalar = 0.8;//change this depening on the font
    float base = 10;//where the font draws from...the baseline

    top = 0;
    float textT = base - (textAscent() * scalar);//top of the font
    float textB = base + (textDescent() * scalar);//bottom of the font
    float textC = (textB - textT)/2;//middle of the font
    textH = textB - textT;//height
    float textS = 15;//text spacing

    songListW = 200;
    float songListH = (textH + textS) * (songList.size() + 1);
    float songListY = graphWinMidY - songListH/2;//positions the list in the middle of the radial graph

    textBox = createGraphics(songListW, (int)songListH);
    textBox.colorMode(HSB, 360, 100, 100, 100);
    textSelect = createGraphics(songListW, (int)songListH);
    textSelect.colorMode(HSB, 360, 100, 100, 100);
    textBox.beginDraw();
    textSelect.beginDraw();
    textBox.textAlign(RIGHT);
    textSelect.textAlign(RIGHT);
    textBox.textSize(fontSize);
    textSelect.textSize(fontSize);
    textSelect.textFont(h5Font);   

    for (int i = 1; i < songList.size() - 1; i++)
    {
      if (overText(mouseX, mouseY - songListY))
      {
        textBox.fill(229, 229, 229);
        textBox.text(songList.get(i).Name, songListW, top+ abs(textT) + base);
        if (mousePressed && (mouseButton == LEFT))
        {          
          songName = songList.get(i).Name;
          songFileName = songList.get(i).SongFileName;
          songId = songList.get(i).SongId;

          textSelect.fill(229, 229, 229);

          Update = true;
        }
        else
        {
          Update = false;
        }
      }
      else
      {
        textBox.fill(fontColor);
      }
      textSelect.text(songList.get(i).Name, songListW, top+ abs(textT) + base);
      textBox.text(songList.get(i).Name, songListW, top+ abs(textT) + base);
      top = top + textH + textS;
    }

    textBox.endDraw();
    textSelect.endDraw();
    image(textBox, songListX, songListY);
    //    image(textSelect, songListX, songListY);
  }

  public boolean overText(float mx, float my)
  {
    if (mx >= songListX && mx <= songListX + songListW && my >= top && my <= top + textH)
    {
      return true;
    }
    else
    {
      return false;
    }
  }


  public String getSongName()
  {
    return songName;
  }

  public String getSongFileName()
  {
    return songFileName;
  }

  public String getSongId()
  {
    return songId;
  }
}
