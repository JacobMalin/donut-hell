// inner_wall.pde

class InnerWall {
  color c;
  Vec4 pos, thickness;
  int orien;
  Vec4 doorPos;

  public InnerWall(Vec4 pos, Vec4 thickness, color c, int orien, Vec4 doorPos) {
    this.pos = pos;
    this.thickness = thickness;
    this.c = c;
    this.orien = orien;
    this.doorPos = doorPos;
  }
  
  public String toString() {
    return "InnerWall(" + pos + "," + thickness + ")";
  }
  
  hitInfo collide(Vec4 playerPos) {
    hitInfo hit = new hitInfo();
    
    Vec4 dir = Vec4.sub(playerPos, pos);
    
    if ( orien == 0) {
      boolean topHit, closeHit, farHit, doorHit;
      // Top
      topHit   = dir.x < thickness.x + playerRad && dir.x > -playerRad &&
                 dir.y < thickness.y - doorThickness.y + playerRad && dir.y > -playerRad &&
                 dir.z < thickness.z + playerRad && dir.z > -playerRad &&
                 dir.w < thickness.w + playerRad && dir.w > -playerRad;
      
      // Close to pos
      closeHit = dir.x < thickness.x + playerRad && dir.x > -playerRad &&
                 dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                 dir.z < doorPos.z - pos.z + playerRad && dir.z > -playerRad &&
                 dir.w < thickness.w + playerRad && dir.w > -playerRad;
      
      // Far from pos
      farHit   = dir.x < thickness.x + playerRad && dir.x > -playerRad &&
                 dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                 dir.z < thickness.z + playerRad && dir.z > doorPos.z - pos.z + doorThickness.z - playerRad &&
                 dir.w < thickness.w + playerRad && dir.w > -playerRad;
                 
      // Door
      doorHit  = dir.x < thickness.x + playerRad && dir.x > -playerRad &&
                 dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                 dir.z < doorPos.z - pos.z + doorThickness.z + playerRad && dir.z > doorPos.z - pos.z - playerRad &&
                 (dir.w < doorPos.w -pos.w || dir.w > doorPos.w - pos.w + doorThickness.w);
      
      hit.hit = topHit || closeHit || farHit || doorHit;
      
      if (hit.hit) {
        if (topHit) {
          float min = MAX_FLOAT;
          int dim = -1;
          float[] dims = {
            playerPos.x - pos.x + playerRad, 
            thickness.x - playerPos.x + pos.x + playerRad,
            thickness.y - doorThickness.y - playerPos.y + pos.y + playerRad,
          };
          
          for (int i = 0; i < 3; i++) {
            if (dims[i] < min) {
              min = dims[i];
              dim = i;
            }
          }
          
          switch (dim) {
            case 0:
              if (hit.dir.x == 0) hit.dir.add(new Vec4(-dims[0], 0, 0, 0));
              break;
            case 1:
              if (hit.dir.x == 0) hit.dir.add(new Vec4(dims[1], 0, 0, 0));
              break;
            case 2:
              hit.dir.add(new Vec4(0, dims[2], 0, 0));
              break;
          }
        } if (doorHit) {
          float min = MAX_FLOAT;
          int dim = -1;
          float[] dims = {
            playerPos.x - pos.x + playerRad, 
            thickness.x - playerPos.x + pos.x + playerRad,
          };
          
          for (int i = 0; i < 2; i++) {
            if (dims[i] < min) {
              min = dims[i];
              dim = i;
            }
          }
          
          switch (dim) {
            case 0:
              if (hit.dir.x == 0) hit.dir.add(new Vec4(-dims[0], 0, 0, 0));
              break;
            case 1:
              if (hit.dir.x == 0) hit.dir.add(new Vec4(dims[1], 0, 0, 0));
              break;
          }
        } if (closeHit) {
          float min = MAX_FLOAT;
          int dim = -1;
          float[] dims = {
            playerPos.x - pos.x + playerRad, 
            thickness.x - playerPos.x + pos.x + playerRad,
            doorPos.z - playerPos.z + playerRad,
          };
          
          for (int i = 0; i < 3; i++) {
            if (dims[i] < min) {
              min = dims[i];
              dim = i;
            }
          }
          
          switch (dim) {
            case 0:
              if (hit.dir.x == 0) hit.dir.add(new Vec4(-dims[0], 0, 0, 0));
              break;
            case 1:
              if (hit.dir.x == 0) hit.dir.add(new Vec4(dims[1], 0, 0, 0));
              break;
            case 2:
              hit.dir.add(new Vec4(0, 0, dims[2], 0));
              break;
          }
        } if (farHit) {
          float min = MAX_FLOAT;
          int dim = -1;
          float[] dims = {
            playerPos.x - pos.x + playerRad, 
            thickness.x - playerPos.x + pos.x + playerRad,
            playerPos.z - doorPos.z - doorThickness.z + playerRad,
          };
          
          for (int i = 0; i < 3; i++) {
            if (dims[i] < min) {
              min = dims[i];
              dim = i;
            }
          }
          
          switch (dim) {
            case 0:
              if (hit.dir.x == 0) hit.dir.add(new Vec4(-dims[0], 0, 0, 0));
              break;
            case 1:
              if (hit.dir.x == 0) hit.dir.add(new Vec4(dims[1], 0, 0, 0));
              break;
            case 2:
              hit.dir.add(new Vec4(0, 0, -dims[2], 0));
              break;
          }
        }
      }
    }
    
    return hit;
  }
  
