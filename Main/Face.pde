class Face implements Cloneable {
    private Edge outerComponent; // der äußere Rand
    private Vector innerComponents = new Vector(); // die inneren Ränder
    private String name; // der Name

    /*
      Klone die Facette, der Vector wird geklont, aber nicht seine Inhalte
    */
    
    public Face(){
     dcel.faces.add(this); 
    }
    public Object clone() {
  Face f = new Face();
  f.outerComponent = this.outerComponent;
  f.innerComponents = new Vector(this.innerComponents.size());
  Iterator it = this.innerComponents.iterator();
  while (it.hasNext()) {
      f.innerComponents.add(it.next());
  }
  return f;
    }

    /* Iteratorklasse zum Iteriereren über die Flächen */
    private class FaceEdgeIterator implements Iterator {
  Iterator iter;

  /* Füge den Rand, der start enthält, zu vect hinzu */
  private void addEdges(Edge start, Vector vect) {
      if (start == null)
    return;
      Edge dummy = start; 
      vect.add(dummy);
      while(dummy.getNext() != start) {
    dummy = dummy.getNext();
    vect.add(dummy);
      }
  }

  /* Im Konstruktor werden alle Kanten eingefügt
   */
  public FaceEdgeIterator() {
      Vector edges = new Vector();
      addEdges(outerComponent, edges);
      Iterator inner = innerComponents.iterator();
      while (inner.hasNext()) {
    Edge e = (Edge)inner.next();
    addEdges(e, edges);
      } 
      iter = edges.iterator();
  }

  // Operationen durchreichen
  public boolean hasNext() {
      return iter.hasNext();
  }

  public Object next() {
      return iter.next();
  }

  public void remove() {
      throw new UnsupportedOperationException();
  }
    }

    // Iterator für die Ecken holen
    public Iterator traverseEdges() {
  return new FaceEdgeIterator();
    }

    // getter/setter-Methoden
    public Edge getOuterComponent() {
  return outerComponent;
    }

    public Vector getInnerComponents() {
  return innerComponents;
    }

    public String getName() {
  return name;
    }

    public void setOuterComponent(Edge e) {
  this.outerComponent = e;
    }

    public void setInnerComponents(Vector v) {
  innerComponents = v;
    }

    public void setName(String name) {
  this.name = name;
    }

    // die angrenzende Fläche holen
    public Face getAdjacentFace(Edge e) {
  if (e.getIncidentFace() != this)
      throw new IllegalArgumentException();
  return (e.getTwin()).getIncidentFace();
    }

    /*
      füge eine Kante ein. Als Parameter werden die Kanten übergeben, die
      im Start-, bzw. Endpunkt der neuen Kante beginnen. Dies habe ich so
      gemacht, da mir kein besserer Weg eingefallen ist, wie man sonst 
      die Vor- und Nachfolgerkanten ermitteln kann, ohne die Facette bzw.
      die Nachbarn der beiden Ecken zu durchlaufen, wodurch die geforderte
      Laufzeit nicht mehr gewährleistet wäre.
    */
    // p = Kante, die aus dem Anfangspunkt herausgeht
    // q = Kante, die aus dem Endpunkt herausgeht
    public Face insertEdge(Edge p, Edge q) {
  if (p.getIncidentFace() != this || q.getIncidentFace() != this)
      throw new IllegalArgumentException();
  // die neue Facette
  Face f2 = (Face)this.clone();
  // die neuen Kanten erzeugen
  Edge k = new Edge();
  Edge kt = new Edge();
  // die Kanten sind Zwillinge
  k.setTwin(kt);
  kt.setTwin(k);
  // die Anfangspunkte setzen
  k.setOrigin(p.getOrigin());
  kt.setOrigin(q.getOrigin());
  // k verzeigern
  k.setNext(q);
  k.setPrev(p.getPrev());
  // k' verzeigern
  kt.setNext(p);
  kt.setPrev(q.getPrev());
  // die inzidenten Kanten anpassen
  q.getPrev().setNext(kt);
  p.getPrev().setNext(k);
  p.setPrev(kt);
  q.setPrev(k);
  // die kleinere Facette suchen
  Edge dummy1 = k.getNext();
  Edge dummy2 = kt.getNext();
  while (dummy1 != k && dummy2 != kt) {
      dummy1 = dummy1.getNext();
      dummy2 = dummy2.getNext();
  }
  if (dummy1 == k) {
      // die Fläche von k ist die kleinere
      this.setOuterComponent(kt);
      kt.setIncidentFace(this);
      f2.setOuterComponent(k);
  } else {// die Fläche von kt ist die kleinere
      this.setOuterComponent(k);
      k.setIncidentFace(this);
      f2.setOuterComponent(kt);
  }
  // die inzidente Facette setzen
  Iterator it = f2.traverseEdges();
  while (it.hasNext()) {
      Edge e = (Edge)it.next();
      e.setIncidentFace(f2);
  }
  return f2;
    }

    public String toString() {
  return "Facette " + name + " " + outerComponent + " " + innerComponents;
    }
}
