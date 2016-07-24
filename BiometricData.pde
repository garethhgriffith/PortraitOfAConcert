class BiometricData
{
  int Utc;
  String Time;
  float Gsr;
  float HeartRate;
  float SkinTemp;
  float Steps;
  int SongId;


  public ArrayList<BiometricData> SelectAllBySong(String SongId)
  {      
    ArrayList<BiometricData> bioData = new ArrayList<BiometricData>();

    Table table = loadTable("bio.csv");

    for (TableRow row : table.rows()) {   

      BiometricData bio = new BiometricData();

      if (row.getString(6).equals(SongId))
      {
        bio.Utc = row.getInt(0);
        bio.Time = row.getString(1);

        float gsrNorm  = norm(row.getFloat(2), 0.0, 13);
        float gsrPow = pow(gsrNorm, 0.1);
        //        floor(gsrPow);
        gsrPow *= 400;
        //        println(gsrPow);
        bio.Gsr = map(gsrPow, 145, 400, 175, 250);
        //        bio.Gsr = map(row.getFloat(2), 0, 12.7, 200, 300);

        //        float gsr;
        //        if (row.getFloat(2) > 1)
        //        {
        //          gsr = map(row.getFloat(2), 0, 12.7, 200, 300);
        //        }
        //        else
        //        {
        //          float gsrNorm  = norm(row.getFloat(2), 0.0, 100);
        //          gsr = pow(gsrNorm, 0.1);
        //          floor(gsr);
        //          gsr *= 600;
        //          bio.Gsr = gsr;
        //        }
        //        bio.Gsr = gsr;


        bio.HeartRate = map(row.getFloat(3), 51, 118, 200, 275);

        bio.SkinTemp = map(row.getFloat(4), 84, 96, 250, 400);
        bio.Steps = row.getFloat(5);
        bio.SongId = row.getInt(6);

        bioData.add(bio);
      }
    }

    return bioData;
  }

  public int GetSongBioLength(String SongId)
  {
    Table table = loadTable("bio.csv");
    int songLength = 0;

    for (TableRow row : table.rows())
    {
      BiometricData bio = new BiometricData();

      if (row.getString(6).equals(SongId))
      {
        songLength++;
      }
    }
    return songLength;
  }


  public int GetTotalBioLength(ArrayList<Song> songs)
  {
    int bioLength = 0;
    for (Song s : songs)
    {
      bioLength += SelectAllBySong(s.SongId).size();
    }    

    return bioLength;
  }
}
