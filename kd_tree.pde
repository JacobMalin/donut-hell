// kd_tree.pde

KDTree generate(int maxLayers, Vec4 pos, Vec4 thickness) {
  return generate(maxLayers, 0, pos, thickness);
}

KDTree generate(int maxLayers, int currentLayer, Vec4 pos, Vec4 thickness) {
  KDTree tree = new KDTree();
  color[] colors = {
    #b12856,
    #a63d20,
    #825700,
    #4d6800,
  };
  
  try {
    if (currentLayer < maxLayers && (thickness.get(currentLayer % 4) - 4*playerRad - 2*wallRad) > 0) {
      float temp = random(pos.get(currentLayer % 4) + 2*playerRad + wallRad, pos.get(currentLayer % 4) + thickness.get(currentLayer % 4) - 2*playerRad - wallRad);
      //println(pos.get(currentLayer % 4) + 2*playerRad + wallRad, pos.get(currentLayer % 4) + thickness.get(currentLayer % 4) - 2*playerRad - wallRad, temp);

      tree.wall = new InnerWall(Vec4.copy(pos), Vec4.copy(thickness), colors[currentLayer % 4]);
      tree.wall.pos.set(currentLayer % 4, temp - wallRad);
      tree.wall.thickness.set(currentLayer % 4, wallRad*2);

      Vec4 leftThickness = Vec4.copy(thickness);
      Vec4 rightThickness = Vec4.copy(thickness);
      leftThickness.set(currentLayer % 4, temp - pos.get(currentLayer % 4));
      rightThickness.set(currentLayer % 4, thickness.get(currentLayer % 4) - temp + pos.get(currentLayer % 4));

      tree.pos = Vec4.copy(pos);
      tree.thickness = Vec4.copy(thickness);

      Vec4 rightPos = Vec4.copy(tree.wall.pos);
      rightPos.set(currentLayer % 4, temp);

      tree.left = generate(maxLayers, currentLayer+1, Vec4.copy(pos), leftThickness);
      tree.right = generate(maxLayers, currentLayer+1, rightPos, rightThickness);

      return tree;
    }
  } catch (Exception e) {
    println(e);
  }
  
  return null;
}

public class KDTree {
  InnerWall wall;
  KDTree left, right;
  
  Vec4 pos;
  Vec4 thickness;

  public KDTree() {}

  public KDTree(InnerWall wall) {
    this.wall = wall;
  }
  
  public KDTree(InnerWall wall, InnerWall leftWall, InnerWall rightWall) {
    this.wall = wall;
    
    left = new KDTree(leftWall);
    right = new KDTree(rightWall);
  }
  
  public String toString(){
    return "KD(" + pos + "," + thickness + "," + wall + ",\n\t" + right + ",\n\t" + left + ")";
  }
  
  hitInfo collide(Vec4 playerPos) {
    hitInfo hit = new hitInfo();
    
    if (wall != null) {
      hitInfo wallHit = wall.collide(playerPos);
      hit.hit |= wallHit.hit;
      hit.dir = Vec4.add(hit.dir, wallHit.dir);
    }
    
    if (left != null  && left.isInside(playerPos)) {
      hitInfo leftHit = left.collide(playerPos);
      hit.hit |= leftHit.hit;
      hit.dir = Vec4.add(hit.dir, leftHit.dir);
    }
    
    if (right != null && right.isInside(playerPos)) {
      hitInfo rightHit = right.collide(playerPos);
      hit.hit |= rightHit.hit;
      hit.dir = Vec4.add(hit.dir, rightHit.dir);
    }
    
    return hit;
  }
  
  boolean isInside(Vec4 playerPos) {
    return true;
    //Vec4 dir = Vec4.sub(playerPos, pos);
    //return dir.x < thickness.x && dir.x > 0 &&
    //       dir.y < thickness.y && dir.y > 0 &&
    //       dir.z < thickness.z && dir.z > 0 &&
    //       dir.w < thickness.w && dir.w > 0;
  }
  
  void Draw(float w) {
    wall.Draw(w);
    
    if (left != null)  left.Draw(w);
    if (right != null) right.Draw(w);
  }
}
