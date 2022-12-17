// donut_room.pde

class donutRoom extends KDTree {
  public donutRoom(Vec4 pos, Vec4 thickness) {
    this.pos = pos;
    this.thickness = thickness;
  }
  
  hitInfo collide(Vec4 playerPos) {
    hitInfo hit = new hitInfo();
    
    return hit;
  }
  
  void Draw(float w) {
    // Donut
    pushMatrix();
    translate(pos.x + thickness.x/2, pos.y + thickness.y/2, pos.z + thickness.z/2);
    scale(1);
    shape(donut);
    popMatrix();
  }
}
