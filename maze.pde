// maze.pde

int wallLen = 1000;
Vec4 gravity = new Vec4(0, 100, 0, 0);

Player player;
Wall wall;
Object tree;

void setup()
{
  size(1280, 720, P3D);
  
  player = new Player();
  wall = new Wall();
  tree = new Object();
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
