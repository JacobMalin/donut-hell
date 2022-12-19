// maze.pde

// Wall constants
int wallLen = 2000;
Vec4 wallRad = new Vec4(5, 5, 5, 30);
color[] wallColors = {
  #dbd56e, // x
  #2d93ad, // y
  #ff5c5c, // z
  #88ab75, // w
};
color wireframe = #7b6c9d;
int wireframeWeight = 10;

// Game Constants
int scene = 0; // 0 is menu, 1 is game, 2 is escape menu
color[] textColor = {
  #111111, // Black
  #940e1b, // Red
};
boolean isWireframe = true;
int maxLayers = 1;
int maxComplexity = 5;

// Menu Constants
color backgroundColor = #f8f8f8;
int cameraDist = 4000;
int cameraHeight = -1380;
float menuWireframeWeight = 1;

// UI Constants
color UIColor = #6e6d74;
int UIStrokeWeight = 3;

// Player constants
int playerRad = 15;
Vec4 gravity = new Vec4(0, 100, 0, 0);
color homerColor = #ffde34;

// Objects
Player player;
Wall wall;
KDTree tree;
MenuCamera menu;

// Room constants
Vec4 corner = new Vec4(-wallLen/2, -wallLen/2, -wallLen/2, -wallLen/2);
Vec4 size = new Vec4(wallLen, wallLen, wallLen, wallLen);
Vec4 doorThickness = new Vec4(playerRad*2 + 20, playerRad*2 + 20, playerRad*2 + 20, playerRad*2 + 70);

// Donut constants
PShape donut;
color pink = #fdb5cd;
color tanBrown = #dfb77e;

void setup()
{
  size(1280, 720, P3D);
  smooth(8);
  
  tree = generate(maxLayers, corner, size);
  player = new Player(tree.numDonuts);
  menu = new MenuCamera();
  wall = new Wall(menu);
  
  
  //donut = load();
  PShape frosting, dough;
  donut = createShape(GROUP);
  frosting = loadShape("assets/donut/frosting.obj");
  dough = loadShape("assets/donut/dough.obj");
  frosting.setFill(pink);
  dough.setFill(tanBrown);
  donut.addChild(frosting);
  donut.addChild(dough);
}

void update(float dt) {
  switch (scene) {
    case 0:
      menu.Update(dt);
      break;
    case 1:
    case 2:
      int mult = 10;
      for (int i = 0; i < mult; i++) {
        player.Update(dt/mult);
      }
      break;
  }
}

void draw() {
  background(backgroundColor);
  
  // Sun
  float ambient = 230;
  ambientLight(ambient, ambient, ambient);

  update(1.0/frameRate);
  
  if (scene == 0) {
    tree.Draw(menu.getW());
    menu.Draw();
    wall.Draw();
  } else {
    tree.Draw(player.getW());
    player.Draw();
    wall.Draw();
  }
}

void keyPressed() {
  player.HandleKeyPressed();
}

void keyReleased() {
  player.HandleKeyReleased();
}

void mousePressed() {
  menu.HandleMousePressed();
}



/* HIT INFO */
class hitInfo{
  public boolean hit = false;
  public Vec4 dir = new Vec4(0, 0, 0, 0);
}

/* WALL INFO */
class wallInfo{
  public float pos;
  public float diff;
  public color c;
  public boolean exists;
  
  public wallInfo(float diff) {
    this.pos = 0;
    this.diff = diff;
    this.c = 0;
    this.exists = false;
  }
  
  public wallInfo(float pos, float diff, color c) {
    this.pos = pos;
    this.diff = diff;
    this.c = c;
    this.exists = true;
  }
}
