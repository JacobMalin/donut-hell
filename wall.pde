// wall.pde

class Wall {
  public Wall() {}
  
  void Draw() {
    color green = #009e49; // F
    color blue = #00188f; // B
    color orange = #ff8c00; // L
    color red = #e81123; // R
    color white = #ec008c; // U #ffffff // pink
    color yellow = #fff100; // D
    
    int wallWidth = 0;
    
    // draw six cubes surrounding the origin (front, back, left, right, top, bottom)
    fill( green );
    pushMatrix();
    translate( 0, 0, -wallLen/2 );
    box( wallLen, wallLen, wallWidth );
    popMatrix();
    
    fill( blue );
    pushMatrix();
    translate( 0, 0, wallLen/2 );
    box( wallLen, wallLen, wallWidth );
    popMatrix();
    
    fill( orange );
    pushMatrix();
    translate( -wallLen/2, 0, 0 );
    box( wallWidth, wallLen, wallLen );
    popMatrix();
    
    fill( red );
    pushMatrix();
    translate( wallLen/2, 0, 0 );
    box( wallWidth, wallLen, wallLen );
    popMatrix();
    
    fill( white );
    pushMatrix();
    translate( 0, -wallLen/2, 0 );
    box( wallLen, wallWidth, wallLen );
    popMatrix();
    
    fill( yellow );
    pushMatrix();
    translate( 0, wallLen/2, 0 );
    box( wallLen, wallWidth, wallLen );
    popMatrix();
  }
}
