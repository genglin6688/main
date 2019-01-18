//this class this used to store the notes info

/**
 * @author      Allen Geng <idontgetthis @imbadatcoding.com>
 * @version     1.6              
 * @since       1.0        
 */

class SimpleNote {
  public  String title="";
  public String text="";
  private boolean titleHighlight=false;
  private boolean textHighlight=false;
  public int x, y;
  private int noteNumber;
  public int size=200;
  private float extand=0;
  private boolean lineAdded=false;
  private boolean draging=false;
  private boolean seeNumber=false;
  /**
   * adding a new note
   * @param txt the text that you get from the file
   */
  public SimpleNote(String txt) {
    String []splitedTxt=split(txt, "\t");
    title=splitedTxt[0];
    text=splitedTxt[1];
    x=int(splitedTxt[2]);
    y=int(splitedTxt[3]);
    noteNumber=int(splitedTxt[4]);
    if (text.length()/15>0) {
      String temp="";
      for (int i=1; i<=text.length()/15; i++) {
        temp+=text.substring((i-1)*15, i*15);
        temp+="\n";
      }
      text=temp;
    }
  } 
  /**
   * adding a new note
   * @param x the x value of the SimpleNote   
   * @param y the y value of the SimpleNote
   */
  public  SimpleNote( int x, int y) {
    this.x=x;
    this.y=y;
    noteNumber=-1;
  }
  /**
   * adding a new note
   * @param a another SimpleNote
   */
  public SimpleNote(SimpleNote a) {
    this.x=a.x;
    this.y=a.y;
    this.titleHighlight=a.titleHighlight;
    this.textHighlight=a.textHighlight;
    this.title=a.title;
    this.text=a.text;
    this.extand=a.extand;
    this.draging=a.draging;
    this.noteNumber=a.noteNumber;
  }
  /**
   * draging the note when the note is new created
   * @param x the x value of the SimpleNote   
   * @param y the y value of the SimpleNote
   */
  public void dragSample(int x, int y) {
    this.x=x;
    this.y=y;
  }
  /**
   * drawing the heading out for the note
   */
  public void drawHeading() {    
    fill(255);
    strokeWeight(4);
    rect(x-size/2, y, size, 20);
  }
  /**
   * drawing the title out for the note
   */
  public void drawTitle() {
    if (seeNumber==false) {
      fill(255);
      strokeWeight(4);
      rect(x-size/2, y+20, size, 40);
      textAlign(CENTER);
      textSize(25);
      //textFont(font);
      fill(0);
      text(title, x, y+45);
    }
  }
  /**
   * return function
   * @return returns back a string that is the title
   */
  public String getTitle() {
    return title;
  }  /**
   * drawing the main rect and text out for the note
   */
  public void drawMain() {
    if (seeNumber==false) {
      fill(255);
      strokeWeight(4);
      rect(x-size/2, y+60, size, extand+200);
      fill(0);
      textAlign(CENTER);
      textSize(15);
      //textFont(font);
      String sub=text+"l";
      if (millis()%1000<500&&textHighlight) {
        text(sub, x, y+85);
      } else {
        text(text, x, y+85);
      }
    }
  }
  /**
   * adding the new input key into the text
   * also does the extention of the rect 
   */
  public void addText() {
    if (seeNumber==false) {
      String []lines=text.split("\n");
      if ((key>=32&&key<=126)&&textHighlight) {
        text+=key;
      }

      if (key==ENTER) {
        text+="\n";
      }

      if (lines.length>=8) {
        extand=(lines.length-7)*24.3;
      }
      lineAdded=false;

      if (key==BACKSPACE&&text.length()>0&&textHighlight) {
        text=text.substring(0, text.length()-1);
        lineAdded=true;
        if (lines.length>=8) {
          extand=(lines.length-7)*24.3;
        }
      }
    }
  }
  /**
   * adding the new input key into the title
   */

  public void addTitle() {    
    if (seeNumber==false) {
      if (key>=32&&key<=126&&titleHighlight&&title.length()<15) {
        title+=key;
      }
      if (key==BACKSPACE&&title.length()>0&&titleHighlight) {
        title=title.substring(0, title.length()-1);
      }
    }
  }
  /**
   * when you press enter while you're inputing title it jumps to inputing text
   */
  public void titleFinish() {
    if (key==ENTER&&titleHighlight) {
      titleHighlight=false;
      textHighlight=true;
    }
  }
  /**
   * when you click on somewhere in the text box it highlights the text bar
   * @param x the x value of the mouse   
   * @param y the y value of the mouse
   */
  public void highlight( int x, int y) {
    if (seeNumber==false) {
      if (x<=this.x+size/2&&x>=this.x-size/2&&y<=this.y+260+extand&&y>=this.y+60) {
        textHighlight=true;
        titleHighlight=false;
      } else if (x<=this.x+size/2&&x>=this.x-size/2&&y<=this.y+60&&y>=this.y+20) {
        textHighlight=false;
        titleHighlight=true;
      } else {      
        textHighlight=false;
        titleHighlight=false;
      }
    }
  }
  /**
   * detects and adds new line to the text box when character count goes up to limit
   */
  public void newLine() {
    String []breaked=text.split("\n");
    if (breaked.length!=0) {
      if (breaked[breaked.length-1].length()>=15&&lineAdded==false) {
        text+="\n";
        lineAdded=true;
      }
    }
  } 
  /**
   * when you click on the header of the note the note starts draging according to your mouse location
   * @param x the x value of the mouse   
   * @param y the y value of the mouse
   */
  public void dragStart(int x, int y) {
    if (x<=this.x+this.size/2&&x>=this.x-this.size/2&&y<=this.y+20&&y>=this.y) {
      draging=true;
    }
  }  
  /**
   * the draging is going on and the note will follow your mouse
   * @param x the x value of the mouse   
   * @param y the y value of the mouse
   */
  public void dragOnGoing(int x, int y) {
    if (draging) {
      this.x=x;
      this.y=y;
    }
  }
  /**
   * the dragging ends and if it is out of the proper location it goes back
   */
  public void dragEnd() {
    if (this.x>900) {
      this.x=900;
    }
    if (this.y<0) {
      y=0;
    }
    if (this.y>950) {
      y=950;
    }
    draging=false;
  }
  /**
   * shows the note number
   */
  public  void showNumber() {
    if (seeNumber) {
      fill(255);
      rect(x-size/2, y, size, extand+260);
      fill(0);
      textSize(30);
      textAlign(CENTER, CENTER);
      text(noteNumber, x, y+extand/2+130);
    }
  }  
  /**
   * changes the note numbert
   */
  public void changeNumber() {
    if (seeNumber) {
      if (noteNumber==-1) {
        noteNumber=0;
      }
      String strNumber=str(noteNumber);
      strNumber+=key;
      noteNumber=int(strNumber);
    }
  }
  /**
   * returns this class's info
   * @return string
   */
  public String toString() {
    return this.x+","+this.y+"  "+ this.title+" "+this.text+" : "+this.noteNumber;
  }
}