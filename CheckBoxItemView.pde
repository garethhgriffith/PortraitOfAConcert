// -------------------------------------------------------------------------
/**
 *
 * This class edits the display method from ControllerView so
 * that icons can be set for the toggled checkboxes while also
 * retaining the text labels assigned when using .addItem
 *
 * @author Gareth Griffith
 * @version (2013.12.4)
 */
public class CheckBoxItemView implements ControllerView<Toggle> 
{
  PImage t1;
  PImage t2;

  public CheckBoxItemView(String imageOne, String imageTwo)
  {
    t1 = loadImage(imageOne);
    t2 = loadImage(imageTwo);
  }
  /**
   *
   *  This function controlls the state of the checkbox when it is clicked
   *  and the checkbox label.
   *
   */
  public void display(PApplet p, Toggle t) {
    if (t.getState()) {
      p.image(t1, 0, 0);
    } 
    else {
      p.image(t2, 0, 0);
    }
    fill(50);
    t.getCaptionLabel().draw(p, 0, 0, t);
  }
}
