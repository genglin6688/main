ArrayList<SimpleNote>note=new ArrayList<SimpleNote>();
ArrayList<SimpleNote>tempnote=new ArrayList<SimpleNote>();
ArrayList<SimpleNote>searchnote=new ArrayList<SimpleNote>();
ArrayList<ImportantNote>importantNote= new ArrayList<ImportantNote>();
IntList noteNumber=new IntList();
IntList pareI=new IntList();
IntList pareS=new IntList();
boolean added=false;
boolean press=false;
PImage closedTrash;
PImage openTrash;
boolean trash=false;
String page="home";
String []data;
String []save;
boolean seeNumber_KeyFunction=false;
boolean seeNumber_Activate=false;
boolean seeNumber_active=false;
int section=0;
String searchText="";
PImage search;
boolean searchHighlight=false;
boolean importantNoteToggle=false;
int importantNoteToggleR=0;
int importantNoteToggleG=0;
int importantNoteToggleB=0;
int rgbHighlight=0;
boolean searchTextChanged=false;
void settings() {
  size(1000, 1000);
}

void setup() {
  background(255);
  closedTrash=loadImage("closedTrash.png");
  closedTrash.resize(100, 100);
  openTrash=loadImage("openTrash.png");
  openTrash.resize(100, 100);
  search=loadImage("search.png");
  search.resize(50, 50);
  data=loadStrings("data.txt");
  for (int i=0; i<data.length; i++) {
    String dataSplit[]=split(data[i], "\t");
    if (dataSplit[0].equals("importantNote")) {
      importantNote.add(new ImportantNote(data[i]));
    } else {
 
      note.add(new SimpleNote(data[i]));
    }
  }
}

