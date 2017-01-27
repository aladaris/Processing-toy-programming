import java.util.*;

class AStar<T extends HexAStarNode, B extends Board>{
  List<T> openSet;  // TODO: Used a sortedList to avoid sorting on each insertion
  List<T> closedSet;
  T start;
  T current;
  T end;
  List<T> path;
  B board;
  boolean finished;
  
  public AStar(final T start, final T end, final B board) {
    
    // TODO: Keep openSet sorted by ¿f_score?
    
    this.openSet = new ArrayList<T>();
    this.closedSet = new ArrayList<T>();
    this.start = start;
    this.current = null;
    this.end = end;
    this.board = board;
    this.finished = false;
    
    this.start.cellColor = color(225, 10, 10);
    this.end.cellColor = color(10, 10, 225);
    
    this.openSet.add(start);
    sortOpenSet();
  }

  public void advanceStep(){
    if (!finished){
      if (openSet.size() > 0){
        
        if (path != null){
          for (T node : path){
            node.cellColor = color(255, 5, 5);
          }
        }
        
        current = openSet.get(0);
        
        // Finished?
        if (current == end){
          println("A*: Done!");
          finished = true;
        }
        
        openSet.remove(current);
        closedSet.add(current);
        current.cellColor = color(254, 10, 255);
        
        // Check all the neighbors
        //for (T nbour : current.neighbours){
        for (int i = 0; i < current.neighbours.size(); i++){
          T nbour = (T)current.neighbours.get(i);
          // Valid next node?
          if (!closedSet.contains(nbour) && !current.isWallBetweenCell(nbour)){
            double temp_g_score = current.g_score + heuristic_euclidean(current, nbour);
            
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
              sortOpenSet();
              nbour.cellColor = color(5, 255, 5);
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
      }
    }  // If not finishied

  }
  
  public void paintPath(){
    if (path.size() > 0){
      for (T node : path){
        node.cellColor = color(254, 10, 255);
      }
    }
  }
  
  private float heuristic_euclidean(T n1, T n2){
    return n1.getDistance(n2);
  }
  
  private void sortOpenSet(){
    Collections.sort(openSet, new Comparator<T>() {
        @Override
        public int compare(T n2, T n1) {
          return new Float(heuristic_euclidean(n2, end)).compareTo(heuristic_euclidean(n1, end));
        }
    });
  }

}