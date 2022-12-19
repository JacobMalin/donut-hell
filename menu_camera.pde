// menu_camera.pde
// Created for CSCI 5611 by Liam Tyler
// Modified to move in a circle
// And removed key input

class MenuCamera
{
  MenuCamera()
  {
    position      = new Vec4( 0, cameraHeight, cameraDist, 0 ); // initial position
    theta         = 0; // rotation around Y axis. Starts with forward direction as ( 0, 0, -1 )
    phi           = -0.4; // rotation around X axis. Starts with up direction as ( 0, 1, 0 )
    turnSpeed     = PI/16; // radians/sec
    
    // UI
    ui = new MenuUI(this);
    
    // dont need to change these
    fovy             = PI / 4;
    aspectRatio      = width / (float) height;
    nearPlane        = 0.1;
    farPlane         = 10000;
  }
  
  float getW() { return position.w; };
  
  void Update(float dt)
  {
    theta += turnSpeed * dt;
    
    float t = theta + PI / 2;
    float p = phi + PI / 2;
    PVector forwardDir = new PVector( sin( p ) * cos( t ),   cos( p ),   -sin( p ) * sin ( t ) );
    PVector upDir      = new PVector( sin( phi ) * cos( t ), cos( phi ), -sin( t ) * sin( phi ) );
    
    position = new Vec4( cameraDist * cos(PI/2 - theta), cameraHeight, cameraDist * sin(PI/2 - theta), wallLen/2 * cos(-theta*2) );
    
    aspectRatio = width / (float) height;
    perspective( fovy, aspectRatio, nearPlane, farPlane );
    camera( position.x, position.y, position.z,
            position.x + forwardDir.x, position.y + forwardDir.y, position.z + forwardDir.z,
            upDir.x, upDir.y, upDir.z );
  }
  
  void Draw() {
    ui.Draw();
  }
  
  //// only need to change if you want difrent keys for the controls
  //void HandleKeyPressed()
  //{
  //  if ( key == 'p' || key == 'P' ) println(position, theta%(2*PI), phi%(2*PI));
  //}
  
  void HandleMousePressed() {
    ui.HandleMousePressed();
  }
  
  // only necessary to change if you want different start position, orientation, or speeds
  Vec4 position;
  float theta;
  float phi;
  float turnSpeed;
  
  // UI
  MenuUI ui;
  
  // probably don't need / want to change any of the below variables
  float fovy;
  float aspectRatio;
  float nearPlane;
  float farPlane;
};