void draw() {
  if (page.equals("home")) {
    background(255);
    fill(0);
    textAlign(CENTER);
    textSize(50);
    text("Welcome", width/2, 200);
    fill(255);
    rect(width/2-100, 300, 200, 50);
    fill(0);
    textSize(30);
    text("graph", width/2, 333);
    fill(255);
    rect(width/2-100, 500, 200, 50);
    fill(0);
    textSize(30);
    text("list", width/2, 533);    
    fill(255);
    rect(width/2-100, 700, 200, 50);
    fill(0);
    textSize(30);
    text("settings", width/2, 733);
  }



  if (page.equals("noteGraphs")) {
    fill(255);
    background(255);
    stroke(170);
    strokeWeight(1);
    for (int i=0; i<1000; i+=20) {
      line(i, 0, i, 1000);
      line(0, i, 1000, i);
    }
    noStroke();
    rect(0, 0, 260, 1000);
    stroke(0);
    strokeWeight(4);
    line(260, 0, 260, 1000);
    rect(30, 30, 200, 260);
    rect(30, 50, 200, 40);
    rect(30, 340, 200, 50);
    textAlign(CENTER);
    textSize(30);
    fill(0);
    text("clear", 130, 383  );
    for (int i=0; i<note.size(); i++) {
      note.get(i).drawHeading();  
      note.get(i).drawTitle();  
      note.get(i).drawMain();
      note.get(i).newLine();
      note.get(i).dragOnGoing(mouseX, mouseY);
      note.get(i).showNumber();
    }
    for (int i=0; i<pareI.size(); i++) {
      int tempI=pareI.get(i)-1;
      int tempS=pareS.get(i)-1;
      importantNote.get(tempI).x=note.get(tempS).x;    
      importantNote.get(tempI).y=note.get(tempS).y;
    }
    for (int i=0; i<importantNote.size(); i++) {
      importantNote.get(i).display();
    }
    if (mouseX>=900&&mouseX<=1000&&mouseY>=900&&mouseY<=1000) {
      trash=true;
    } else {      
      trash=false;
    }
    if (trash) {    
      image(openTrash, 900, 900);
    } else {    
      image(closedTrash, 900, 900);
    }
    if (note.size()>0) {
      if (press) {
        note.get(note.size()-1).dragSample(mouseX, mouseY);
        if (importantNote.size()>0&&importantNoteToggle) {
          importantNote.get(importantNote.size()-1).dragSample(mouseX, mouseY);
        }
      }
    }
    save=new String[note.size()+importantNote.size()]; 
    for (int i=0; i<note.size(); i++) {

      String saveText=note.get(i).text.replace("\n", "");
      save[i]= note.get(i).title+"\t"+saveText+"\t"+str(note.get(i).x)+"\t"+str(note.get(i).y)+"\t"+str(note.get(i).noteNumber);
    }
    for (int i=0; i<importantNote.size(); i++) {
      save[i+note.size()]=("importantNote" +"\t"+str(importantNote.get(i).x)+"\t"+str(importantNote.get(i).y)+"\t"+str(importantNote.get(i).r)+"\t"+str(importantNote.get(i).g)+"\t"+str(importantNote.get(i).b));
    }

    saveStrings(dataPath("data.txt"), save);
    strokeWeight(1);
    fill(255);
    rect(0, 950, 100, 50);

    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("go back", 50, 975);
  }



  if (page.equals("noteLists")) {
    background(255);
    for (int i=0; i<5; i++) {
      fill(255);
      rect(width/2-400, 300+i*110, 800, 100);
      rect(width/2-400, 300+i*110, 150, 100);
      rect(width/2-250, 300+i*110, 200, 100);
    }
    if (searchText.equals("")) {
      for (int i=0+section*5; i<note.size()&&i<5+section*5; i++) {
        textAlign(CENTER, CENTER);
        textSize(30);
        fill(0);
        text(note.get(i).noteNumber, width/2-325, 350+(i%5)*110);
        text(note.get(i).title, width/2-150, 350+(i%5)*110);
        textSize(15);
        textAlign(CENTER, TOP);
        text(note.get(i).text, width/2+175, 325+(i%5)*110);
      }
      for (int i=0; i<note.size()/5+1; i++) {
        textSize(30);
        textAlign(CENTER, CENTER);
        fill(255);
        ellipse(200+i*100, 900, 50, 50);
        fill(0);
        text(str(i+1), 200+i*100, 900);
      }
    } else {      
      for (int i=0+section*5; i<searchnote.size()&&i<5+section*5; i++) {
        textAlign(CENTER, CENTER);
        textSize(30);
        fill(0);
        text(searchnote.get(i).noteNumber, width/2-325, 350+(i%5)*110);
        text(searchnote.get(i).title, width/2-150, 350+(i%5)*110);
        textSize(15);
        textAlign(CENTER, TOP);
        text(searchnote.get(i).text, width/2+175, 325+(i%5)*110);
      }
      for (int i=0; i<searchnote.size()/5+1; i++) {
        textSize(30);
        textAlign(CENTER, CENTER);
        fill(255);
        ellipse(200+i*100, 900, 50, 50);
        fill(0);
        text(str(i+1), 200+i*100, 900);
      }
    }

    fill(255);
    if (searchHighlight) {
      stroke(0, 0, 255);
    }
    rect(width/2-350, 100, 650, 50);
    stroke(0);
    rect(width/2+300, 100, 50, 50);
    rect(width/2-150, 200, 300, 50);
    fill(0);
    text("sort by note number", width/2, 225);
    imageMode(CENTER);
    image(search, width/2+325, 125);
    textAlign(LEFT, CENTER);
    fill(0);
    text(searchText, width/2-325, 125);
    fill(255);
    rect(0, 950, 100, 50);
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("go back", 50, 975);
  }
  if (page.equals("settings") ) {
    background(255);
    if (importantNoteToggle) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    rect(width/2-200, height/2, 400, 50);
    fill(importantNoteToggleR, importantNoteToggleG, importantNoteToggleB);
    rect(width/2-100, height/2+100, 200, 50);    
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("important note toggle", width/2, height/2+33);
    text("important note heading color", width/2, height/2+83);
    fill(255-importantNoteToggleR, 255-importantNoteToggleG, 255-importantNoteToggleB);
    text("current color", width/2, height/2+133);
    fill(255);
    strokeWeight(1);
    if (rgbHighlight==1) {
      strokeWeight(4);
    }
    rect(width/3-75, height/2+175, 150, 50);     
    strokeWeight(1);     
    if (rgbHighlight==2) {
      strokeWeight(4);
    }  
    rect(width/2-75, height/2+175, 150, 50);        
    strokeWeight(1); 
    if (rgbHighlight==3) {
      strokeWeight(4);
    }       

    rect((width/3*2)-75, height/2+175, 150, 50);    
    strokeWeight(1);
    fill(0);
    text(importantNoteToggleR, width/3, height/2+208);    
    text(importantNoteToggleG, width/2, height/2+208);    
    text(importantNoteToggleB, width/3*2, height/2+208);
    if (importantNoteToggleB==255&&importantNoteToggleG==255&&importantNoteToggleR==255) {
      fill(255, 0, 0);
      text("warning, your selected color is the same with none-important", width/2, height/2+275);
    }
    fill(255);
    rect(0, 950, 100, 50);
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("go back", 50, 975);
  }


  if (page.equals("clear?")) {
    background(0);
    fill(255);
    rect(width/2-200, height/2-150, 400, 300);
    rect(width/2-150, height/2+50, 100, 50);
    rect(width/2+50, height/2+50, 100, 50);
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(0);
    text("are you sure", width/2, height/2-100);
    textSize(30);
    text("yes", width/2-100, height/2+75);
    text("no", width/2+100, height/2+75);
  }
}

