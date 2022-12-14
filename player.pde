// Player.pde
//
// Originally camera created for CSCI 5611 by Liam Tyler
// Modified.

int epsilon = 10;

class Player
{
  public Player()
  {
    position      = new Vec4( 480, 480, 480, 480 ); // initial position
    velocity      = new Vec4(); // initial velocity
    theta         = 0.706; // rotation around Y axis. Starts with forward direction as ( 0, 0, -1 )
    phi           = 0.526; // rotation around X axis. Starts with up direction as ( 0, 1, 0 )
    moveSpeed     = 100;
    jumpSpeed     = 100;
    turnSpeed     = 3*PI/4; // radians/sec
    boostSpeed    = 5;  // extra speed boost for when you press shift
    radius        = playerRad; // distance for collision
    
    // UI
    bar = new Bar(this);
    
    // dont need to change these
    shiftPressed = false;
    negativeMovement = new Vec4( 0, 0, 0, 0 );
    positiveMovement = new Vec4( 0, 0, 0, 0 );
    negativeTurn     = new PVector( 0, 0 ); // .x for theta, .y for phi
    positiveTurn     = new PVector( 0, 0 );
    fovy             = PI / 4;
    aspectRatio      = width / (float) height;
    nearPlane        = 0.1;
    farPlane         = 10000;
  }
  
  float getW() {  return position.w;  };
  
  void Update(float dt)
  {
    theta += turnSpeed * ( negativeTurn.x + positiveTurn.x)*dt;
    
    // cap the rotation about the X axis to be less than 90 degrees to avoid gimble lock
    float maxAngleInRadians = 85 * PI / 180;
    phi = min( maxAngleInRadians, max( -maxAngleInRadians, phi + turnSpeed * ( negativeTurn.y + positiveTurn.y ) * dt ) );
    
    // re-orienting the angles to match the wikipedia formulas: https://en.wikipedia.org/wiki/Spherical_coordinate_system
    // except that their theta and phi are named opposite
    float t = theta + PI / 2;
    float p = phi + PI / 2;
    Vec4 forwardDir = new Vec4( sin( p ) * cos( t ),   0,   -sin( p ) * sin ( t ),   0 );
    Vec4 upDir      = new Vec4( 0,                     1,   0,                       0 );
    Vec4 rightDir   = new Vec4( cos( theta ),          0,   -sin( theta ),           0 );
    Vec4 zagDir     = new Vec4( 0,                     0,   0,                       1 );
    
    if (shiftPressed) moveSpeed *= boostSpeed;
    velocity.x = moveSpeed * (negativeMovement.x + positiveMovement.x);
    velocity.y += gravity.y * dt; // The y axis is special and does not have a constant velocity
    velocity.z = moveSpeed * (negativeMovement.z + positiveMovement.z);
    velocity.w = moveSpeed * (negativeMovement.w + positiveMovement.w);
    
    position.add( Vec4.mul( rightDir,   velocity.x * dt ) );
    position.add( Vec4.mul( upDir,      velocity.y * dt ) );
    position.add( Vec4.mul( forwardDir, velocity.z * dt ) );
    position.add( Vec4.mul( zagDir,     velocity.w * dt ) );
    if (shiftPressed) moveSpeed /= boostSpeed;

    
    // Collision
    float boundingWall = wallLen/2 - radius;
    if (position.y > boundingWall) velocity.y = 0;
    if (position.x > boundingWall  || position.y > boundingWall  || position.z > boundingWall  || position.w > boundingWall || // Pos
        position.x < -boundingWall || position.y < -boundingWall || position.z < -boundingWall || position.w < -boundingWall    // Neg
        ) {
      position.clamp(-boundingWall, boundingWall);
    }
    
    
    hitInfo hit = tree.collide(position);
    //println(hit.hit, hit.dir);
    if (hit.hit) {
      position.add( hit.dir );
      if ( hit.dir.y != 0 ) velocity.y = 0;
    }
    
    
    aspectRatio = width / (float) height;
    perspective( fovy, aspectRatio, nearPlane, farPlane );
    camera( position.x, position.y, position.z,
            position.x + forwardDir.x, position.y + forwardDir.y + cos(p), position.z + forwardDir.z,
            upDir.x, upDir.y, upDir.z );
            
    //println(position.w);
  }
  
  void Draw() {
    bar.Draw();
  }
  
  // only need to change if you want difrent keys for the controls
  void HandleKeyPressed()
  {
    if ( key == 'w' || key == 'W' ) positiveMovement.z = 1;  // Forward
    if ( key == 's' || key == 'S' ) negativeMovement.z = -1; // Backwards
    if ( key == 'd' || key == 'D' ) positiveMovement.x = 1;  // Right
    if ( key == 'a' || key == 'A' ) negativeMovement.x = -1; // Left
    if ( key == 'e' || key == 'E' ) positiveMovement.w = 1;  // Zig
    if ( key == 'q' || key == 'Q' ) negativeMovement.w = -1; // Zag
    
    //if ( key == ' ' && velocity.y == 0) velocity.y = -jumpSpeed; // Probably safe unless someone jumps at the exact apex of their arc
    if ( key == ' ') velocity.y = -2*jumpSpeed;
    
    if ( key == 'r' || key == 'R' ){
      //Player defaults = new Player();
      //position = defaults.position;
      //theta = defaults.theta;
      //phi = defaults.phi;
      
      tree = generate(maxLayers, corner, size);
    }
    
    if ( keyCode == LEFT )  negativeTurn.x = 1;
    if ( keyCode == RIGHT ) positiveTurn.x = -0.5;
    if ( keyCode == UP )    positiveTurn.y = 0.5;
    if ( keyCode == DOWN )  negativeTurn.y = -1;
    
    if ( keyCode == SHIFT ) shiftPressed = true;
    
    if ( key == 'p' || key == 'P' ) println(position, theta, phi);
  }
  
  // only need to change if you want difrent keys for the controls
  void HandleKeyReleased()
  {
    if ( key == 'w' || key == 'W' ) positiveMovement.z = 0;
    if ( key == 'd' || key == 'D' ) positiveMovement.x = 0;
    if ( key == 'e' || key == 'E' ) positiveMovement.w = 0;
    if ( key == 'a' || key == 'A' ) negativeMovement.x = 0;
    if ( key == 's' || key == 'S' ) negativeMovement.z = 0;
    if ( key == 'q' || key == 'Q' ) negativeMovement.w = 0;
    
    if ( keyCode == LEFT  ) negativeTurn.x = 0;
    if ( keyCode == RIGHT ) positiveTurn.x = 0;
    if ( keyCode == UP    ) positiveTurn.y = 0;
    if ( keyCode == DOWN  ) negativeTurn.y = 0;
    
    if ( keyCode == SHIFT ) shiftPressed = false;
  }
  
  // only necessary to change if you want different start position, orientation, or speeds
  Vec4 position;
  Vec4 velocity;
  float theta;
  float phi;
  float moveSpeed;
  float jumpSpeed;
  float turnSpeed;
  float boostSpeed;
  float radius;
  
  // UI
  Bar bar;
  
  // probably don't need / want to change any of the below variables
  float fovy;
  float aspectRatio;
  float nearPlane;
  float farPlane;  
  Vec4 negativeMovement;
  Vec4 positiveMovement;
  PVector negativeTurn;
  PVector positiveTurn;
  boolean shiftPressed;
};
