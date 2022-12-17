// maze.pde

int wallLen = 1000;
Vec4 wallRad = new Vec4(5, 5, 5, 40);
int playerRad = 11;
Vec4 gravity = new Vec4(0, 100, 0, 0);

Player player;
Wall wall;
KDTree tree;

int maxLayers = 30;
Vec4 corner = new Vec4(-wallLen/2, -wallLen/2, -wallLen/2, -wallLen/2);
Vec4 size = new Vec4(wallLen, wallLen, wallLen, wallLen);
Vec4 doorThickness = new Vec4(playerRad*2 + 10, playerRad*2 + 10, playerRad*2 + 10, playerRad*2 + 100);

int wireframeWeight = 10;

PShape donut;
color pink = #ffffff;
color tanBrown = #000000;

void setup()
{
  size(1280, 720, P3D);
  
  player = new Player();
  wall = new Wall();
  tree = generate(maxLayers, corner, size);
  
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
  int mult = 10;
  for (int i = 0; i < mult; i++) {
    player.Update(dt/mult);
  }
}

void draw() {
  background(255);
  
  // Sun
  float ambient = 200;
  ambientLight(ambient, ambient, ambient);

  update(1.0/frameRate);
  
  player.Draw();
  
  wall.Draw();
  tree.Draw(player.getW());
}

void keyPressed()
{
  player.HandleKeyPressed();
}

void keyReleased()
{
  player.HandleKeyReleased();
}



/* HIT INFO */
class hitInfo{
  public boolean hit = false;
  public Vec4 dir = new Vec4(0, 0, 0, 0);
}
