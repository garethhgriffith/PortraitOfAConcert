public class TimeConverter
{
  public String convertMsToMinSecs(int millis)
  {
    if (millis < 0)
    {
      throw new IllegalArgumentException("Duration must be greater than zero!");
    }
    long minutes = TimeUnit.MILLISECONDS.toMinutes(millis);
    millis -= TimeUnit.MINUTES.toMillis(minutes);
    long seconds = TimeUnit.MILLISECONDS.toSeconds(millis);

    StringBuilder sb = new StringBuilder(64);  
    sb.append(minutes);
    sb.append(":");
    if (seconds < 10)
    {
      sb.append("0");
      sb.append(seconds);
    }
    else
    {    
      sb.append(seconds);
    }

    return(sb.toString());
  }
}