  //hitInfo collide(Vec4 playerPos) {
  //  hitInfo hit = new hitInfo();
    
  //  Vec4 dir = Vec4.sub(playerPos, pos);
    
  //  /// WHAT?? playerRad wrong, but works
  //  hit.hit = dir.x < thickness.x + playerRad && dir.x > -playerRad &&
  //            dir.y < thickness.y + playerRad && dir.y > -playerRad &&
  //            dir.z < thickness.z + playerRad && dir.z > -playerRad &&
  //            dir.w < thickness.w + playerRad && dir.w > -playerRad;
    
  //  Vec4 dirDoor, doorPosBetter;
  //  try {
  //    doorPosBetter = Vec4.copy(doorPos);
  //    doorPosBetter.set(orien, pos.get(orien));
  //    dirDoor = Vec4.sub(playerPos, doorPosBetter);
  //  } catch (Exception e) {
  //    return hit;
  //  }
    
  //  boolean doorHit = 
  //    dirDoor.x < doorThickness.x + playerRad && dirDoor.x > -playerRad &&
  //    dirDoor.y < doorThickness.y + playerRad && dirDoor.y > -playerRad &&
  //    dirDoor.z < doorThickness.z + playerRad && dirDoor.z > - playerRad &&
  //    dirDoor.w < doorThickness.w && dirDoor.w > 0;
           
  //  hit.hit &= !doorHit;
    
    
              
  //  //println("ww", hit.hit, playerPos, doorPosBetter, dirDoor, doorThickness);
  //  //println(hit.hit, doorHit);
  //  if (hit.hit) {
  //    int dim = -1;
  //    float min = MAX_FLOAT;
  //    float[] dims = {
  //      playerPos.x - pos.x + playerRad, thickness.x - playerPos.x + pos.x + playerRad,
  //      playerPos.y - pos.y + playerRad, thickness.y - playerPos.y + pos.y + playerRad,
  //      playerPos.z - pos.z + playerRad, thickness.z - playerPos.z + pos.z + playerRad,
  //      playerPos.w - pos.w + playerRad, thickness.w - playerPos.w + pos.w + playerRad,
  //    };
      
  //    float[] dims2 = {
  //      MAX_FLOAT, MAX_FLOAT,
  //      MAX_FLOAT, MAX_FLOAT,
  //      MAX_FLOAT, MAX_FLOAT,
  //      MAX_FLOAT, MAX_FLOAT,
  //    };
  //    switch (orien) {
  //      case 0:
  //        float[] temp1 = {
  //          MAX_FLOAT, MAX_FLOAT,
  //          abs(playerPos.y - doorPos.y + playerRad), abs(doorThickness.y - playerPos.y + doorPos.y + playerRad),
  //          abs(playerPos.z - doorPos.z - playerRad), abs(doorThickness.z - playerPos.z + doorPos.z - playerRad),
  //          abs(playerPos.w - doorPos.w + playerRad), abs(doorThickness.w - playerPos.w + doorPos.w + playerRad),
  //        };
  //        dims2 = temp1;
  //        break;
  //      case 1:
  //        float[] temp2 = {
  //          abs(playerPos.x - doorPos.x + playerRad), abs(doorThickness.x - playerPos.x + doorPos.x + playerRad),
  //          MAX_FLOAT, MAX_FLOAT,
  //          abs(playerPos.z - doorPos.z + playerRad), abs(doorThickness.z - playerPos.z + doorPos.z + playerRad),
  //          abs(playerPos.w - doorPos.w + playerRad), abs(doorThickness.w - playerPos.w + doorPos.w + playerRad),
  //        };
  //        dims2 = temp2;
  //        break;
  //      case 2:
  //        float[] temp3 = {
  //          abs(playerPos.x - doorPos.x + playerRad), abs(doorThickness.x - playerPos.x + doorPos.x + playerRad),
  //          abs(playerPos.y - doorPos.y + playerRad), abs(doorThickness.y - playerPos.y + doorPos.y + playerRad),
  //          MAX_FLOAT, MAX_FLOAT,
  //          abs(playerPos.w - doorPos.w + playerRad), abs(doorThickness.w - playerPos.w + doorPos.w + playerRad),
  //        };
  //        dims2 = temp3;
  //        break;
  //      case 3:
  //        float[] temp4 = {
  //          abs(playerPos.x - doorPos.x + playerRad), abs(doorThickness.x - playerPos.x + doorPos.x + playerRad),
  //          abs(playerPos.y - doorPos.y + playerRad), abs(doorThickness.y - playerPos.y + doorPos.y + playerRad),
  //          abs(playerPos.z - doorPos.z + playerRad), abs(doorThickness.z - playerPos.z + doorPos.z + playerRad),
  //          MAX_FLOAT, MAX_FLOAT,
  //        };
  //        dims2 = temp4;
  //        break;
  //    }
      
