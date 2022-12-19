// menu_ui.pde

class MenuUI {
  MenuCamera m;
  
  int complexity;
  
  float[][] buttonArea = {
    {1120, 512, 1250, 557},  // x1, y1, x2, y2
    {998, 570, 1250, 618},
    {918, 636, 1250, 695},
  };
  color[] buttonColors = {
    textColor[0],
    textColor[0],
    textColor[0],
  };
  String[] niceHell = {
    "Hell",
    "Nice",
  };

  public MenuUI(MenuCamera m) {
    this.m = m;
    
    complexity = 1;
  }
  
  void Update() {
    
  }
  
  void Draw() {
    float zConstant = 0.0072;
    
    float theta2 = m.theta + PI / 2;
    float phi2 = m.phi + PI / 2;
    Vec4 forwardDir = new Vec4( sin( phi2 ) * cos( theta2 ),    cos( phi2 ),    -sin( phi2 ) * sin ( theta2 ),    0 );
    Vec4 upDir      = new Vec4( sin( m.phi ) * cos( theta2 ),   cos( m.phi ),   -sin( theta2 ) * sin ( m.phi ),   0 );
    Vec4 rightDir   = new Vec4( cos( m.theta ),                 0,              -sin( m.theta ),                  0 );
    
    // Donut text
    Vec4[] titleRel = {
      new Vec4(10, 2.93, -6.943, 0),
      new Vec4(10, 3.69, -7, 0),
    };
    Vec4[] titleDir = {
      Vec4.add(Vec4.add(m.position, Vec4.mul(forwardDir, titleRel[0].x)), Vec4.add(Vec4.mul(upDir, titleRel[0].y), Vec4.mul(rightDir, titleRel[0].z))),
      Vec4.add(Vec4.add(m.position, Vec4.mul(forwardDir, titleRel[1].x)), Vec4.add(Vec4.mul(upDir, titleRel[1].y), Vec4.mul(rightDir, titleRel[1].z))),
    };
    String[] titleText = {
      "The 4th Ring of", 
      "Donut Hell"
    };
    
    // Sub-title
    pushMatrix();
    translate(titleDir[0].x, titleDir[0].y, titleDir[0].z);
    rotateY(m.theta);
    rotateX(-m.phi);
    fill(textColor[0]);
    scale(0.0004);
    textSize(1024);
    textAlign(LEFT);
    textMode(SHAPE);
    text(titleText[0], 0, 0, 0);
    popMatrix();
    
    // Title
    pushMatrix();
    translate(titleDir[1].x, titleDir[1].y, titleDir[1].z);
    rotateY(m.theta);
    rotateX(-m.phi);
    fill(textColor[1]);
    scale(0.0009);
    textSize(1024);
    textAlign(LEFT);
    textMode(SHAPE);
    text(titleText[1], 0, 0, 0);
    popMatrix();
    
    
    
    // Button text
    Vec4[] buttonRel = {
      new Vec4(10, 2.2, 7, 0),
      new Vec4(10, 2.93, 7, 0),
      new Vec4(10, 3.68, 7, 0),
    };
    Vec4[] buttonDir = {
      Vec4.add(Vec4.add(m.position, Vec4.mul(forwardDir, buttonRel[0].x)), Vec4.add(Vec4.mul(upDir, buttonRel[0].y), Vec4.mul(rightDir, buttonRel[0].z))),
      Vec4.add(Vec4.add(m.position, Vec4.mul(forwardDir, buttonRel[1].x)), Vec4.add(Vec4.mul(upDir, buttonRel[1].y), Vec4.mul(rightDir, buttonRel[1].z))),
      Vec4.add(Vec4.add(m.position, Vec4.mul(forwardDir, buttonRel[2].x)), Vec4.add(Vec4.mul(upDir, buttonRel[2].y), Vec4.mul(rightDir, buttonRel[2].z))),
    };
    String[] buttonText = {
      "Start", 
      niceHell[int(isWireframe)] + " Mode",
      "Complexity: " + complexity,
    };
    
    if (mouseX > buttonArea[0][0] && mouseX < buttonArea[0][2] && mouseY > buttonArea[0][1] && mouseY < buttonArea[0][3]) { // Start
      buttonColors[0] = textColor[1];
    } else {
      buttonColors[0] = textColor[0];
    }
    if (mouseX > buttonArea[1][0] && mouseX < buttonArea[1][2] && mouseY > buttonArea[1][1] && mouseY < buttonArea[1][3]) { // Wireframe
      buttonColors[1] = textColor[1];
    } else {
      buttonColors[1] = textColor[0];
    }
    if (mouseX > buttonArea[2][0] && mouseX < buttonArea[2][2] && mouseY > buttonArea[2][1] && mouseY < buttonArea[2][3]) { // Complexity
      buttonColors[2] = textColor[1];
    } else {
      buttonColors[2] = textColor[0];
    }
    
    // Start
    pushMatrix();
    translate(buttonDir[0].x, buttonDir[0].y, buttonDir[0].z);
    rotateY(m.theta);
    rotateX(-m.phi);
    fill(buttonColors[0]);
    scale(0.00065);
    textSize(1024);
    textAlign(RIGHT);
    textMode(SHAPE);
    text(buttonText[0], 0, 0, 0);
    popMatrix();
    
    // Wireframe
    pushMatrix();
    translate(buttonDir[1].x, buttonDir[1].y, buttonDir[1].z);
    rotateY(m.theta);
    rotateX(-m.phi);
    fill(buttonColors[1]);
    scale(0.00065);
    textSize(1024);
    textAlign(RIGHT);
    textMode(SHAPE);
    text(buttonText[1], 0, 0, 0);
    popMatrix();
    
    // Complexity
    pushMatrix();
    translate(buttonDir[2].x, buttonDir[2].y, buttonDir[2].z);
    rotateY(m.theta);
    rotateX(-m.phi);
    fill(buttonColors[2]);
    scale(0.00065);
    textSize(1024);
    textAlign(RIGHT);
    textMode(SHAPE);
    text(buttonText[2], 0, 0, 0);
    popMatrix();
  }
  
  void HandleMousePressed() {
    if (mouseX > buttonArea[0][0] && mouseX < buttonArea[0][2] && mouseY > buttonArea[0][1] && mouseY < buttonArea[0][3]) { // Start
      //tree = generate(maxLayers, corner, size);
      player.donutsLeft = tree.numDonuts;
      scene = 1;
    } else if (mouseX > buttonArea[1][0] && mouseX < buttonArea[1][2] && mouseY > buttonArea[1][1] && mouseY < buttonArea[1][3]) { // Wireframe
      isWireframe = !isWireframe;
    } else if (mouseX > buttonArea[2][0] && mouseX < buttonArea[2][2] && mouseY > buttonArea[2][1] && mouseY < buttonArea[2][3]) { // Complexity
      complexity %= maxComplexity;
      complexity++;
      if (complexity == 5) maxLayers = 1000;
      else maxLayers = (complexity - 1) * 4 + 1;
      
      tree = generate(maxLayers, corner, size);
      println(tree.numDonuts);
    }
  }
}
