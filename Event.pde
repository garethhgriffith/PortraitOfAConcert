

public class Event
{
  String EventId;
  String EventName;
  String Name;
  String Venue;
  String Date;
  String Image;


  public ArrayList<Event> SelectAll()
  {      
    ArrayList<Event> events = new ArrayList<Event>();

    Table table = loadTable("event.csv");

    for (TableRow row : table.rows()) 
    {
      Event b = new Event();

      b.EventId = row.getString(0);
      b.EventName = row.getString(1);
      b.Name = row.getString(2);
      b.Venue = row.getString(3);
      b.Date = row.getString(4);
      b.Image = row.getString(5);

      events.add(b);
    }

    return events;
  }


  public Event SelectOneByName(String EventName)
  {
    Table table = loadTable("event.csv");

    for (TableRow row : table.rows()) 
    {
      if (row.getString(1).equals(EventName))
      {
        Event b = new Event();

        b.EventId = row.getString(0);
        b.EventName = row.getString(1);
        b.Name = row.getString(2);
        b.Venue = row.getString(3);
        b.Date = row.getString(4);
        b.Image = row.getString(5);

        return b;
      }
    }

    return null;
  }
}
