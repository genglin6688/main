//this class this used to store the importantNotes info, a extended class from SimpleNote

/**
 * @author      Allen Geng <idontgetthis @imbadatcoding.com>
 * @version     1.6              
 * @since       1.5        
 */


class ImportantNote extends SimpleNote {

  public int r, g, b;
  
  
  
  
  /**
   * adding a new note
   * @param x the x value of the importantNote   
   * @param y the y value of the importantNote  
   * @param r the r value of color of the importantNote  
   * @param g the g value of color of the importantNote 
   * @param b the b value of color of the importantNote
   */
  
  ImportantNote(int x, int y, int r, int g, int b) {
  
    super(x, y);
    
    this.r=r;
    
    this.g=g;
    
    this.b=b;
  }   

  
  
  
  /**
   * adding a new note
   * @param s the text that you get from the file
   */
 public ImportantNote(String s) {
    
    super(s);
    
    String splited[]=split(s, "\t");
    
    this.x=int(splited[1]);
    
    this.y=int(splited[2]);
    
    this.r=int(splited[3]);  
    
    this.g=int(splited[4]);  
    
    this.b=int(splited[5]);
  } 
  
  
  
  
  
  /**
   * showing the importantNote header
   */
  public  void display() {
    
    colorMode(RGB);
    
    fill(r, g, b);
    
    strokeWeight(4);
    
    rect(x-size/2, y, size, 20);
  } 
  
 
  
  /**
   * updates the header with the position of the SimpleNote
   */
  public  void update() {
  
    x=super.x;
    
    y=super.y;
  }




  /**
   * returns this class's info
   * @return string
   */
  public String toString() {

    return super.toString()+ ",  R,G,B:"+this.r+","+this.g+","+this.b;
  }
}