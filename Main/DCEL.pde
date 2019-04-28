public class DCEL { //<>//

  float dist2Edge = 0;
  ArrayList<Vertex> vertices = new ArrayList<Vertex>();
  ArrayList<Face> faces = new ArrayList<Face>();
  ArrayList<Edge> edges = new ArrayList<Edge>();

  Vertex upLeft, upRight, downRight, downLeft;
  Edge up, right, down, left;
  Face in, out;

  public Vertex createVertex(String name, float x, float y) {
    Vertex result = new Vertex();
    result.setName(name); 
    result.setX(x); 
    result.setY(y);
    println("created Vertex: " + name);
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
  public void connect1sided(Edge e, Edge f) {
    e.setNext(f); 
    f.setPrev(e);
  }
  public void createExample() {
    println("example createtd!");
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

    in = createFace("Inside", up/*, null*/);
    out = createFace("Outside", up.getTwin()/*, null*/);
  }

  public float distEdgeVertex(Edge e, Vertex vertex) {
    PVector v = new PVector (e.getOrigin().getX(), e.getOrigin().getY()); //NPX
    PVector w = new PVector (e.getTwin().getOrigin().getX(), e.getTwin().getOrigin().getY()); 
    PVector p = new PVector(vertex.getX(), vertex.getY()); 
    float l2 = PVector.sub(v, w).magSq();
    if (l2 == 0) {
      return 0;
    }
    float t = max(0, min(1, PVector.sub(p, v).dot(PVector.sub(w, v) ) / l2 ));
    PVector projection = PVector.add(v, /*+*/ (PVector.sub(w, v).mult(t)));
    return p.dist(projection);
  }
  public float distEdgeXY(Edge e, float setX, float setY) {

    Vertex dummyVertex = new Vertex();
    dummyVertex.setX(setX);
    dummyVertex.setY(setY);
    float result = distEdgeVertex(e, dummyVertex);
    //hinterher dummy entfernen, das nicht vergessen
    dcel.vertices.remove(dummyVertex);
    return result;
  }

  public boolean toTheLeft(Edge e, Vertex vertex) {
    //return ((b.X - a.X)*(c.Y - a.Y) - (b.Y - a.Y)*(c.X - a.X)) > 0;

    return ((e.getDest().getX() - e.getOrigin().getX())*(vertex.getY() - e.getOrigin().getY()) - (e.getDest().getY() - e.getOrigin().getY())*(vertex.getX() - e.getOrigin().getX() )) >= 0;
  }

  public Face createFace(String name, Edge outer/*, Edge inner*/) {
    //my implementation:
    Face result = new Face();


    result.setName(name);
    result.setOuterComponent(outer);
    Edge pointer = outer;
    do {

      pointer.setIncidentFace(result);
      pointer = pointer.getNext();
    } while (pointer != outer);
    /*
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
     */
    return result;
  }



  public void adjFace(Face f, Edge e) {
    System.out.println(f.getName() + " ist über " + e.getName() + " mit " + 
      f.getAdjacentFace(e).getName() + " verbunden.");
  }
  public void splitEdge(Edge e) {

    Vertex vertexInTheMiddle = new Vertex();
    vertexInTheMiddle.setX( (e.getOrigin().getX() + e.getTwin().getOrigin().getX()) / 2);
    vertexInTheMiddle.setY( (e.getOrigin().getY() + e.getTwin().getOrigin().getY()) / 2);

    Edge firstHalf = createEdge(e.getName() + " first Half ", e.getOrigin(), vertexInTheMiddle);
    Edge secondHalf = createEdge(e.getName() + " second Half ", vertexInTheMiddle, e.getTwin().getOrigin());

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
  }
}
