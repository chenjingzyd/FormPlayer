import gifAnimation.*;
import processing.opengl.*;
GifMaker gifExport;
PImage slice;

PImage info;

int sliceNum = 1;

int savedSliceNum = 0;
int rectangleNum;
int circleNum;
int triangleNum;

boolean selectedStates[] = new boolean[5];


DrawRectangle[] myRectangles;
DrawCircle[] myCircles;
DrawTriangle[] myTriangles;

int randomOffset = 50;


void setup() {
  
  background(243,243,243);
  fullScreen(JAVA2D);
  noStroke();
  colorMode(HSB);
  smooth();
  frameRate(24);
  
  
  // info
  info = loadImage("info.jpg");
  
  slice = createImage(400, 400, HSB);
  
  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(256);

  
  rectangleNum = floor(random(0, 5));
  triangleNum = floor( random (5 - rectangleNum));
  circleNum = 5 - rectangleNum - triangleNum;
  
  
  myRectangles = new DrawRectangle[rectangleNum];
  myCircles = new DrawCircle[circleNum];
  myTriangles = new DrawTriangle[triangleNum];

  

  if(rectangleNum != 0){
    for(int i = 0; i< rectangleNum; i++){
      myRectangles[i] = new DrawRectangle((int)(width/2 + random(randomOffset)), (int)(height/2 - random(randomOffset)), (int)random(2, 100), (int)random(2, 100),  (int)random(250), i, myRectangles);
    }
  }
  
  if(circleNum != 0){
      for(int i = 0; i< circleNum; i++){
      myCircles[i] = new DrawCircle((int)(width/2 - random(randomOffset)), (int)(height/2 - random(randomOffset)), (int)random(6, 100),  (int)random(250), i, myCircles );
    }
  }
      
  if(triangleNum != 0){
      for(int i = 0; i< triangleNum; i++){
      myTriangles[i] = new DrawTriangle((int)(width/2 - random(randomOffset)), (int)(height/2+random(randomOffset)), (int)random(6, 80), (int)random(6, 80),  (int)random(250), i, myTriangles );
    }    
  }
     

}




void draw() {
  
  fill(255);
  rectMode(CENTER);
  rect(width/2, height/2, 400, 400);
  
  // draw info
  image(info, 30, height - 100);
      
  //Draw Shapes
  if(rectangleNum != 0){
    for(int i = 0; i< rectangleNum; i++){
      myRectangles[i].display(); 
    }
    
    for(int i = 0; i< rectangleNum; i++){ 
       selectedStates[i] =  myRectangles[i].selected;        
       if (myRectangles[i].press(mouseX, mouseY)){
          myRectangles[i].update(mouseX, mouseY, pmouseX, pmouseY);
        }   
      
      } 
  }
  
  if(circleNum != 0){
     for(int i = 0; i< circleNum; i++){
        myCircles[i].display(); 
     }
     
     for(int i = 0; i< circleNum; i++){     
       selectedStates[rectangleNum+i] =  myCircles[i].selected;        
       if (myCircles[i].press(mouseX, mouseY)){
          myCircles[i].update(mouseX, mouseY, pmouseX, pmouseY);
        }         
      } 
  }
    
  if(triangleNum != 0){
      for(int i = 0; i< triangleNum; i++){
        myTriangles[i].display(); 
      }
      
      for(int i = 0; i< triangleNum; i++){     
     selectedStates[rectangleNum+circleNum+i] =  myTriangles[i].selected;
      
     if (myTriangles[i].press(mouseX, mouseY)){
        myTriangles[i].update(mouseX, mouseY, pmouseX, pmouseY);
      }   
    
    } 
   }
  

  if(!selectedStates[0] && !selectedStates[1] && !selectedStates[2] && !selectedStates[3] && !selectedStates[4] ){
     cursor(ARROW);
   }else{
     cursor(HAND);
   }
}

void keyPressed() {
  if (key == ' ') {
    
  rectangleNum = floor(random(0, 5));
  triangleNum = floor( random (5 - rectangleNum));
  circleNum = 5 - rectangleNum - triangleNum;
   
    
    
    myRectangles = new DrawRectangle[rectangleNum];
    myCircles = new DrawCircle[circleNum];
    myTriangles = new DrawTriangle[triangleNum];
  
     
    if(triangleNum != 0){
        for(int i = 0; i< triangleNum; i++){
        myTriangles[i] = new DrawTriangle((int)(width/2 - random(randomOffset)), (int)(height/2+random(randomOffset)), (int)random(6, 80), (int)random(6, 80),  (int)random(250), i, myTriangles );
      }    
    }
    if(rectangleNum != 0){
      for(int i = 0; i< rectangleNum; i++){
        myRectangles[i] = new DrawRectangle((int)(width/2 + random(randomOffset)), (int)(height/2-random(randomOffset)), (int)random(2, 100), (int)random(2, 100),  (int)random(250), i, myRectangles);
      }
    }
    
    if(circleNum != 0){
        for(int i = 0; i< circleNum; i++){
        myCircles[i] = new DrawCircle((int)(width/2 - random(randomOffset)), (int)(height/2-random(randomOffset)), (int)random(6, 100),  (int)random(250), i, myCircles );
      }
    }
        
    
        
  }
 
  if (key == 's' || key == 'S' ) {
    captureAndSave(width/2-200, height/2-200, 400, 400 );
  }
  
  if (key == ESC){
      gifExport.finish();
      println("gif saved");
  }
  
}

void captureAndSave(int x, int y, int w, int h){
  slice = get(x, y, w, h);
  slice.save("slice" + nf(sliceNum, 4) + ".gif");
  PImage savedImag = loadImage("slice" + nf(sliceNum, 4) + ".gif");
  gifExport.addFrame(savedImag); 
  sliceNum++;
  println("saved!");
 
}