void mousePressed() {
  if (page.equals("noteGraphs")) {
    if (added==false&&mouseX<=230&&mouseX>=30&&mouseY<=290&&mouseY>=30) {
      if (importantNoteToggle==true) {
        importantNote.add(new ImportantNote(mouseX, mouseY, importantNoteToggleR, importantNoteToggleG, importantNoteToggleB));
        pareI.append(importantNote.size());
      } 
      note.add(new SimpleNote(mouseX, mouseY));
      pareS.append(note.size());
      added=true;
      press=true;
    }  
    for (int i=0; i<note.size(); i++) {
      if (note.get(i).seeNumber==false) {
        if (mouseX<=note.get(i).x+note.get(i).size/2&&mouseX>=note.get(i).x-note.get(i).size/2&&mouseY>=note.get(i).y&&mouseY<=note.get(i).y+260+note.get(i).extand) {
          note.add(new SimpleNote(note.get(i)));
          note.remove(i);
        }
      }
    }
    for (int i=0; i<note.size(); i++) {
      note.get(i).dragStart(mouseX, mouseY);
    }
  }
  if (page.equals("settings")) {
    if (mouseX<=width/3+75&&mouseX>=width/3-75&&mouseY<=height/2+225&&mouseY>=height/2+175) {
      rgbHighlight=1;
    } else if (mouseX<=width/2+75&&mouseX>=width/2-75&&mouseY<=height/2+225&&mouseY>=height/2+175) {
      rgbHighlight=2;
    } else if (mouseX<=(width/3*2)+75&&mouseX>=(width/3*2)-75&&mouseY<=height/2+225&&mouseY>=height/2+175) {
      rgbHighlight=3;
    } else {
      rgbHighlight=0;
    }
  }
}