  //    for (int i = 0; i < 8; i++) {
  //      if (dims[i] < min) {
  //        min = dims[i];
  //        dim = i;
  //      }
  //    }
      
  //    for (int i = 0; i < 8; i++) {
  //      if (dims2[i] < min) {
  //        min = dims2[i];
  //        dim = i + 8;
  //      }
  //    }
  //    println("a", dim);
  //    println(dims2);
      
  //    switch (dim) {
  //      case 0:
  //        hit.dir = new Vec4(-dims[0], 0, 0, 0);
  //        break;
  //      case 1:
  //        hit.dir = new Vec4(dims[1], 0, 0, 0);
  //        break;
  //      case 2:
  //        hit.dir = new Vec4(0, -dims[2], 0, 0);
  //        break;
  //      case 3:
  //        hit.dir = new Vec4(0, dims[3], 0, 0);
  //        break;
  //      case 4:
  //        hit.dir = new Vec4(0, 0, -dims[4], 0);
  //        break;
  //      case 5:
  //        hit.dir = new Vec4(0, 0, dims[5], 0);
  //        break;
  //      case 6:
  //        hit.dir = new Vec4(0, 0, 0, -dims[6]);
  //        break;
  //      case 7:
  //        hit.dir = new Vec4(0, 0, 0, dims[7]);
  //        break;
  //      case 8:
  //        hit.dir = new Vec4(dims2[1], 0, 0, 0);
  //        break;
  //      case 9:
  //        hit.dir = new Vec4(-dims2[1], 0, 0, 0);
  //        break;
  //      case 10:
  //        hit.dir = new Vec4(0, -dims2[2], 0, 0);
  //        break;
  //      case 11:
  //        hit.dir = new Vec4(0, dims2[3], 0, 0);
  //        break;
  //      case 12:
  //        hit.dir = new Vec4(0, 0, dims2[4], 0);
  //        break;
  //      case 13:
  //        hit.dir = new Vec4(0, 0, -dims2[5], 0);
  //        break;
  //      case 14:
  //        hit.dir = new Vec4(0, 0, 0, dims2[6]);
  //        break;
  //      case 15:
  //        hit.dir = new Vec4(0, 0, 0, -dims2[7]);
  //        break;
  //    }
  //  }
    
  //  //hit.hit = false;
  //  println(hit.dir);
  //  return hit;
  //}
  
