class SimpleNote {
  public  String title="";
  public String text=" ";
  public PFont font;
  private boolean titleHighlight=false;
  private boolean textHighlight=false;
  public int x, y;
  private int noteNumber;
  public int size=200;
  private float extand=0;
  private boolean lineAdded=false;
  private boolean draging=false;
  private boolean seeNumber=false;
  public SimpleNote(String s) {
    String []splited=split(s, "/t");
    title=splited[0];
    text=splited[1];
    x=int(splited[2]);
    y=int(splited[3]);
    noteNumber=int(splited[4]);
  }
  public  SimpleNote( int x, int y) {
    this.x=x;
    this.y=y;
    noteNumber=-1;
  }
  SimpleNote(SimpleNote a) {
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
  public void dragSample(int x, int y) {
    this.x=x;
    this.y=y;
  }

  public void drawHeading() {    
    fill(255);
    strokeWeight(4);
    rect(x-size/2, y, size, 20);
  }
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
  public String getTitle() {
    return title;
  }
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

  public void addText() {
    if (seeNumber==false) {
      String []lines=text.split("\n");
      if ((key>=32&&key<=126||key==ENTER)&&textHighlight) {
        text+=key;
        if (key==ENTER) {
          text+=" ";
        }
        if (lines.length>=8) {
          extand=(lines.length-7)*24.3;
        }
        lineAdded=false;
      }
      if (key==BACKSPACE&&text.length()>0&&textHighlight) {
        text=text.substring(0, text.length()-1);
        if (lines.length>=8) {
          extand=(lines.length-7)*24.3;
        }
      }
    }
  }
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
  public void titleFinish() {
    if (key==ENTER&&titleHighlight) {
      titleHighlight=false;
      textHighlight=true;
    }
  }

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
  public void extantion() {
    String []breaked=text.split("\n");
    if (breaked.length!=0) {
      if (breaked[breaked.length-1].length()>=15&&lineAdded==false) {
        text+=ENTER;
        lineAdded=true;
      }
    }
  }
  public void dragStart(int x, int y) {
    if (x<=this.x+this.size/2&&x>=this.x-this.size/2&&y<=this.y+20&&y>=this.y) {
      draging=true;
    }
  }
  public void dragOnGoing(int x, int y) {
    if (draging) {
      this.x=x;
      this.y=y;
    }
  }
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

  void showNumber() {
    if (seeNumber) {
      fill(255);
      rect(x-size/2, y, size, extand+260);
      fill(0);
      textSize(30);
      textAlign(CENTER, CENTER);
      text(noteNumber, x, y+extand/2+130);
    }
  }
  void changeNumber() {
    if (seeNumber) {
      if (noteNumber==-1) {
        noteNumber=0;
      }
      String strNumber=str(noteNumber);
      strNumber+=key;
      noteNumber=int(strNumber);
    }
  }

  public String toString() {
    return this.x+","+this.y+"  "+ this.title+" "+this.text+" : "+this.noteNumber;
  }
}