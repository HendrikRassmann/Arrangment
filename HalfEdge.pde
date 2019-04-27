class HalfEdge extends Edge{

  HalfEdge Twin;

  Face IncidentFace;
  // in fahrtrichtung links

  Vertex Origin;
  //destination == Twin.origen

  Edge Prev = new Compositum();
  Edge Next = new Compositum();

  int marked = 0;

  void show() {
    if (marked == 0) {
      marked = 1;

      strokeWeight(10);
      line(Origin.getX(), Origin.getY(), Twin.getOrigin().getX(), Twin.getOrigin().getY());
      

        Next.show();
        Prev.show();
        Origin.show();
    }
  }

  Vertex getOrigin() {
    return Origin;
  }

  HalfEdge(Vertex setOrigin, Vertex setDestination) {
    Origin = setOrigin;
    Twin = new HalfEdge(setDestination, this);
  }
  HalfEdge(Vertex setOrigin, HalfEdge setTwin) {
    Origin = setOrigin;
    Twin = setTwin;
  }
  void setPrev(HalfEdge setPrev) {
    Prev = setPrev;
  }
  /* void setNext(HalfEdge setNext){
   Next = setNext; 
   }
   */
  void setNext(Vertex setNext) {
    Next = new HalfEdge(Twin.getOrigin(), setNext);
  }
  void setPrev(Vertex setPrev) {
    Prev = new HalfEdge(setPrev, Origin);
  }
  void unmark() {
    print("unmarking");
    if (marked != 0) {
      marked = 0;
      Origin.unmark();
      Twin.unmark();
      Next.unmark();
      Prev.unmark();
    }
  }
}