void mouseReleased() {
  if (page.equals("home")) {
    if (mouseX<=width/2+100&&mouseX>=width/2-100&&mouseY<=350&&mouseY>=300) {
      page="noteGraphs";
    } else if (mouseX<=width/2+100&&mouseX>=width/2-100&&mouseY<=550&&mouseY>=500) {
      page="noteLists";
      for (int i=0; i<note.size(); i++) {
        noteNumber.append(note.get(i).noteNumber);
      }
    } else if (mouseX<=width/2+100&&mouseX>=width/2-100&&mouseY<=750&&mouseY>=700) {
      page="settings";
    }
  }
  if (page.equals("noteGraphs")) {
    boolean temp=false;
    for (int i=0; i<note.size(); i++) {
      int removed=0;
      if (note.get(i).x<360) {
        note.get(i).x=360;
      }
      //note.get(i).highlightTitle(mouseX, mouseY);
      //note.get(i).highlightText(mouseX, mouseY);
      note.get(i).highlight(mouseX, mouseY);

      if (note.get(i).seeNumber) {
        seeNumber_active=true;
        temp=true;
      }
      if (temp==false) {
        seeNumber_active=false;
      }
      if (seeNumber_active) {
        note.get(i).textHighlight=false;      
        note.get(i).titleHighlight=false;
      }
      if (mouseX<=note.get(i).x+note.get(i).size/2&&mouseX>=note.get(i).x-note.get(i).size/2&&mouseY>=note.get(i).y&&mouseY<=note.get(i).y+260+note.get(i).extand&&seeNumber_KeyFunction==true) {
        note.get(i).seeNumber=true;
        seeNumber_Activate=true;
      } else {
        note.get(i).seeNumber=false;
      }
      if (note.get(i).draging&&trash) {
        note.remove(i);
        removed=i;
      }
      if (note.size()!=removed) {
        note.get(i).dragEnd();
      }
    }
    added=false;
    press=false;
    if (mouseX<=100&&mouseY>=950) {
      page="home";
    }
    if (mouseX<=230&&mouseX>=30&&mouseY<=390&&mouseY>=340) {
      page="clear?";
    }
  }
  if (page.equals("noteLists")) {
    if (searchText.equals("")) {
      for (int i=0; i<note.size()/5+1; i++) {
        if (dist(mouseX, mouseY, 200+i*100, 900)<=50) {
          section=i;
        }
      }
    } else {      
      for (int i=0; i<searchnote.size()/5+1; i++) {
        if (dist(mouseX, mouseY, 200+i*100, 900)<=50) {
          section=i;
        }
      }
    }
    if (mouseX<=100&&mouseY>=950) {
      page="home";
    }
    if (mouseX<=width/2+300&&mouseX>=width/2-350&&mouseY<=150&&mouseY>=100) {
      searchHighlight=true;
    } else {
      searchHighlight=false;
    }
    if (mouseX<=650&&mouseX>=350&&mouseY<=250&&mouseY>=200) {
      noteNumber.sort();
      for (int i=0; i<noteNumber.size(); i++) {
        for (int n=0; n<note.size(); n++) {
          if (noteNumber.get(i)==note.get(n).noteNumber) {
            if (i<note.size()) {
              tempnote.add(note.get(i));
              note.set(i, note.get(n));
              note.set(n, tempnote.get(0));
              tempnote.remove(0);
            }
          }
        }
      }
    }
  }
  if (page.equals("settings")) {
    if (mouseX<=width/2+200&&mouseX>=width/2-200&&mouseY>height/2&&mouseY<height/2+50) {
      if (importantNoteToggle) {
        importantNoteToggle=false;
      } else {
        importantNoteToggle=true;
      }
    }  
    if (mouseX<=100&&mouseY>=950) {
      page="home";
    }
  }    




  if (page.equals("clear?")) {
    if (mouseX<=width/2-50&&mouseX>=width/2-150&&mouseY<=height/2+100&&mouseY>=height/2+50) {
      note.clear();
      page="noteGraphs";
    } else if (mouseX<=width/2+150&&mouseX>=width/2+50&&mouseY<=height/2+100&&mouseY>=height/2+50) {
      page="noteGraphs";
    }
  }
}
void keyPressed() {
  if (page.equals("noteGraphs")) {
    for (int i=0; i<note.size(); i++) {
      note.get(i).addTitle();
      note.get(i).addText();
      if (note.get(i).seeNumber==true&&key=='n'&&seeNumber_Activate==false) {
        note.get(i).seeNumber=false;
      }
      if (key>=48&&key<=57||key==BACKSPACE) {
        note.get(i).changeNumber();
      }
    }
    if (key=='n') {
      seeNumber_KeyFunction=true;
    }
  }
  if (page.equals("noteLists")) {
    if (searchHighlight) {
      if (key<=126&&key>=32||key==BACKSPACE||key==ENTER) {
        if (key==BACKSPACE) {
          if (searchText.length()>0) {
            searchText=searchText.substring(0, searchText.length()-1);          
            searchTextChanged=true;
          }
        } else {
          searchText+=key;
          searchTextChanged=true;
        }
        if (searchTextChanged) {
          for(int i=0;i<searchnote.size();i++){
          searchnote.remove(i);
          }
          for (int i=0; i<note.size(); i++) {
            if (note.get(i).title.indexOf(searchText)!=-1) {
              searchTextChanged=false;
              searchnote.add(note.get(i));
            }
          }
        }
      }
    }
  }
  if (page.equals("settings")) {
    String temp;
    if (rgbHighlight==1) {
      temp=str(importantNoteToggleR);
      if (key>=48&&key<=57||key==BACKSPACE) {
        temp+=key;
        if (temp.equals("")) {
          importantNoteToggleR=0;
        }
        importantNoteToggleR=int(temp);
        if (importantNoteToggleR>255) {
          temp="255";
          importantNoteToggleR=255;
        }
      }
    }    
    if (rgbHighlight==2) {
      temp=str(importantNoteToggleG);
      if (key>=48&&key<=57||key==BACKSPACE) {
        temp+=key;
        if (temp.equals("")) {
          importantNoteToggleG=0;
        }
        importantNoteToggleG=int(temp);
        if (importantNoteToggleG>255) {
          temp="255";
          importantNoteToggleG=255;
        }
      }
    }    
    if (rgbHighlight==3) {
      temp=str(importantNoteToggleB);
      if (key>=48&&key<=57||key==BACKSPACE) {
        temp+=key;


        if (temp.equals("")) {
          importantNoteToggleB=0;
        }
        importantNoteToggleB=int(temp);
        if (importantNoteToggleB>255) {
          temp="255";
          importantNoteToggleB=255;
        }
      }
    }
  }
}
void keyReleased() {
  if (page.equals("noteGraphs")) {
    for (int i=0; i<note.size(); i++) {
      note.get(i).titleFinish();
    }
    if (key=='n'&&seeNumber_KeyFunction) {
      seeNumber_KeyFunction=false;
    }
  }


  // polymorphsim
  if (key=='`') {
    SimpleNote[]noteDisplay=new SimpleNote[note.size()+importantNote.size()];
    for (int i=0; i<note.size(); i++) {
      noteDisplay[i]=note.get(i);
    }
    for (int i=0; i<importantNote.size(); i++) {
      noteDisplay[i+note.size()]=importantNote.get(i);
    }  
    for (SimpleNote i : noteDisplay) {
      println(i);
    }
  }
}