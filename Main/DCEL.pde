public class DCEL {

  float dist2Edge = 10;
  Vector vertices = new Vector();
  Vector faces = new Vector();
  Vector edges = new Vector();
  //Oder Einfach den Vector durchgehen
  //der Vector wird dann halt irgendwie nicht upgedatet;
  //der vektor wird gar nicht benutzt
  // Alles zur Erzeugung des Beispiels, siehe Bild

  Vertex upLeft, upRight, downRight, downLeft;
  Edge up, right, down, left;
  Face in, out;
  
  
  Vertex a, b, c, d, e, f, g, h;
  Edge ea, eb, ec, ed, ee, ef, eg, eh, ei;
  Edge eat, ebt, ect, edt, eet, eft, egt, eht, eit;
  Face fa, fb, fc, fd;

  public Vertex createVertex(String name, float x, float y) {
    Vertex result = new Vertex();
    result.setName(name); 
    result.setX(x); 
    result.setY(y);
    return result;
  }

  public Edge createEdge(String name, Vertex origin, Vertex dest) {
    Edge result = new Edge();
    Edge twin = new Edge();
    origin.setIncidentEdge(result);
    dest.setIncidentEdge(twin); //NP X
    result.setName(name); 
    twin.setName(name+"'");
    result.setTwin(twin); 
    twin.setTwin(result);
    result.setOrigin(origin); 
    twin.setOrigin(dest);
    return result;
  }

  public void connect(Edge e, Edge f) {
    e.setNext(f); 
    f.setPrev(e);
    f.twin.setNext(e.twin);
    e.twin.setPrev(f.twin);
  }

  public Face createFace(String name, Edge outer, Edge inner) {
    Face result = new Face();
    result.setName(name);
    result.setOuterComponent(outer);
    if (outer != null) {
      Edge dummy = outer;
      do {
        dummy.setIncidentFace(result);
        dummy = dummy.getNext();
      } while (dummy != outer);
    }
    if (inner != null) {
      Vector v = result.getInnerComponents();
      v.add(inner);
      Edge dummy = inner;
      do {
        dummy.setIncidentFace(result);
        dummy = dummy.getNext();
      } while (dummy != inner);
    }
    return result;
  }

  public void createExample() {
    upLeft = createVertex("UpLeft", dist2Edge, dist2Edge);
    upRight = createVertex("UpRight", 640 - dist2Edge, dist2Edge);
    downRight = createVertex("downRight", 640 - dist2Edge, 640 - dist2Edge);
    downLeft = createVertex("downLeft", dist2Edge, 640 - dist2Edge);

    up = createEdge("up", upLeft, upRight);
    right = createEdge("right", upRight, downRight);
    down = createEdge("down", downRight, downLeft);
    left = createEdge("left", downLeft, upLeft);


    connect(up, right);
    connect(right, down);
    connect(down, left);
    connect(left, up);
    
    in = createFace("Inside", up, null);

  }

  public void traverseFace(Face f) {
    System.out.println("Traversiere " + f);
    Iterator it = f.traverseEdges();
    while (it.hasNext()) {
      System.out.println("\t"+it.next());
    }
  }

  public void traverseVertex(Vertex v) {
    System.out.println("Traversiere " + v);
    Iterator it = v.traverseEdges();
    while (it.hasNext()) {
      System.out.println("\t"+it.next());
    }
  }

  public void adjFace(Face f, Edge e) {
    System.out.println(f.getName() + " ist über " + e.getName() + " mit " + 
      f.getAdjacentFace(e).getName() + " verbunden.");
  }
  public void splitEdge(Edge e){
   //später mit wert in der mitte
   
    Vertex vertexInTheMiddle = new Vertex();
    vertexInTheMiddle.setX( (e.getOrigin().getX() + e.getTwin().getOrigin().getX()) / 2);
    vertexInTheMiddle.setY( (e.getOrigin().getY() + e.getTwin().getOrigin().getY()) / 2);
    
    Edge firstHalf = createEdge(e.getName() + " first Half ",e.getOrigin(),vertexInTheMiddle);
    Edge secondHalf = createEdge(e.getName() + " second Half ",vertexInTheMiddle, e.getTwin().getOrigin());
    
    //firstHalf abarbeiten:
    firstHalf.setPrev(e.getPrev());
    firstHalf.setNext(secondHalf);
    secondHalf.setPrev(firstHalf);
    secondHalf.setNext(e.getNext());
    e.getPrev().setNext(firstHalf);
    Edge twinTMP = e.getTwin();
    secondHalf.getNext().setPrev(secondHalf);
    //damit ist e tot, 
    //halben twins verbinden:
    secondHalf.getTwin().setNext(firstHalf.getTwin());
    firstHalf.getTwin().setPrev(secondHalf.getTwin());
    firstHalf.getTwin().setNext(twinTMP.getNext());
    twinTMP.getNext().setPrev(firstHalf.getTwin());
    secondHalf.getTwin().setPrev(twinTMP.getPrev());
    twinTMP.getPrev().setNext(secondHalf.getTwin());
    
  }
  public void setGraphUp() {
    createExample();
    up.unmark();
    up.showGraph();
    /*
    traverseFace(fa);
     traverseFace(fc);
     traverseVertex(c);
     traverseVertex(d);
     adjFace(fa, ect);
     adjFace(fd, eg);
     System.out.println("neuer Punkt auf c");
     Vertex v = new Vertex(); 
     v.setName("neuer Punkt");
     ec.insertVertex(v);
     traverseFace(fb);
     traverseFace(fa);
     System.out.println("neue Kante in D");
     Face f = fd.insertEdge(ef, eh);
     f.setName("neue Facette");
     traverseFace(fd);
     traverseFace(f);
     */
  }
}
