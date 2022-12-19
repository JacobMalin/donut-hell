// wall.pde

class Wall {
  MenuCamera m;
  
  public Wall(MenuCamera m) {
    this.m = m;
  }
  
  void Draw() {
    float wallWidth = 0;
    
    if (scene == 0) {
      // draw six cubes surrounding the origin (front, back, left, right, top, bottom)
      if ((m.theta % (2*PI)) < 1.824 || (m.theta % (2*PI)) > 4.459) {
        fill( wallColors[2] );
        pushMatrix();
        translate( 0, 0, -wallLen/2 );
        box( wallLen, wallLen, wallWidth );
        popMatrix();
      }
      
      if (!((m.theta % (2*PI)) < 1.318 || (m.theta % (2*PI)) > 4.965)) {
        fill( wallColors[2] );
        pushMatrix();
        translate( 0, 0, wallLen/2 );
        box( wallLen, wallLen, wallWidth );
        popMatrix();
      }
      
      if ((m.theta % (2*PI)) < 3.394 || (m.theta % (2*PI)) > 6.030) {
        fill( wallColors[0] );
        pushMatrix();
        translate( -wallLen/2, 0, 0 );
        box( wallWidth, wallLen, wallLen );
        popMatrix();
      }
      
      if ((m.theta % (2*PI)) < 0.253 || (m.theta % (2*PI)) > 2.889) {
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
