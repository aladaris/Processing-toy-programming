import java.util.*;

class AStar<T extends HexAStarNode, B extends Board>{
  TreeSet<T> openSet;  // TODO: Used a sortedList to avoid sorting on each insertion
  List<T> closedSet;
  T start;
  T current;
  T end;
  List<T> path;
  B board;
  boolean finished;
  
  final color CELL_COLOR_START  = color(255, 120, 255);
  final color CELL_COLOR_END    = color(255, 120, 255);  
  final color CELL_COLOR_OPEN   = color(10, 255, 10);
  final color CELL_COLOR_CLOSED = color(255, 10, 10);
  final color CELL_COLOR_PATH   = color(33, 55, 200);
  
  public AStar(final T start, final T end, final B board) {
    
    // TODO: Keep openSet sorted by ¿f_score?
    
    this.openSet = new TreeSet<T>(new Comparator<T>(){
      @Override
      public int compare(T n2, T n1) {
        return new Float(heuristic_euclidean(n2, end)).compareTo(heuristic_euclidean(n1, end));
        //return new Float(n2.h_score).compareTo(n1.h_score);
      }
    });
    this.closedSet = new ArrayList<T>();
    this.start = start;
    this.current = null;
    this.end = end;
    this.path = new ArrayList<T>();
    this.board = board;
    this.finished = false;
    
    this.start.cellColor = color(225, 10, 10);
    this.end.cellColor = color(10, 10, 225);
    
    this.openSet.add(start);
    //sortOpenSet();
  }

  public void advanceStep(){
    if (!finished){
      if (openSet.size() > 0){

        setPathColor(CELL_COLOR_CLOSED);

        current = openSet.pollFirst();
        
        // Finished?
        if (current == end){
          println("A*: Done!");
          finished = true;
          setPathColor(CELL_COLOR_PATH);
          this.start.cellColor = CELL_COLOR_START;
          this.end.cellColor = CELL_COLOR_END;
          return;
        }
        
        //openSet.remove(current);
        closedSet.add(current);
        //current.cellColor = CELL_COLOR_CLOSED;
        
        // Check all the neighbors
        //for (T nbour : current.neighbours){
        for (int i = 0; i < current.neighbours.size(); i++){
          T nbour = (T)current.neighbours.get(i);
          // Valid next node?
          if (!closedSet.contains(nbour) && !current.isWallBetweenCell(nbour)){
            float temp_g_score = current.g_score + heuristic_euclidean(current, nbour);
            
            // Is this a better path than before?
            boolean newPath = false;
            if (openSet.contains(nbour)){
              if (temp_g_score < nbour.g_score){
                nbour.g_score = temp_g_score;
                newPath = true;
              }
            } else {
              nbour.g_score = temp_g_score;
              newPath = true;
              openSet.add(nbour);
              //sortOpenSet();
              nbour.cellColor = CELL_COLOR_OPEN;
            }
            
            // Yes, it's a better path
            if (newPath) {
              nbour.h_score = heuristic_euclidean(nbour, end);
              nbour.f_score = nbour.g_score + nbour.h_score;
              nbour.cameFrom = current;
            }
          }
        }
        
      } else {  // No solution
        println("A*: No solution");
        finished = true;
        return;
      }
      
      // Find the path by working backwards
      path = new ArrayList<T>();
      T tempNode = current;
      path.add(tempNode);
      while(tempNode.cameFrom != null){
        path.add((T)tempNode.cameFrom);
        tempNode = (T)tempNode.cameFrom;
        tempNode.cellColor = CELL_COLOR_PATH;
      }
    }  // If not finishied
  }
  
  public void setPathColor(final color c){
    if (path != null){
      for (T node : path){
        node.cellColor = c;
      }
    }
  }
  
  private float heuristic_euclidean(T n1, T n2){
    return n1.getDistance(n2);
  }
  /*
  private void sortOpenSet(){
    Collections.sort(openSet, new Comparator<T>() {
        @Override
        public int compare(T n2, T n1) {
          //return new Float(heuristic_euclidean(n2, end)).compareTo(heuristic_euclidean(n1, end));
          return new Float(n2.h_score).compareTo(n1.h_score);
        }
    });
  }
  */

}