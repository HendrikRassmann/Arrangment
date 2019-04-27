class Vertex {
 float x = 0;
 float y = 0;
 String name;
 HalfEdge IncidentEdge;
 
 int marked = 0;
 //mit Vertex als Origin 
 
  
 Vertex(float setX, float setY, String setName){
   x = setX;
   y = setY;
   name = setName;

  }
  Vertex(){
    
  }
  void unmark(){
    print("Vertex unmarked!");
   marked = 0; 
  }
  void show(){
   
   if(marked == 0)
   { 
   fill(0);
   textSize(25);
   text(name,x,y-30);
   fill(255);
   strokeWeight(3);
   fill(255,0,0);
   
   strokeWeight(1);
   circle(x,y,20); 
   marked = 1;
   }
  }
  float getX(){
   return x; 
  }
  float getY(){
   return y; 
  }
  
}
