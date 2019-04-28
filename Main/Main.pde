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

  if (key == 'i') {

    String vertexName = mouseX + ":" + mouseY ;
    int xDist = min(mouseX, width - mouseX);
    int yDist = min(mouseY, height - mouseY);

    float insertX;
    float insertY;


    if (xDist < yDist) {
      //am linken oder rechten rand:
      //am linken rand
      insertY = mouseY;
      if (xDist == mouseX) {
        insertX = 0;
      } else {
        insertX = width;
      }
    } else {
      insertX = mouseX; 
      if (yDist == mouseY) {
        insertY = 0;
      } else {
        insertY = width;
      }
    }
    Vertex insertVertex = dcel.createVertex(vertexName, insertX, insertY);

    float closest = (width+height)*(width+height);
    Edge nearestEdge = new Edge("defintevly initialysed!!");
    for (Edge e : dcel.edges) {
      if (dcel.distEdgeVertex(e, insertVertex) < closest) {
        closest = dcel.distEdgeVertex(e, insertVertex);
        nearestEdge = e;
      }
    }  

    nearestEdge.insertVertex(insertVertex);

    //schon zwei eingefügt?

    if (dcel.vertices.size() %2 == 0 ) {

      Vertex secondLast = dcel.vertices.get(dcel.vertices.size()-2);
      Vertex last = dcel.vertices.get(dcel.vertices.size()-1);

      Edge edgeInnerSide = secondLast.getIncidentEdge();
      Edge edgeInnerSide2 = last.getIncidentEdge();
      if (edgeInnerSide2.getIncidentFace() == dcel.out) {
        edgeInnerSide = edgeInnerSide.getTwin();
      }
      if (edgeInnerSide2.getIncidentFace() == dcel.out) {
        edgeInnerSide2 = edgeInnerSide2.getTwin();
      }
      Face face1 = edgeInnerSide.getIncidentFace();
      Face face2 = edgeInnerSide2.getIncidentFace();

      //edgeInnerSide.getIncidentFace().insertEdge(edgeInnerSide,edgeInnerSide2);//NPX
      //die Berliner, funktioniert aber nicht so ganz

      Edge newEdge = dcel.createEdge(secondLast.getName() + "-" + last.getName(), last, secondLast);


      dcel.connect1sided(edgeInnerSide.getPrev(), newEdge);
      dcel.connect1sided(edgeInnerSide2.getPrev(), newEdge.getTwin());
      dcel.connect1sided(newEdge.getTwin(), edgeInnerSide);
      dcel.connect1sided(newEdge,edgeInnerSide2);

      //andere SEite verdrahten
      //dcel.connect1sided(newEdge.getTwin(),edgeInnerSide2.getPrev());
      //dcel.connect1sided(newEdge,edgeInnerSide2);
    }



    background(227);
    dcel.up.unmark();

    dcel.up.showGraph();
    //for (Edge e : dcel.edges) e.show();
    println("number of HalfEdges: " + dcel.edges.size());
  }
}
