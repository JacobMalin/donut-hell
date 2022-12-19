// donut_room.pde

int donutRad = 10;

class donutRoom extends KDTree {
  Vec4 donutPos;
  boolean isEaten;

  public donutRoom(Vec4 pos, Vec4 thickness) {
    this.pos = pos;
    this.thickness = thickness;
    
    donutPos = new Vec4(pos.x + thickness.x/2, pos.y + thickness.y, pos.z + thickness.z/2, pos.w + thickness.w/2);
    if (pos.y + thickness.y + padding < wallLen/2) donutPos.add(new Vec4(0, -wallRad.y, 0, 0));
    
    isEaten = false;
    numDonuts = 1;
  }
  
  public String toString() {
    return "donut(" + pos + "," + thickness + "," + isEaten + "," + donutPos + ")";
  }
  
  wallInfo[] getInfo(Vec4 playerPos) {  wallInfo[] i = {new wallInfo(MAX_FLOAT), new wallInfo(MIN_FLOAT), new wallInfo(0)}; return i;  }
  
  hitInfo collide(Vec4 playerPos) {
    hitInfo hit = new hitInfo();
    
    return hit;
  }
  
  boolean donutCollide(Vec4 playerPos) {
    Vec4 dirDonut = Vec4.sub(playerPos, donutPos);
    dirDonut.w = 0;
    Vec4 dirKD = Vec4.sub(playerPos, pos);
    
    boolean isNearby =
      dirDonut.length() < donutRad + playerRad &&
      dirKD.w < thickness.w + playerRad && dirKD.w > -playerRad;
    
    if (!isEaten && isNearby) {
      isEaten = true;
      return true;
    }
    else return false;
  }
  
  void Draw(float w) {
    if (!isEaten && w < (pos.w + thickness.w) && w > pos.w) {
      // Donut
      pushMatrix();
      translate(donutPos.x, donutPos.y, donutPos.z);
      scale(0.10);
      shape(donut);
      popMatrix();
    }
  }
}
