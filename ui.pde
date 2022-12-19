// ui.pde

class UI {
  Player p;

  public UI(Player p) {
    this.p = p;
  }
  
  void Draw(wallInfo[] info) {
    float zConstant = 0.0072;
    
    float theta2 = p.theta + PI / 2;
    float phi2 = p.phi + PI / 2;
    Vec4 forwardDir = new Vec4( sin( phi2 ) * cos( theta2 ),    cos( phi2 ),    -sin( phi2 ) * sin ( theta2 ),    0 );
    Vec4 upDir      = new Vec4( sin( p.phi ) * cos( theta2 ),   cos( p.phi ),   -sin( theta2 ) * sin ( p.phi ),   0 );
    Vec4 rightDir   = new Vec4( cos( p.theta ),                 0,              -sin( p.theta ),                  0 );
    
    // Donut text
    Vec4 donutRel = new Vec4(10, -3.67, -7.2, 0);
    Vec4 donutDir = Vec4.add(Vec4.add(p.position, Vec4.mul(forwardDir, donutRel.x)), Vec4.add(Vec4.mul(upDir, donutRel.y), Vec4.mul(rightDir, donutRel.z)));
    String donutText = "Donuts Left: " + p.donutsLeft;
    pushMatrix();
    translate(donutDir.x, donutDir.y, donutDir.z);
    rotateY(p.theta);
    rotateX(-p.phi);
    fill(textColor[0]);
    scale(0.0004);
    textSize(1024);
    textAlign(LEFT);
    textMode(SHAPE);
    text(donutText, 0, 0, 0);
    popMatrix();
    
    // Blue bar
    Vec4 mainRel = new Vec4(10, 3.89, 0, 0);
    Vec4 mainDir = Vec4.add(Vec4.add(p.position, Vec4.mul(forwardDir, mainRel.x)), Vec4.add(Vec4.mul(upDir, mainRel.y), Vec4.mul(rightDir, mainRel.z)));
    pushMatrix();
    translate(mainDir.x, mainDir.y, mainDir.z);
    rotateY(p.theta);
    rotateX(-p.phi);
    fill(UIColor);
    box(14.8, 0.5, 0);
    popMatrix();
    
    // Homer
    Vec4 homerRel = new Vec4(10.06, 3.89, p.getW() * zConstant, 0);
    Vec4 homerDir = Vec4.add(Vec4.add(p.position, Vec4.mul(forwardDir, homerRel.x)), Vec4.add(Vec4.mul(upDir, homerRel.y), Vec4.mul(rightDir, homerRel.z)));
    pushMatrix();
    translate(homerDir.x, homerDir.y, homerDir.z);
    rotateY(p.theta);
    rotateX(-p.phi);
    fill(homerColor);
    noStroke();
    sphere(0.12);
    popMatrix();
    
    for (int i = 0; i < 3; i++) {
      if (info[i].exists) {
        Vec4 wallRel = new Vec4(10, 3.89, info[i].pos * zConstant, 0);
        Vec4 wallDir = Vec4.add(Vec4.add(p.position, Vec4.mul(forwardDir, wallRel.x)), Vec4.add(Vec4.mul(upDir, wallRel.y), Vec4.mul(rightDir, wallRel.z)));
        
        if (i != 2) {
          pushMatrix();
          translate(wallDir.x, wallDir.y, wallDir.z);
          rotateY(p.theta);
          rotateX(-p.phi);
          fill(info[i].c);
          box((wallRad.w + playerRad*2) * zConstant, 0.3, 0.01);
          popMatrix();
        } else if (info[i].pos > info[0].pos && info[i].pos < info[1].pos) {
          pushMatrix();
          translate(wallDir.x, wallDir.y, wallDir.z);
          rotateY(p.theta);
          rotateX(-p.phi);
          noFill();
          stroke(wireframe);
          strokeWeight(UIStrokeWeight);
          box((wallRad.w + playerRad*2) * zConstant, 0.3, 0.01);
          popMatrix();
        }
      }
    }
  }
}
