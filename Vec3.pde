// Vector Library
// Vector 3 Library
//
// Based off of
// CSCI 5611 Vector 2 Library [Example]
// Stephen J. Guy <sjguy@umn.edu>

public static class Vec3 {
  public float x, y, z;
  
  public Vec3(){
    this.x = 0;
    this.y = 0;
    this.z = 0;
  }
  
  public Vec3(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public String toString(){
    return "(" + x+ "," + y + "," + z + ")";
  }
  
  public float length(){
    return sqrt(x*x+y*y+z*z);
  }
  
  public float lengthSqr(){
    return x*x+y*y+z*z;
  }
  
  public static Vec3 add(Vec3 rhs, Vec3 lhs) {
    return new Vec3(rhs.x+lhs.x, rhs.y+lhs.y, rhs.z+lhs.z);
  }
  
  public void add(Vec3 rhs){
    x += rhs.x;
    y += rhs.y;
    z += rhs.z;
  }
  
  public static Vec3 sub(Vec3 rhs, Vec3 lhs){
    return new Vec3(rhs.x-lhs.x, rhs.y-lhs.y, rhs.z-lhs.z);
  }
  
  public void sub(Vec3 rhs){
    x -= rhs.x;
    y -= rhs.y;
    z -= rhs.z;
  }
  
  public static Vec3 mul(Vec3 rhs, float scalar){
    return new Vec3(rhs.x*scalar, rhs.y*scalar, rhs.z*scalar);
  }
  
  public void mul(float scalar){
    x *= scalar;
    y *= scalar;
    z *= scalar;
  }
  
  public void clamp(float minL, float maxL){
    // Max
    if (x > maxL){
      x = maxL;
    }
    if (y > maxL){
      y = maxL;
    }
    if (z > maxL){
      z = maxL;
    }
    
    // Min
    if (x < minL){
      x = minL;
    }
    if (y < minL){
      y = minL;
    }
    if (z < minL){
      z = minL;
    }
  }
  
  public void clampToLength(float maxL){
    float magnitude = sqrt(x*x + y*y + z*z);
    if (magnitude > maxL){
      x *= maxL/magnitude;
      y *= maxL/magnitude;
      z *= maxL/magnitude;
    }
  }
  
  public void setToLength(float newL){
    float magnitude = sqrt(x*x + y*y + z*z);
    x *= newL/magnitude;
    y *= newL/magnitude;
    z *= newL/magnitude;
  }
  
  public void normalize(){
    float magnitude = sqrt(x*x + y*y + z*z);
    if (magnitude == 0) {
      x = 0;
      y = 0;
      z = 0;
    } else {
      x /= magnitude;
      y /= magnitude;
      z /= magnitude;
    }
  }
  
  public Vec3 normalized(){
    float magnitude = sqrt(x*x + y*y + z*z);
    if (magnitude == 0) return new Vec3(0, 0, 0);
    else return new Vec3(x/magnitude, y/magnitude, z/magnitude);
  }
  
  public float distanceTo(Vec3 rhs){
    float dx = rhs.x - x;
    float dy = rhs.y - y;
    float dz = rhs.z - z;
    return sqrt(dx*dx + dy*dy + dz*dz);
  }
}

Vec3 interpolate(Vec3 a, Vec3 b, float t){
  return Vec3.add(a, (Vec3.mul(Vec3.sub(b, a), t)));
}

float interpolate(float a, float b, float t){
  return a + ((b-a)*t);
}

float dot(Vec3 a, Vec3 b){
  return a.x*b.x + a.y*b.y + a.z*b.z;
}

Vec3 projAB(Vec3 a, Vec3 b){
  return Vec3.mul(b, (a.x*b.x + a.y*b.y + a.z*b.z));
}

Vec3 cross(Vec3 a, Vec3 b){
  return new Vec3(a.y*b.z - a.z*b.y, a.x*b.z - a.z*b.x, a.x*b.y - a.y*b.x);
}
