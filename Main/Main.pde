int dim = 640;

//Bounding Box
Vertex UpLeft = new Vertex(10,10,"UpLeft");
Vertex UpRight = new Vertex(dim-10,10,"UpRight");
Vertex DownLeft = new Vertex(10,dim-10,"DownLeft");
Vertex DownRight = new Vertex(dim-10,dim-10,"DownRight");

HalfEdge Top;


Vertex v1 = new Vertex(dim*0.5, dim*0.9,"v1");
Vertex v2 = new Vertex(dim*0.1, dim*0.8,"v2");
Vertex v3 = new Vertex(dim*0.5, dim*0.5,"v3");
Vertex v4 = new Vertex(dim*0.9, dim*0.6,"v4");
Vertex v5 = new Vertex(dim*0.8, dim*0.1,"v5");

void setup(){
 size(640,640); 
  background(200); 
  
  Top = new HalfEdge(UpLeft,UpRight);
  Top.setNext(DownRight);  
  drawGraph();
 }


void draw(){
  
}

void drawGraph(){
  Top.unmark();
  Top.show();
}
