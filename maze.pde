// maze.pde

int wallLen = 1000;
int wallRad = 10;
int playerRad = 11;
Vec4 gravity = new Vec4(0, 150, 0, 0);

Player player;
Wall wall;
KDTree tree;

int maxLayers = 10;
Vec4 corner = new Vec4(-wallLen/2, -wallLen/2, -wallLen/2, -wallLen/2);
Vec4 size = new Vec4(wallLen, wallLen, wallLen, wallLen);
Vec4 doorThickness = new Vec4(playerRad*2 + 10, playerRad*2 + 10, playerRad*2 + 10, playerRad*2 + 10);

int wireframeWeight = 10;

void setup()
{
  size(1280, 720, P3D);
  
  player = new Player();
  wall = new Wall();
  tree = generate(maxLayers, corner, size);
  //println(tree);
}

void update(float dt) {
  player.Update(dt);
}

void draw() {
  background(255);
  
  // Sun
  float ambient = 230;
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
