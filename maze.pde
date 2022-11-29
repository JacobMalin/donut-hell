// maze.pde

int wallLen = 1000;
Vec3 gravity = new Vec3(0, 100, 0);

Player player;
Wall wall;

void setup()
{
  size(1280, 720, P3D);
  
  player = new Player();
  wall = new Wall();
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
  
  wall.Draw();
}

void keyPressed()
{
  player.HandleKeyPressed();
}

void keyReleased()
{
  player.HandleKeyReleased();
}
