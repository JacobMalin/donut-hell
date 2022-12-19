// wall.pde

class Wall {
  MenuCamera m;
  
  public Wall(MenuCamera m) {
    this.m = m;
  }
  
  void Draw() {
    int wallWidth = 0;
    
    if (scene == 0) {
      // draw six cubes surrounding the origin (front, back, left, right, top, bottom)
      if ((m.theta % (2*PI)) < 1.83 || (m.theta % (2*PI)) > 4.453) {
        fill( wallColors[2] );
        pushMatrix();
        translate( 0, 0, -wallLen/2 );
        box( wallLen, wallLen, wallWidth );
        popMatrix();
      }
      
      if (!((m.theta % (2*PI)) < 1.33 || (m.theta % (2*PI)) > 4.95)) {
        fill( wallColors[2] );
        pushMatrix();
        translate( 0, 0, wallLen/2 );
        box( wallLen, wallLen, wallWidth );
        popMatrix();
      }
      
      if ((m.theta % (2*PI)) < 3.40 || (m.theta % (2*PI)) > 6.04) {
        fill( wallColors[0] );
        pushMatrix();
        translate( -wallLen/2, 0, 0 );
        box( wallWidth, wallLen, wallLen );
        popMatrix();
      }
      
      if ((m.theta % (2*PI)) < 0.25 || (m.theta % (2*PI)) > 2.90) {
        fill( wallColors[0] );
        pushMatrix();
        translate( wallLen/2, 0, 0 );
        box( wallWidth, wallLen, wallLen );
        popMatrix();
      }
      
      // No top
      
      fill( wallColors[1] );
      pushMatrix();
      translate( 0, wallLen/2, 0 );
      box( wallLen, wallWidth, wallLen );
      popMatrix();
    } else {
      // draw six cubes surrounding the origin (front, back, left, right, top, bottom)
      fill( wallColors[2] );
      pushMatrix();
      translate( 0, 0, -wallLen/2 );
      box( wallLen, wallLen, wallWidth );
      popMatrix();
      
      fill( wallColors[2] );
      pushMatrix();
      translate( 0, 0, wallLen/2 );
      box( wallLen, wallLen, wallWidth );
      popMatrix();
      
      fill( wallColors[0] );
      pushMatrix();
      translate( -wallLen/2, 0, 0 );
      box( wallWidth, wallLen, wallLen );
      popMatrix();
      
      fill( wallColors[0] );
      pushMatrix();
      translate( wallLen/2, 0, 0 );
      box( wallWidth, wallLen, wallLen );
      popMatrix();
      
      fill( wallColors[1] );
      pushMatrix();
      translate( 0, -wallLen/2, 0 );
      box( wallLen, wallWidth, wallLen );
      popMatrix();
      
      fill( wallColors[1] );
      pushMatrix();
      translate( 0, wallLen/2, 0 );
      box( wallLen, wallWidth, wallLen );
      popMatrix();
    }
  }
}
