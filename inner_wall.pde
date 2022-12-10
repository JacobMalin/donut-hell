// inner_wall.pde

class InnerWall {
  color c;
  Vec4 pos, thickness;

  public InnerWall(Vec4 pos, Vec4 thickness, color c) {    
    this.pos = pos;
    this.thickness = thickness;
    this.c = c;
  }
  
  public String toString() {
    return "InnerWall(" + pos + "," + thickness + ")";
  }
  
  hitInfo collide(Vec4 playerPos) {
    hitInfo hit = new hitInfo();
    
    Vec4 dir = Vec4.sub(playerPos, pos);
    
    hit.hit = dir.x < thickness.x/2 && dir.x > -thickness.x/2 &&
              dir.y < thickness.y/2 && dir.y > -thickness.y/2 &&
              dir.z < thickness.z/2 && dir.z > -thickness.z/2 &&
              dir.w < thickness.w/2 && dir.w > -thickness.w/2;
              
    if (hit.hit) {
      int dim = -1;
      float min = MAX_FLOAT;
      float[] dims = {
        thickness.x/2.0 + playerPos.x - pos.x, thickness.x/2.0 - playerPos.x + pos.x,
        thickness.y/2.0 + playerPos.y - pos.y, thickness.y/2.0 - playerPos.y + pos.y,
        thickness.z/2.0 + playerPos.z - pos.z, thickness.z/2.0 - playerPos.z + pos.z,
        thickness.w/2.0 + playerPos.w - pos.w, thickness.w/2.0 - playerPos.w + pos.w,
      };
      
      for (int i = 0; i < 8; i++) {
        if (dims[i] < min) {
          min = dims[i];
          dim = i;
        }
      }
      
      switch (dim) {
        case 0:
          hit.dir = new Vec4(-dims[0], 0, 0, 0);
          break;
        case 1:
          hit.dir = new Vec4(dims[1], 0, 0, 0);
          break;
        case 2:
          hit.dir = new Vec4(0, -dims[2], 0, 0);
          break;
        case 3:
          hit.dir = new Vec4(0, dims[3], 0, 0);
          break;
        case 4:
          hit.dir = new Vec4(0, 0, -dims[4], 0);
          break;
        case 5:
          hit.dir = new Vec4(0, 0, dims[5], 0);
          break;
        case 6:
          hit.dir = new Vec4(0, 0, 0, -dims[6]);
          break;
        case 7:
          hit.dir = new Vec4(0, 0, 0, dims[7]);
          break;
      }
    }
    
    return hit;
  }
  
  void Draw(float w) {
    if (w < (pos.w + thickness.w) && w > pos.w) {
      pushMatrix();
      fill(c);
      translate(pos.x + thickness.x/2, pos.y + thickness.y/2, pos.z + thickness.z/2);
      box(thickness.x, thickness.y, thickness.z);
      popMatrix();
    }
  }
}
