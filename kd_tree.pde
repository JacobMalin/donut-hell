// kd_tree.pde

int maxIter = 10;
int padding = 10;

color wireframe = #bad80a;

KDTree generate(int maxLayers, Vec4 pos, Vec4 thickness) {
  ArrayList<Float>[] avoid = new ArrayList[4];
  for (int i = 0; i < 4; i++) {
    avoid[i] = new ArrayList<Float>();
  }
  
  return generate(maxLayers, 0, pos, thickness, avoid);
}

KDTree generate(int maxLayers, int currentLayer, Vec4 pos, Vec4 thickness, ArrayList<Float>[] avoid) {
  KDTree tree = new KDTree();
  color[] colors = {
    #68217a,
    #00bcf2,
    #00b294,
    wireframe,
  };
  
  try {
    if (currentLayer < maxLayers && (thickness.get(currentLayer % 4) - 2*doorThickness.get(currentLayer % 4) - 2*wallRad.get(currentLayer % 4) - 2*padding) > 0) {
      Vec4 doorPos = Vec4.copy(pos);
      float doorRandX, doorRandZ, doorRandW;
      switch (currentLayer % 4) {
        case 0:
          doorRandZ = random(wallRad.z, thickness.z - doorThickness.z - wallRad.z);
          doorRandW = random(wallRad.w, thickness.w - doorThickness.w - wallRad.w);
          doorPos.y = pos.y + thickness.y - doorThickness.y;
          if (doorPos.y < wallLen/2 - 3*doorThickness.y/2) doorPos.y -= wallRad.y;
          doorPos.z += doorRandZ;
          doorPos.w += doorRandW;
          avoid[1].add(doorPos.y);
          avoid[2].add(doorPos.z);
          avoid[3].add(doorPos.w);
          break;
        case 1:
          doorRandX = random(wallRad.x, thickness.x - doorThickness.x - wallRad.x);
          doorRandZ = random(wallRad.z, thickness.z - doorThickness.z - wallRad.z);
          doorRandW = random(wallRad.w, thickness.w - doorThickness.w - wallRad.w);
          doorPos.x += doorRandX;
          doorPos.z += doorRandZ;
          doorPos.w += doorRandW;
          avoid[0].add(doorPos.x);
          avoid[2].add(doorPos.z);
          avoid[3].add(doorPos.w);
          break;
        case 2:
          doorRandX = random(wallRad.x, thickness.x - doorThickness.x - wallRad.x);
          doorRandW = random(wallRad.w, thickness.w - doorThickness.w - wallRad.w);
          doorPos.x += doorRandX;
          doorPos.y = pos.y + thickness.y - doorThickness.y;
          if (doorPos.y < wallLen/2 - 3*doorThickness.y/2) doorPos.y -= wallRad.y;
          doorPos.w += doorRandW;
          avoid[0].add(doorPos.x);
          avoid[1].add(doorPos.y);
          avoid[3].add(doorPos.w);
          break;
        case 3:
          doorRandX = random(wallRad.x, thickness.x - doorThickness.x - wallRad.x);
          doorRandZ = random(wallRad.z, thickness.z - doorThickness.z - wallRad.z);
          doorPos.x += doorRandX;
          doorPos.y = pos.y + thickness.y - doorThickness.y;
          if (doorPos.y < wallLen/2 - 3*doorThickness.y/2) doorPos.y -= wallRad.y;
          doorPos.z += doorRandZ;
          avoid[0].add(doorPos.x);
          avoid[1].add(doorPos.y);
          avoid[2].add(doorPos.z);
      }
      
      float wallRand = -1;
      for (int i = 0; i < maxIter; i++) {
        wallRand = random(pos.get(currentLayer % 4) + doorThickness.get(currentLayer % 4) + wallRad.get(currentLayer % 4) + padding, 
                          pos.get(currentLayer % 4) + thickness.get(currentLayer % 4) - doorThickness.get(currentLayer % 4) - wallRad.get(currentLayer % 4) - padding);
        
        boolean do_continue = false;
        for (int j = 0; j < avoid[currentLayer % 4].size(); j++) {
          //println(currentLayer%4, i, j, avoid[currentLayer % 4].get(j), wallRand, doorThickness.get(currentLayer % 4) + wallRad + padding, avoid[currentLayer % 4].get(j) + doorThickness.get(currentLayer % 4) + wallRad + padding > wallRand && 
          //    avoid[currentLayer % 4].get(j) - doorThickness.get(currentLayer % 4) - wallRad - padding < wallRand);
          if (avoid[currentLayer % 4].get(j) + doorThickness.get(currentLayer % 4) + wallRad.get(currentLayer % 4) + padding > wallRand && 
              avoid[currentLayer % 4].get(j) - doorThickness.get(currentLayer % 4) - wallRad.get(currentLayer % 4) - padding < wallRand) {
                do_continue = true;
                break;
              }
        }
        if (i == maxIter - 1) return new donutRoom(pos, thickness);
        
        if (do_continue) continue;
        
        break;
      }

      int variation = 30;
      color new_color = color(
        red(colors[currentLayer % 4]) + random(-variation, variation), 
        green(colors[currentLayer % 4]) + random(-variation, variation), 
        blue(colors[currentLayer % 4]) + random(-variation, variation)
      );
      tree.wall = new InnerWall(Vec4.copy(pos), Vec4.copy(thickness), new_color, currentLayer % 4, doorPos);
      tree.wall.pos.set(currentLayer % 4, wallRand - wallRad.get(currentLayer % 4));
      tree.wall.thickness.set(currentLayer % 4, wallRad.get(currentLayer % 4)*2);

      Vec4 leftThickness = Vec4.copy(thickness);
      Vec4 rightThickness = Vec4.copy(thickness);
      leftThickness.set(currentLayer % 4, wallRand - pos.get(currentLayer % 4));
      rightThickness.set(currentLayer % 4, thickness.get(currentLayer % 4) - wallRand + pos.get(currentLayer % 4));

      tree.pos = Vec4.copy(pos);
      tree.thickness = Vec4.copy(thickness);

      Vec4 rightPos = Vec4.copy(tree.wall.pos);
      rightPos.set(currentLayer % 4, wallRand);
      
      ArrayList<Float>[] leftAvoid = new ArrayList[4];
      ArrayList<Float>[] rightAvoid = new ArrayList[4];
      for (int i = 0; i < 4; i++) {
        leftAvoid[i] = new ArrayList<Float>();
        rightAvoid[i] = new ArrayList<Float>();
        for (int j = 0; j < avoid[i].size(); j++) {
          leftAvoid[i].add(avoid[i].get(j));
          rightAvoid[i].add(avoid[i].get(j));
        }
      }

      tree.left = generate(maxLayers, currentLayer+1, Vec4.copy(pos), leftThickness, leftAvoid);
      tree.right = generate(maxLayers, currentLayer+1, rightPos, rightThickness, rightAvoid);

      return tree;
    }
  } catch (Exception e) {
    println(e);
  }
  
  return new donutRoom(pos, thickness);
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
    
    hitInfo wallHit = wall.collide(playerPos);
    hit.hit |= wallHit.hit;
    hit.dir = Vec4.add(hit.dir, wallHit.dir);
    
    if (left.isInside(playerPos)) {
      hitInfo leftHit = left.collide(playerPos);
      hit.hit |= leftHit.hit;
      hit.dir = Vec4.add(hit.dir, leftHit.dir);
    }
    
    if (right.isInside(playerPos)) {
      hitInfo rightHit = right.collide(playerPos);
      hit.hit |= rightHit.hit;
      hit.dir = Vec4.add(hit.dir, rightHit.dir);
    }
    
    return hit;
  }
  
  boolean isInside(Vec4 playerPos) {
    Vec4 dir = Vec4.sub(playerPos, pos);
    return dir.x < thickness.x && dir.x > 0 &&
           dir.y < thickness.y && dir.y > 0 &&
           dir.z < thickness.z && dir.z > 0 &&
           dir.w < thickness.w && dir.w > 0;
  }
  
  void Draw(float w) {
    wall.Draw(w);
    
    if (left != null)  left.Draw(w);
    if (right != null) right.Draw(w);
  }
}