  void Draw(float w) {
    
    switch (orien) {
      case 0:
        if (w < (pos.w + thickness.w) && w > pos.w) {
          // Close to wall pos
          pushMatrix();
          fill(c);
          translate(pos.x + thickness.x/2, pos.y + thickness.y/2, pos.z + (doorPos.z - pos.z)/2);
          box(thickness.x, thickness.y, doorPos.z - pos.z);
          popMatrix();
          
          // Far from wall pos
          pushMatrix();
          fill(c);
          translate(pos.x + thickness.x/2, pos.y + thickness.y/2, (pos.z + thickness.z + doorPos.z + doorThickness.z)/2);
          box(thickness.x, thickness.y, thickness.z - doorThickness.z - doorPos.z + pos.z);
          popMatrix();
          
          // Above door
          pushMatrix();
          fill(c);
          translate(pos.x + thickness.x/2, (pos.y + doorPos.y)/2, doorPos.z + doorThickness.z/2);
          box(thickness.x, doorPos.y - pos.y, doorThickness.z);
          popMatrix();
          
          if (w > (doorPos.w + doorThickness.w) || w < doorPos.w) {
            // Door
            pushMatrix();
            fill(#111111);
            translate(pos.x + thickness.x/2, doorPos.y + doorThickness.y/2, doorPos.z + doorThickness.z/2);
            box(thickness.x, doorThickness.y, doorThickness.z);
            popMatrix();
          }
        }
        break;
      case 1:
        if (w < (pos.w + thickness.w) && w > pos.w) {
          // Close to wall pos
          pushMatrix();
          fill(c);
          translate(pos.x + thickness.x/2, pos.y + thickness.y/2, pos.z + (doorPos.z - pos.z)/2);
          box(thickness.x, thickness.y, doorPos.z - pos.z);
          popMatrix();
          
          // Far from wall pos
          pushMatrix();
          fill(c);
          translate(pos.x + thickness.x/2, pos.y + thickness.y/2, (pos.z + thickness.z + doorPos.z + doorThickness.z)/2);
          box(thickness.x, thickness.y, thickness.z - doorThickness.z - doorPos.z + pos.z);
          popMatrix();
          
          // Above door
          pushMatrix();
          fill(c);
          translate((pos.x + doorPos.x)/2, pos.y + thickness.y/2, doorPos.z + doorThickness.z/2);
          box(doorPos.x - pos.x, thickness.y, doorThickness.z);
          popMatrix();
          
          // Below door
          pushMatrix();
          fill(c);
          translate((pos.x + thickness.x + doorPos.x + doorThickness.x)/2, pos.y + thickness.y/2, doorPos.z + doorThickness.z/2);
          box(thickness.x - doorThickness.x - doorPos.x + pos.x, thickness.y, doorThickness.z);
          popMatrix();
            
          
          if (w > (doorPos.w + doorThickness.w) || w < doorPos.w) {
            // Door
            pushMatrix();
            fill(#111111);
            translate(doorPos.x + doorThickness.x/2, pos.y + thickness.y/2, doorPos.z + doorThickness.z/2);
            box(doorThickness.x, thickness.y, doorThickness.z);
            popMatrix();
          }
        }
        break;
      case 2:
        if (w < (pos.w + thickness.w) && w > pos.w) {
          // Close to wall pos
          pushMatrix();
          fill(c);
          translate(pos.x + (doorPos.x - pos.x)/2, pos.y + thickness.y/2, pos.z + thickness.z/2);
          box(doorPos.x - pos.x, thickness.y, thickness.z);
          popMatrix();
          
          // Far from wall pos
          pushMatrix();
          fill(c);
          translate((pos.x + thickness.x + doorPos.x + doorThickness.x)/2, pos.y + thickness.y/2, pos.z + thickness.z/2);
          box(thickness.x - doorThickness.x - doorPos.x + pos.x, thickness.y, thickness.z);
          popMatrix();
          
          // Above door
          pushMatrix();
          fill(c);
          translate(doorPos.x + doorThickness.x/2, (pos.y + doorPos.y)/2, pos.z + thickness.z/2);
          box(doorThickness.x, doorPos.y - pos.y, thickness.z);
          popMatrix();
          
          if (w > (doorPos.w + doorThickness.w) || w < doorPos.w) {
            // Door
            pushMatrix();
            fill(#111111);
            translate(doorPos.x + doorThickness.x/2, doorPos.y + doorThickness.y/2, pos.z + thickness.z/2);
            box(doorThickness.x, doorThickness.y, thickness.z);
            popMatrix();
          }
        }
        break;
      case 3:
        if (w < (pos.w + thickness.w) && w > pos.w) {
          // Door box
          pushMatrix();
          fill(c);
          noStroke();
          translate(doorPos.x + doorThickness.x/2, doorPos.y + doorThickness.y/2 + padding/2, doorPos.z + doorThickness.z/2);
          box(doorThickness.x, doorThickness.y + padding, doorThickness.z);
          popMatrix();
        } else {
          // Door wireframe
          pushMatrix();
          noFill();
          stroke(c);
          strokeWeight(10);
          translate(doorPos.x + doorThickness.x/2, doorPos.y + doorThickness.y/2, doorPos.z + doorThickness.z/2);
          box(doorThickness.x, doorThickness.y, doorThickness.z);
          popMatrix();
        }
        
        
        noStroke();
    }
  }
}
