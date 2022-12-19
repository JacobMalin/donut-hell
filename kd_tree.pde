// kd_tree.pde

int maxIter = 10;
int padding = 10;

KDTree generate(int maxLayers, Vec4 pos, Vec4 thickness) {
  ArrayList<Float>[] avoid = new ArrayList[4];
  for (int i = 0; i < 4; i++) {
    avoid[i] = new ArrayList<Float>();
  }
  
  return generate(maxLayers+3, 3, pos, thickness, avoid);
}

KDTree generate(int maxLayers, int currentLayer, Vec4 pos, Vec4 thickness, ArrayList<Float>[] avoid) {
  KDTree tree = new KDTree();
  
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
        float minRand = pos.get(currentLayer % 4) + doorThickness.get(currentLayer % 4) + wallRad.get(currentLayer % 4) + padding;
        float maxRand = pos.get(currentLayer % 4) + thickness.get(currentLayer % 4) - doorThickness.get(currentLayer % 4) - wallRad.get(currentLayer % 4) - padding;
        
        if (currentLayer < 4) {
          int firstRandMax = 100;
          wallRand = random(-firstRandMax, firstRandMax);
          wallRand += minRand + (maxRand - minRand)/2;
        } else {
          float wallRand1 = random(minRand, maxRand);
          float wallRand1Dist = abs(wallRand1 - (maxRand + minRand)/2);
          float wallRand2 = random(minRand, maxRand);
          float wallRand2Dist = abs(wallRand2 - (maxRand + minRand)/2);
          
          wallRand = wallRand1Dist < wallRand2Dist ? wallRand1 : wallRand2;
        }
        
        boolean do_continue = false;
        for (int j = 0; j < avoid[currentLayer % 4].size(); j++) {
          if (avoid[currentLayer % 4].get(j) + doorThickness.get(currentLayer % 4) + wallRad.get(currentLayer % 4) + padding > wallRand && 
              avoid[currentLayer % 4].get(j) - doorThickness.get(currentLayer % 4) - wallRad.get(currentLayer % 4) - padding < wallRand) {
                do_continue = true;
                break;
              }
        }
        if (i == maxIter - 1) return new donutRoom(Vec4.copy(pos), Vec4.copy(thickness));
        
        if (do_continue) continue;
        
        break;
      }

      int variation = 25;
      color new_color = color(
        red(wallColors[currentLayer % 4]) + random(-variation, variation), 
        green(wallColors[currentLayer % 4]) + random(-variation, variation), 
        blue(wallColors[currentLayer % 4]) + random(-variation, variation)
      );
      tree.wall = new InnerWall(Vec4.copy(pos), Vec4.copy(thickness), new_color, currentLayer % 4, doorPos, Vec4.copy(pos), Vec4.copy(thickness));
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
      
      
      if (currentLayer == 3) {
        println(currentLayer);
        println(wallRand);
        println(leftAvoid);
        println(tree.left.numDonuts);
        println(rightAvoid);
        println(tree.right.numDonuts);
      }
      tree.numDonuts = tree.left.numDonuts + tree.right.numDonuts;

      return tree;
    }
  } catch (Exception e) {
    println(e);
  }
  
  return new donutRoom(Vec4.copy(pos), Vec4.copy(thickness));
}

public class KDTree {
  InnerWall wall;
  KDTree left, right;
  
  Vec4 pos;
  Vec4 thickness;
  
  int numDonuts;
  
  public KDTree() {
    this.numDonuts = 0;
  }

  public KDTree(InnerWall wall) {
    this.wall = wall;
    this.numDonuts = 0;
  }
  
  public KDTree(InnerWall wall, InnerWall leftWall, InnerWall rightWall) {
    this.wall = wall;
    
    left = new KDTree(leftWall);
    right = new KDTree(rightWall);
    
    this.numDonuts = 0;
  }
  
  public String toString(){
    return "KD(" + pos + "," + thickness + "," + wall + ",\n\t" + right + ",\n\t" + left + ")";
  }
  
  wallInfo[] getInfo(Vec4 playerPos) {
    wallInfo[] info = {new wallInfo(MAX_FLOAT), new wallInfo(MIN_FLOAT), new wallInfo(0)};
    
    if (isInsideNoW(playerPos)) {
      if (wall.orien == 3) {
        Vec4 dir = Vec4.sub(playerPos, wall.doorPos);
        boolean isInDoorway =
          dir.x <= doorThickness.x - playerRad && dir.x >= playerRad &&
          dir.y <= doorThickness.y - playerRad && dir.y >= playerRad &&
          dir.z <= doorThickness.z - playerRad && dir.z >= playerRad;
        
        if (isInDoorway) {
          info[2] = new wallInfo(wall.pos.w + wall.thickness.w/2, 0, wall.c);
        } else {
          float diff = playerPos.w - wall.pos.w - wall.thickness.w/2;
          if (diff > 0) info[0] = new wallInfo(wall.pos.w + wall.thickness.w/2, diff, wall.c);
          else info[1] = new wallInfo(wall.pos.w + wall.thickness.w/2, diff, wall.c);
        }
      }
      
      wallInfo[] leftInfo = left.getInfo(playerPos);
      if (leftInfo[0].diff < info[0].diff) info[0] = leftInfo[0];
      if (leftInfo[1].diff > info[1].diff) info[1] = leftInfo[1];
      if (leftInfo[2].exists)              info[2] = leftInfo[2];
      
      wallInfo[] rightInfo = right.getInfo(playerPos);
      if (rightInfo[0].diff < info[0].diff) info[0] = rightInfo[0];
      if (rightInfo[1].diff > info[1].diff) info[1] = rightInfo[1];
      if (rightInfo[2].exists)              info[2] = rightInfo[2];
    }
    
    return info;
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
  
  boolean donutCollide(Vec4 playerPos) {
    return left.donutCollide(playerPos) || right.donutCollide(playerPos);
  }
  
  boolean isInside(Vec4 playerPos) {
    Vec4 dir = Vec4.sub(playerPos, pos);
    return dir.x < thickness.x && dir.x > 0 &&
           dir.y < thickness.y && dir.y > 0 &&
           dir.z < thickness.z && dir.z > 0 &&
           dir.w < thickness.w && dir.w > 0;
  }
  
  boolean isInsideNoW(Vec4 playerPos) {
    Vec4 dir = Vec4.sub(playerPos, pos);
    return dir.x < thickness.x && dir.x > 0 &&
           dir.y < thickness.y && dir.y > 0 &&
           dir.z < thickness.z && dir.z > 0;
  }
  
  void Draw(float w) {
    wall.Draw(w);
    
    left.Draw(w);
    right.Draw(w);
  }
}
