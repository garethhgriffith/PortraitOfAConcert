public class ArcGraph
{
  private ArrayList<Integer> colorList;
  private int numSongs;
  private String eventId;
  private Song song;

  public ArcGraph(String eventId, Song song)
  {
    this.eventId = eventId;
    this.song = song;
    colorList = new ArrayList<Integer>();
  }

  public void generateColors(float arcAlpha)
  {
    //random color generator
    int segments = 180/numSongs;
    for (int i = 0; i < numSongs; i++)
    {    
      float hue = i * segments;
      color c = color(hue, 50, 100, arcAlpha);
      colorList.add(c);
    }
  }



  public void drawArcs(float x, float y, float sWeight, color circC, color arcC, String songId)
  {
    //    String eventId = "1";

    //total audio and number of songs
    int totalAudioLength = 0;
    numSongs = 1; 
    
    for (int i = 1; i < song.SelectAllByEvent(eventId).size() - 1; i ++)
    { 
      totalAudioLength += Integer.valueOf(song.SelectAllByEvent(eventId).get(i).SongLength);
      numSongs += 1;
    }
    

//    generateColors(arcAlpha);
    

    //arc drawing algo with mouse over
    float startArc = radians(272.5);
    float totalArcLength = radians(175);
    float start = startArc;
    for (int i = 1; i < song.SelectAllByEvent(eventId).size() - 1; i ++)
    {
      strokeWeight(0);
      strokeCap(SQUARE);
      String currSong = song.SelectAllByEvent(eventId).get(i).SongId;
      if (currSong.equals(songId))
      {      
        strokeWeight(sWeight);
      }

//      stroke(colorList.get(i));
      stroke(arcC);
      float songLength = Float.valueOf(song.SelectAllByEvent(eventId).get(i).SongLength);
      float percentOfWhole = songLength/totalAudioLength; 
      float arcPercent = totalArcLength * percentOfWhole;
      float end = start + arcPercent;

      arc(x, y, 300 * 0.75, 300 * 0.75, start, end);
      noStroke();
      fill(circC);
      ellipse(x, y, 300 * 0.75, 300 * 0.75);

      start = end;
    }
  }
}
