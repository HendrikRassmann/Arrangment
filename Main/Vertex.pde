import java.util.*;

class Vertex implements Cloneable {
  private float x; // x-Koordinate
  private float y; // y-Koordinate
  private Edge incidentEdge; // eine inzidente Kante
  private String name; // der Name

  /* Eine Iteratorklasse, welche die inzidenten Kanten einer
   Ecke zyklisch durchläuft
   */
  private class VertexEdgeIterator implements Iterator {
    // wir verwenden einen internen Iterator
    Iterator iter;

    /* es wird zunächst eine Liste von den inzidenten Kanten angelegt 
     und dann iteriert
     */
    public VertexEdgeIterator() {
      // der Vector, der die Kantern speichert
      Vector edges = new Vector();
      // alle Kanten hinzufügen
      Edge e = incidentEdge;
      do {
        edges.add(e);
        e = (e.getTwin()).getNext();
      } while (e != incidentEdge);
      // den Iterator merken
      iter = edges.iterator();
    }

    // alles durchreichen
    public boolean hasNext() {
      return iter.hasNext();
    }

    public Object next() {
      return iter.next();
    }

    // gibt es nicht
    public void remove() {
      throw new UnsupportedOperationException();
    }
  }
  public Vertex(){
   dcel.vertices.add(this); 
  }
  // die Kanten durchlaufen
  public Iterator traverseEdges() {
    return new VertexEdgeIterator();
  }

  // getter/setter-Methoden

  public Edge getIncidentEdge() {
    return incidentEdge;
  }

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
    void show(){
      fill(255,0,0);
   circle((float)x,(float)y,10); 
  }
}
