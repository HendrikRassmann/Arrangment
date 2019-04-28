class Edge implements Cloneable {
  private Vertex origin;
  private Edge twin;
  private Face incidentFace;
  private Edge next;
  private Edge prev;
  private String name = "noNameGiven";
  private int marked = 0;


  public Edge() {
    dcel.edges.add(this);
  }
  public Edge(String x) {
  }
  // Klone eine Kante
  public Object clone() {
    Edge e = new Edge();
    e.origin = origin;
    e.twin = twin;
    e.incidentFace = incidentFace;
    e.next = next;
    e.prev = prev;
    return e;
  }

  // getter/setter Methoden
  public void setMark(int setMark) {
    marked = setMark;
  }

  public Vertex getOrigin() {
    return origin;
  }

  public Edge getNext() {
    return next;
  }

  public Face getIncidentFace() {
    return incidentFace;
  }

  public Edge getTwin() {
    return twin;
  }

  public Edge getPrev() {
    return prev;
  }

  public String getName() {
    return name;
  }


  public void setIncidentFace(Face f) {
    this.incidentFace = f;
  }

  public void setTwin(Edge twin) {
    this.twin = twin;
  }

  public void setOrigin(Vertex origin) {
    this.origin = origin;
  }

  public void setNext(Edge next) {
    this.next = next;
  }

  public void setPrev(Edge prev) {
    this.prev = prev;
  }

  public void setName(String name) {
    this.name = name;
  }

  // hole den Endpunkt der Kante
  public Vertex getDest() {
    return twin.getOrigin();
  }

  // füge eine Ecke auf der Kante ein
  //die InsertFunktion muss ich auch nochmal selber machen:
  public void insertVertex(Vertex insertVertex) {
    Edge newEdge =  dcel.createEdge(this.name + "_R", insertVertex, this.getDest());
    //face nicht vergessen:
    newEdge.setIncidentFace(this.incidentFace);
    newEdge.getTwin().setIncidentFace(this.twin.getIncidentFace());
    this.name = name + "_L";
    this.twin.setName(name + "'");
    //verkabeln
    newEdge.setNext(next);
    this.next.setPrev(newEdge);
    this.next.setNext(newEdge.getTwin());
    newEdge.getTwin().setPrev(next.getTwin());
    this.next = newEdge;
    newEdge.setPrev(this);
    this.twin.setPrev(newEdge.getTwin());
    newEdge.getTwin().setNext(this.twin);
  }
  /*
  public Edge insertVertex(Vertex r) {    
   // die neue Kante
   Edge k = (Edge)this.clone();
   Edge kt = (Edge)this.twin.clone();
   k.setTwin(kt); 
   kt.setTwin(k);
   // für die bessere Lesbarkeit
   Vertex p = this.origin;
   Vertex q = this.twin.origin;
   // die Punkte verzeigern
   q.setIncidentEdge(kt);
   r.setIncidentEdge(k);
   // die Anfangspunkte setzen
   k.setOrigin(r);
   this.getTwin().setOrigin(r);
   // die Kanten verzeigern
   this.getNext().setPrev(k);
   this.getTwin().getPrev().setNext(kt);
   k.setPrev(this);
   this.setNext(k);
   kt.setNext(this.getTwin());
   this.getTwin().setPrev(kt);  
   // Facetten setzen
   k.setIncidentFace(this.getIncidentFace());
   kt.setIncidentFace(this.getTwin().getIncidentFace());
   return k;
   }*/

  public String toString() {      
    show();
    return name + " Origin: " + origin.getName() + " Twin: " + twin.getName() + 
      " Next: " + next.getName() + " Prev: " + prev.getName() + " Face: " + ""
    /*incidentFace.getName()*/      ;
  }
  public void show() {
    //println("drawing edge: " + name);
    line(origin.getX(), origin.getY(), twin.getOrigin().getX(), twin.getOrigin().getY()); //NPX
    origin.show();
    twin.getOrigin().show();
  }
  public void unmark() {
    if (marked != 0) {
      marked = 0;
      twin.unmark();
      next.unmark();
      prev.unmark();
    }
  }
  void showGraph() {
    if (marked == 0) {
      println("drawing : " + name);
      marked = 1;
      show();
      twin.showGraph();
      prev.showGraph();//NPX
      next.showGraph();
    }
  }

  boolean boundingBoxIntersects(Edge otherEdge) {
    //bounding Box check
    //alle drüber
    //alle rechts
    //alle links
    //all drunter
    return false;
  }
}
