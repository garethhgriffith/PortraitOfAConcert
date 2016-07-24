class Song
{
  String SongId;
  String Name;
  String SongLength; 
  String SongFileName;
  String EventId;

  public ArrayList<Song> SelectAllByEvent(String EventId)
  {      
    ArrayList<Song> songs = new ArrayList<Song>();

    Table table = loadTable("song.csv");

    for (TableRow row : table.rows()) {   

      Song v = new Song();

      if (row.getString(4).equals(EventId))
      {
        v.SongId = row.getString(0);
        v.Name = row.getString(1);
        v.SongLength = row.getString(2);
        v.SongFileName = row.getString(3);
        v.EventId = row.getString(4);

        songs.add(v);
      }
    }

    return songs;
  }

  public int GetNumberOfSongs(ArrayList<Song> songs)
  {
    int numSongs = 0;
    for (Song s : songs)
    {
      numSongs ++;
    }    

    return numSongs;
  }
}
