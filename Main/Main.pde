DCEL dcel;
void setup() {
  size(640, 640); 
  background(227); 
  dcel = new DCEL();
  dcel.setGraphUp();
  println("Vertecies insgesamt: " + dcel.vertices.size());
  println("Edges insgesamt: " + dcel.edges.size());
}

void draw() {
  //println(mouseX + " : " + mouseY);
}
void keyPressed() {
  //key stores key
  background(227);
  println("key pressed");
  dcel.up.getNext().insertVertex(dcel.createVertex(mouseX + ":" + mouseY, mouseX, mouseY));
  dcel.up.unmark();
  dcel.up.showGraph();
  println("Vertecies insgesamt: " + dcel.vertices.size());
  println("Edges insgesamt: " + dcel.edges.size());
  /*dcel.splitEdge(dcel.up.getNext());
   dcel.up.unmark();
   dcel.up.showGraph();
   */
}
