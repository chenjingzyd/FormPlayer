class DrawCircle{
  int x, y;
  int w;
  int randomGray;
  boolean selected = false;
  int me;
  DrawCircle[] others;
  
  DrawCircle(int xp, int yp, int ws, int c, int m, DrawCircle[] o){
    x =xp;
    y = yp;
    w = ws;
    randomGray = c;
    me = m;
    others = o;  
  }
  
  boolean press(int mx, int my){
    if( (brightness(get(mx,my))) == (brightness(randomGray)) ){
      selected = true;
      return true;
    }else{
      selected = false;
      return false; 
    }
  }
  
 void display(){
   
   noStroke();
   fill(0, 0, randomGray);
   ellipseMode(CENTER);
   ellipse(x, y, w, w);

 }
 
 void update(int mx, int my, int pmx, int pmy){

   if(selected && mousePressed){
     if( (mx != pmx) || (my != pmy)){
       //constrains
       int x1 = (int) (width/2 - 200 + w/2);
       int y1 = (int) (height/2 - 200 + w/2);
       int x2 = (int) (width/2 + 200 - w/2);
       int y2 = (int) (height/2 + 200 - w/2); 
       
       int tempx = x + (mx-pmx);
       int tempy = y + (my-pmy);
         
       if( tempx > x1 && tempx < x2 && tempy > y1 && tempy < y2 ){
         x =  tempx;
         y =  tempy;
       }                   
     }
   }
   
 }
}