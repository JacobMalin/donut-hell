// bar.pde

class Bar {
  color stoneBlue = #72848e;
  color yellow = #ffde34;
  color green = #918f45;
  
  Player p;

  public Bar(Player p) {
    this.p = p;
  }
  
  void Draw() {
    float theta2 = p.theta + PI / 2;
    float phi2 = p.phi + PI / 2;
    Vec4 forwardDir = new Vec4( sin( phi2 ) * cos( theta2 ),    cos( phi2 ),    -sin( phi2 ) * sin ( theta2 ),    0 );
    Vec4 upDir      = new Vec4( sin( p.phi ) * cos( theta2 ),   cos( p.phi ),   -sin( theta2 ) * sin ( p.phi ),   0 );
    Vec4 rightDir   = new Vec4( cos( p.theta ),                 0,              -sin( p.theta ),                  0 );
    
    
    Vec4 mainPos = new Vec4(10, 3.89, 0, 0);
    Vec4 mainDir = Vec4.add(Vec4.add(p.position, Vec4.mul(forwardDir, mainPos.x)), Vec4.add(Vec4.mul(upDir, mainPos.y), Vec4.mul(rightDir, mainPos.z)));
    
    Vec4 homerPos = new Vec4(10.06, 3.89, p.getW()/480 * 7.1, 0);
    Vec4 homerDir = Vec4.add(Vec4.add(p.position, Vec4.mul(forwardDir, homerPos.x)), Vec4.add(Vec4.mul(upDir, homerPos.y), Vec4.mul(rightDir, homerPos.z)));
    
    pushMatrix();
    translate(mainDir.x, mainDir.y, mainDir.z);
    rotateY(p.theta);
    rotateX(-p.phi);
    fill(stoneBlue);
    box(14.8, 0.5, 0);
    popMatrix();
    
    pushMatrix();
    translate(mainDir.x, mainDir.y, mainDir.z);
    rotateY(p.theta);
    rotateX(-p.phi);
    fill(green);
    box(2.74, 0.3, 0.01);
    popMatrix();
    
    pushMatrix();
    translate(homerDir.x, homerDir.y, homerDir.z);
    rotateY(p.theta);
    rotateX(-p.phi);
    fill(yellow);
    noStroke();
    sphere(0.12);
    popMatrix();
  }
}
