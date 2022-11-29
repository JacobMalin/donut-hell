// wall.pde

class Wall {
  public Wall() {}
  
  void Draw() {
    color green = #009b48; // F
    color blue = #004680; // B
    color orange = #ff5800; // L
    color red = #b41234; // R
    color white = #ffffff; // U
    color yellow = #ffd500; // D
    
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
