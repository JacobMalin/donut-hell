// inner_wall.pde

float spacer = 0.1; // Prevent w walls from appearing when not inside

class InnerWall {
  color c;
  Vec4 pos, thickness;
  int orien;
  Vec4 doorPos;
  Vec4 KDPos, KDThickness;

  public InnerWall(Vec4 pos, Vec4 thickness, color c, int orien, Vec4 doorPos, Vec4 KDPos, Vec4 KDThickness) {
    this.pos = pos;
    this.thickness = thickness;
    this.c = c;
    this.orien = orien;
    this.doorPos = doorPos;
    this.KDPos = KDPos;
    this.KDThickness = KDThickness;
  }
  
  public String toString() {
    return "InnerWall(" + pos + "," + thickness + ")";
  }
  
  hitInfo collide(Vec4 playerPos) {
    hitInfo hit = new hitInfo();
    
    Vec4 dir = Vec4.sub(playerPos, pos);
    
    boolean topHit, bottomHit, closeHit, farHit, doorCloseHit, doorFarHit;
    switch (orien) {
      case 0:
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
                   
        // Door close to pos
        doorCloseHit =
                   dir.x < thickness.x + playerRad && dir.x > -playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                   dir.z < doorPos.z - pos.z + doorThickness.z + playerRad && dir.z > doorPos.z - pos.z - playerRad &&
                   dir.w < doorPos.w - pos.w + playerRad && dir.w > -playerRad;
                   
        // Door far from pos
        doorFarHit =
                   dir.x < thickness.x + playerRad && dir.x > -playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                   dir.z < doorPos.z - pos.z + doorThickness.z + playerRad && dir.z > doorPos.z - pos.z - playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > doorPos.w - pos.w + doorThickness.w - playerRad;
        
        hit.hit = topHit || closeHit || farHit || doorCloseHit || doorFarHit;
        
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
          }
          if (closeHit) {
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
          }
          if (farHit) {
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
          if (doorCloseHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.x - pos.x + playerRad, 
              thickness.x - playerPos.x + pos.x + playerRad,
              doorPos.w - playerPos.w + playerRad,
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
                hit.dir.add(new Vec4(0, 0, 0, dims[2]));
                break;
            }
          } 
          if (doorFarHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.x - pos.x + playerRad, 
              thickness.x - playerPos.x + pos.x + playerRad,
              playerPos.w - doorPos.w - doorThickness.w + playerRad,
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
                hit.dir.add(new Vec4(0, 0, 0, -dims[2]));
                break;
                
            }
          }
        }
        break;
      case 1:
        // Top, close to pos
        topHit   = dir.x < doorPos.x - pos.x + playerRad && dir.x > -playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > -playerRad &&
                   dir.z < thickness.z + playerRad && dir.z > -playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > -playerRad;
                   
        // Bottom, far from pos
        bottomHit =
                   dir.x < thickness.x + playerRad && dir.x > doorPos.x - pos.x + doorThickness.x - playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > -playerRad &&
                   dir.z < thickness.z + playerRad && dir.z > -playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > -playerRad;
        
        // Close to pos
        closeHit = dir.x < doorPos.x - pos.x + doorThickness.x + playerRad && dir.x > doorPos.x - pos.x + playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > -playerRad &&
                   dir.z < doorPos.z - pos.z + playerRad && dir.z > -playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > -playerRad;
        
        // Far from pos
        farHit   = dir.x < doorPos.x - pos.x + doorThickness.x + playerRad && dir.x > doorPos.x - pos.x + playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > -playerRad &&
                   dir.z < thickness.z + playerRad && dir.z > doorPos.z - pos.z + doorThickness.z - playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > -playerRad;
                   
        // Door close to pos
        doorCloseHit =
                   dir.x < doorPos.x - pos.x + doorThickness.x - playerRad && dir.x > doorPos.x - pos.x + playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > -playerRad &&
                   dir.z < doorPos.z - pos.z + doorThickness.z + playerRad && dir.z > doorPos.z - pos.z - playerRad &&
                   dir.w < doorPos.w - pos.w + playerRad && dir.w > -playerRad;
                   
        // Door far from pos
        doorFarHit =
                   dir.x < doorPos.x - pos.x + doorThickness.x - playerRad && dir.x > doorPos.x - pos.x + playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > -playerRad &&
                   dir.z < doorPos.z - pos.z + doorThickness.z + playerRad && dir.z > doorPos.z - pos.z - playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > doorPos.w - pos.w + doorThickness.w - playerRad;
        
        hit.hit = topHit || bottomHit || closeHit || farHit || doorCloseHit || doorFarHit;
        //println(hit.hit, topHit, bottomHit, closeHit, farHit, doorCloseHit, doorFarHit);
        
        if (hit.hit) {
          if (topHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              doorPos.x - playerPos.x + playerRad,
              playerPos.y - pos.y + playerRad, 
              thickness.y - playerPos.y + pos.y + playerRad,
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                hit.dir.add(new Vec4(dims[0], 0, 0, 0));
                break;
              case 1:
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0,-dims[1],  0, 0));
                break;
              case 2:
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0, dims[2], 0, 0));
                break;
            }
          }
          if (bottomHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.x - doorPos.x - doorThickness.x + playerRad,
              playerPos.y - pos.y + playerRad, 
              thickness.y - playerPos.y + pos.y + playerRad,
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                hit.dir.add(new Vec4(-dims[0], 0, 0, 0));
                break;
              case 1:
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0,-dims[1],  0, 0));
                break;
              case 2:
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0, dims[2], 0, 0));
                break;
            }
          }
          if (closeHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.y - pos.y + playerRad,
              thickness.y - playerPos.y + pos.y + playerRad,
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
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0, -dims[0], 0, 0));
                break;
              case 1:
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0, dims[1], 0, 0));
                break;
              case 2:
                hit.dir.add(new Vec4(0, 0, dims[2], 0));
                break;
            }
          }
          if (farHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.y - pos.y + playerRad, 
              thickness.y - playerPos.y + pos.y + playerRad,
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
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0, -dims[0], 0, 0));
                break;
              case 1:
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0, dims[1], 0, 0));
                break;
              case 2:
                hit.dir.add(new Vec4(0, 0, -dims[2], 0));
                break;
            }
          }
          if (doorCloseHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.y - pos.y + playerRad, 
              thickness.y - playerPos.y + pos.y + playerRad,
              doorPos.w - playerPos.w + playerRad, // Pass this into bar
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0, -dims[0], 0, 0));
                break;
              case 1:
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0, dims[1], 0, 0));
                break;
              case 2:
                hit.dir.add(new Vec4(0, 0, 0, dims[2]));
                break;
            }
          }
          if (doorFarHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.y - pos.y + playerRad, 
              thickness.y - playerPos.y + pos.y + playerRad,
              playerPos.w - doorPos.w - doorThickness.w + playerRad, // Pass this into bar
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0, -dims[0], 0, 0));
                break;
              case 1:
                if (hit.dir.y == 0) hit.dir.add(new Vec4(0, dims[1], 0, 0));
                break;
              case 2:
                hit.dir.add(new Vec4(0, 0, 0, -dims[2]));
                break;
                
            }
          }
        }
        break;
      case 2:
        // Top
        topHit   = dir.x < thickness.x + playerRad && dir.x > -playerRad &&
                   dir.y < thickness.y - doorThickness.y + playerRad && dir.y > -playerRad &&
                   dir.z < thickness.z + playerRad && dir.z > -playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > -playerRad;
        
        // Close to pos
        closeHit = dir.z < thickness.z + playerRad && dir.z > -playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                   dir.x < doorPos.x - pos.x + playerRad && dir.x > -playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > -playerRad;
        
        // Far from pos
        farHit   = dir.z < thickness.z + playerRad && dir.z > -playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                   dir.x < thickness.x + playerRad && dir.x > doorPos.x - pos.x + doorThickness.x - playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > -playerRad;
                   
        // Door close to pos
        doorCloseHit = 
                   dir.x < doorPos.x - pos.x + doorThickness.x + playerRad && dir.x > doorPos.x - pos.x - playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                   dir.z < thickness.z + playerRad && dir.z > -playerRad &&
                   dir.w < doorPos.w - pos.w + playerRad && dir.w > -playerRad;
                   
        // Door far from pos
        doorFarHit = 
                   dir.x < doorPos.x - pos.x + doorThickness.x + playerRad && dir.x > doorPos.x - pos.x - playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                   dir.z < thickness.z + playerRad && dir.z > -playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > doorPos.w - pos.w + doorThickness.w - playerRad;
        
        hit.hit = topHit || closeHit || farHit || doorCloseHit || doorFarHit;
        
        if (hit.hit) {
          if (topHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              thickness.y - doorThickness.y - playerPos.y + pos.y + playerRad,
              playerPos.z - pos.z + playerRad, 
              thickness.z - playerPos.z + pos.z + playerRad,
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                hit.dir.add(new Vec4(0, dims[0], 0, 0));
                break;
              case 1:
                if (hit.dir.z == 0) hit.dir.add(new Vec4(0, 0, -dims[1], 0));
                break;
              case 2:
                if (hit.dir.z == 0) hit.dir.add(new Vec4(0, 0, dims[2], 0));
                break;
            }
          }
          if (closeHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              doorPos.x - playerPos.x + playerRad,
              playerPos.z - pos.z + playerRad, 
              thickness.z - playerPos.z + pos.z + playerRad,
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                hit.dir.add(new Vec4(dims[0], 0, 0, 0));
                break;
              case 1:
                if (hit.dir.z == 0) hit.dir.add(new Vec4(0, 0, -dims[1], 0));
                break;
              case 2:
                if (hit.dir.z == 0) hit.dir.add(new Vec4(0, 0, dims[2], 0));
                break;
            }
          } if (farHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.x - doorPos.x - doorThickness.x + playerRad,
              playerPos.z - pos.z + playerRad, 
              thickness.z - playerPos.z + pos.z + playerRad,
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                hit.dir.add(new Vec4(-dims[0], 0, 0, 0));
                break;
              case 1:
                if (hit.dir.z == 0) hit.dir.add(new Vec4(0, 0, -dims[1], 0));
                break;
              case 2:
                if (hit.dir.z == 0) hit.dir.add(new Vec4(0, 0, dims[2], 0));
                break;
            }
          }
          if (doorCloseHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.z - pos.z + playerRad, 
              thickness.z - playerPos.z + pos.z + playerRad,
              doorPos.w - playerPos.w + playerRad, // Pass this into bar
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                if (hit.dir.z == 0) hit.dir.add(new Vec4(0, 0, -dims[0], 0));
                break;
              case 1:
                if (hit.dir.z == 0) hit.dir.add(new Vec4(0, 0, dims[1], 0));
                break;
              case 2:
                hit.dir.add(new Vec4(0, 0, 0, dims[2]));
                break;
            }
          } 
          if (doorFarHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.z - pos.z + playerRad, 
              thickness.z - playerPos.z + pos.z + playerRad,
              playerPos.w - doorPos.w - doorThickness.w + playerRad, // Pass this into bar
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                if (hit.dir.z == 0) hit.dir.add(new Vec4(0, 0, -dims[0], 0));
                break;
              case 1:
                if (hit.dir.z == 0) hit.dir.add(new Vec4(0, 0, dims[1], 0));
                break;
              case 2:
                hit.dir.add(new Vec4(0, 0, 0, -dims[2]));
                break;
                
            }
          }
        }
        break;
      case 3:
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
                   
        // Door close to pos
        doorCloseHit =
                   dir.x < doorPos.x - pos.x + playerRad && dir.x > -playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                   dir.z < doorPos.z - pos.z + doorThickness.z + playerRad && dir.z > doorPos.z - pos.z - playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > -playerRad;
                   
        // Door far from pos
        doorFarHit =
                   dir.x < thickness.x + playerRad && dir.x > doorPos.x - pos.x + doorThickness.x - playerRad &&
                   dir.y < thickness.y + playerRad && dir.y > thickness.y - doorThickness.y - playerRad &&
                   dir.z < doorPos.z - pos.z + doorThickness.z + playerRad && dir.z > doorPos.z - pos.z - playerRad &&
                   dir.w < thickness.w + playerRad && dir.w > -playerRad;
        
        hit.hit = topHit || closeHit || farHit || doorCloseHit || doorFarHit;
        
        if (hit.hit) {
          if (topHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              thickness.y - doorThickness.y - playerPos.y + pos.y + playerRad,
              playerPos.w - pos.w + playerRad, 
              thickness.w - playerPos.w + pos.w + playerRad,
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                hit.dir.add(new Vec4(0, dims[0], 0, 0));
                break;
              case 1:
                if (hit.dir.w == 0) hit.dir.add(new Vec4(0, 0, 0, -dims[1]));
                break;
              case 2:
                if (hit.dir.w == 0) hit.dir.add(new Vec4(0, 0, 0, dims[2]));
                break;
            }
          }
          if (closeHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              doorPos.z - playerPos.z + playerRad,
              playerPos.w - pos.w + playerRad, 
              thickness.w - playerPos.w + pos.w + playerRad,
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                hit.dir.add(new Vec4(0, 0, dims[0], 0));
                break;
              case 1:
                if (hit.dir.w == 0) hit.dir.add(new Vec4(0, 0, 0, -dims[1]));
                break;
              case 2:
                if (hit.dir.w == 0) hit.dir.add(new Vec4(0, 0, 0, dims[2]));
                break;
            }
          }
          if (farHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.z - doorPos.z - doorThickness.z + playerRad,
              playerPos.w - pos.w + playerRad, 
              thickness.w - playerPos.w + pos.w + playerRad,
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                hit.dir.add(new Vec4(0, 0, -dims[0], 0));
                break;
              case 1:
                if (hit.dir.w == 0) hit.dir.add(new Vec4(0, 0, 0, -dims[1]));
                break;
              case 2:
                if (hit.dir.w == 0) hit.dir.add(new Vec4(0, 0, 0, dims[2]));
                break;
            }
          }
          if (doorCloseHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              doorPos.x - playerPos.x + playerRad,
              playerPos.w - pos.w + playerRad,
              thickness.w - playerPos.w + pos.w + playerRad,
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                hit.dir.add(new Vec4(dims[0], 0, 0, 0));
                break;
              case 1:
                if (hit.dir.w == 0) hit.dir.add(new Vec4(0, 0, 0, -dims[1]));
                break;
              case 2:
                if (hit.dir.w == 0) hit.dir.add(new Vec4(0, 0, 0, dims[2]));
                break;
            }
          } 
          if (doorFarHit) {
            float min = MAX_FLOAT;
            int dim = -1;
            float[] dims = {
              playerPos.x - doorPos.x - doorThickness.x + playerRad,
              playerPos.w - pos.w + playerRad,
              thickness.w - playerPos.w + pos.w + playerRad,
            };
            
            for (int i = 0; i < 3; i++) {
              if (dims[i] < min) {
                min = dims[i];
                dim = i;
              }
            }
            
            switch (dim) {
              case 0:
                hit.dir.add(new Vec4(-dims[0], 0, 0, 0));
                break;
              case 1:
                if (hit.dir.w == 0) hit.dir.add(new Vec4(0, 0, 0, -dims[1]));
                break;
              case 2:
                if (hit.dir.w == 0) hit.dir.add(new Vec4(0, 0, 0, dims[2]));
                break;
            }
          }
        }
        break;
    }
    
    //hit.hit = false;
    return hit;
  }
  
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
          
          if (w > (doorPos.w + doorThickness.w - playerRad) || w < doorPos.w + playerRad) {
            // Door
            pushMatrix();
            fill(c);
            if (isWireframe) stroke(wireframe);
            else noStroke();
            if (scene == 0) strokeWeight(menuWireframeWeight);
            else strokeWeight(wireframeWeight);
            translate(pos.x + thickness.x/2, doorPos.y + doorThickness.y/2, doorPos.z + doorThickness.z/2);
            box(thickness.x, doorThickness.y, doorThickness.z);
            popMatrix();
            
            noStroke();
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
            
          
          if (w > (doorPos.w + doorThickness.w - playerRad) || w < doorPos.w + playerRad) {
            // Door
            pushMatrix();
            fill(c);
            if (isWireframe) stroke(wireframe);
            else noStroke();
            if (scene == 0) strokeWeight(menuWireframeWeight);
            else strokeWeight(wireframeWeight);
            translate(doorPos.x + doorThickness.x/2, pos.y + thickness.y/2, doorPos.z + doorThickness.z/2);
            box(doorThickness.x, thickness.y, doorThickness.z);
            popMatrix();
            
            noStroke();
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
          
          if (w > (doorPos.w + doorThickness.w - playerRad) || w < doorPos.w + playerRad) {
            // Door
            pushMatrix();
            fill(c);
            if (isWireframe) stroke(wireframe);
            else noStroke();
            if (scene == 0) strokeWeight(menuWireframeWeight);
            else strokeWeight(wireframeWeight);
            translate(doorPos.x + doorThickness.x/2, doorPos.y + doorThickness.y/2, pos.z + thickness.z/2);
            box(doorThickness.x, doorThickness.y, thickness.z);
            popMatrix();
            
            noStroke();
          }
        }
        break;
      case 3:
        if (w < (pos.w + thickness.w + playerRad - spacer) && w > pos.w - playerRad + spacer) {
          // Door box
          pushMatrix();
          fill(c);
          noStroke();
          translate(doorPos.x + doorThickness.x/2, doorPos.y + doorThickness.y/2 + wallRad.y/2, doorPos.z + doorThickness.z/2);
          box(doorThickness.x, doorThickness.y + wallRad.y, doorThickness.z);
          popMatrix();
          
          if (scene == 0) {
            // Wall box
            pushMatrix();
            fill(c);
            noStroke();
            translate(KDPos.x + KDThickness.x/2, KDPos.y + KDThickness.y/2 + wallRad.y/2, KDPos.z + KDThickness.z/2);
            box(KDThickness.x, KDThickness.y + wallRad.y, KDThickness.z);
            popMatrix();
          }
        } else if (w < (KDPos.w + KDThickness.w) && w > KDPos.w && isWireframe) {
          // Door wireframe
          pushMatrix();
          noFill();
          stroke(wireframe);
          if (scene == 0) strokeWeight(menuWireframeWeight);
          else strokeWeight(wireframeWeight);
          translate(doorPos.x + doorThickness.x/2, doorPos.y + doorThickness.y/2, doorPos.z + doorThickness.z/2);
          box(doorThickness.x, doorThickness.y, doorThickness.z);
          popMatrix();
        }
        
        noStroke();
    }
  }
}
