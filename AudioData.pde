class AudioData
{
  String Utc;
  float Volume;
  String SongId;

  public ArrayList<AudioData> SelectAllBySong(String SongId)
  {      
    ArrayList<AudioData> audio = new ArrayList<AudioData>();

    Table table = loadTable("audio.csv");

    for (TableRow row : table.rows()) 
    {
      
      AudioData audioData = new AudioData();

      if (row.getString(2).equals(SongId))
      {
        audioData.Utc = row.getString(0);
//        float vol = map(row.getFloat(1), 0, 190, 100, 150); 
        audioData.Volume = map(row.getFloat(1), 0, 488, 350, 500);
//        audioData.Volume = row.getFloat(1);

        audioData.SongId = row.getString(2);

        audio.add(audioData);
      }
    }

    return audio;
  }

  public int GetAudioSongLength(String SongId)
  {
    Table table = loadTable("audio.csv");
    int songLength = 0;

    for (TableRow row : table.rows())
    {
      AudioData audioData = new AudioData();

      if (row.getString(2).equals(SongId))
      {
        songLength++;
      }
    }
    return songLength;
  }


  public int GetAudioLength(ArrayList<Song> songs)
  {
    int audioLength = 0;
    for (Song s : songs)
    {
      audioLength += SelectAllBySong(s.SongId).size();
    }    

    return audioLength;
  }
}
