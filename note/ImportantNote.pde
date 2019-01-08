class ImportantNote extends SimpleNote {
  int r, g, b;
  ImportantNote(int x, int y, int r, int g, int b) {
    super(x, y);
    this.r=r;
    this.g=g;
    this.b=b;
  }
  void display() {
    colorMode(RGB);
    fill(r, g, b);
    strokeWeight(4);
    rect(x-size/2, y, size, 20);
  }
  void update(){
  x=super.x;
  y=super.y;
  }
  
  
  public String toString(){
  return super.toString()+ ",  R,G,B:"+this.r+","+this.g+","+this.b;
  }
}