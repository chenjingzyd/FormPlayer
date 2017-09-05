class DrawTriangle{
  int x, y;
  int w, h;
  int randomGray;
  boolean selected = false;
  int me;
  DrawTriangle[] others;
  
  DrawTriangle(int xp, int yp, int ws, int hs,  int c, int m, DrawTriangle[] o){
    x =xp;
    y = yp;
    w = ws;
    h = hs;
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
   int x1 =  x;
   int y1 = (int)(y - 0.5*h);
   int x2 = (int)(x1 - 0.5*w);
   int y2 = y1+h;
   int x3 = x2 + w;
   int y3 = y2;
   triangle(x1, y1, x2, y2, x3, y3);

 }
 
 void update(int mx, int my, int pmx, int pmy){

   if(selected && mousePressed){
     if( (mx != pmx) || (my != pmy)){
       //constrains
       int x1 = (int) (width/2 - 200 + w/2);
       int y1 = (int) (height/2 - 200 + h/2);
       int x2 = (int) (width/2 + 200 - w/2);
       int y2 = (int) (height/2 + 200 - h/2); 
       
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