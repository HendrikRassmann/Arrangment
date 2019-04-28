import java.util.*; //<>//

class Vertex implements Cloneable {
  private float x; // x-Koordinate
  private float y; // y-Koordinate
  private Edge incidentEdge; // eine inzidente Kante
  private String name = "NoNameGiven"; // der Name

  public Vertex() {
    dcel.vertices.add(this);
  }
  public ArrayList<Edge> getEdges() {
    ArrayList<Edge> edgesOfVertex = new ArrayList<Edge>();

    Edge e = incidentEdge;
    do {
      edgesOfVertex.add(e);
      e = (e.getTwin()).getNext();
    } while (e != incidentEdge);

    return edgesOfVertex;
  }
  public ArrayList<Edge> getOutgoingEdges() {
    ArrayList<Edge> edgesOfVertex = new ArrayList<Edge>();

    Edge e = incidentEdge;
    do {
      edgesOfVertex.add(e);
      e = (e.getTwin()).getNext();
    } while (e != incidentEdge);

    return edgesOfVertex;
  }
  public ArrayList<Edge> getIncomingEdges() {
    ArrayList<Edge> edgesOfVertex = new ArrayList<Edge>();

    Edge e = incidentEdge.getTwin();
    do {
      edgesOfVertex.add(e);
      e = (e.getTwin()).getNext();
    } while (e != incidentEdge.getTwin());

    return edgesOfVertex;
  }

  // getter/setter-Methoden
  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public String getName() {
    return name;
  }

  public void setIncidentEdge(Edge e) {
    incidentEdge = e;
  }
    public Edge getIncidentEdge() {
    return incidentEdge;
  }

  public void setX(float x) {
    this.x = x;
  }

  public void setY(float y) {
    this.y = y;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String toString() {
    return "Punkt " + name + "(" + x + " ," + y + ") " + incidentEdge.getName();
  }
  void show() {
    fill(255, 0, 0);
    circle((float)x, (float)y, 10);
  }
}
