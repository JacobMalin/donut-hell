// Vector Library
// Vector 4 Library
//
// Based off of
// CSCI 5611 Vector 2 Library [Example]
// Stephen J. Guy <sjguy@umn.edu>

public static class Vec4 {
  public float x, y, z;
  
  public Vec4(){
  }
  
  public Vec4(float x, float y, float z, float w){
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
  
  public static Vec4 add(Vec4 rhs, Vec4 lhs) {
    return new Vec4(rhs.x+lhs.x, rhs.y+lhs.y, rhs.z+lhs.z,0);//FIx
  }
  
  public void add(Vec4 rhs){
    x += rhs.x;
    y += rhs.y;
    z += rhs.z;
  }
  
  public static Vec4 sub(Vec4 rhs, Vec4 lhs){
    return new Vec4(rhs.x-lhs.x, rhs.y-lhs.y, rhs.z-lhs.z,0);//FIx
  }
  
  public void sub(Vec4 rhs){
    x -= rhs.x;
    y -= rhs.y;
    z -= rhs.z;
  }
  
  public static Vec4 mul(Vec4 rhs, float scalar){
    return new Vec4(rhs.x*scalar, rhs.y*scalar, rhs.z*scalar,0);//FIx
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
  
  public Vec4 normalized(){
    float magnitude = sqrt(x*x + y*y + z*z);
    if (magnitude == 0) return new Vec4(0, 0, 0,0);//FIx
    else return new Vec4(x/magnitude, y/magnitude, z/magnitude,0);//FIx
  }
  
  public float distanceTo(Vec4 rhs){
    float dx = rhs.x - x;
    float dy = rhs.y - y;
    float dz = rhs.z - z;
    return sqrt(dx*dx + dy*dy + dz*dz);
  }
}

Vec4 interpolate(Vec4 a, Vec4 b, float t){
  return Vec4.add(a, (Vec4.mul(Vec4.sub(b, a), t)));
}
float dot(Vec4 a, Vec4 b){
  return a.x*b.x + a.y*b.y + a.z*b.z;
}

Vec4 projAB(Vec4 a, Vec4 b){
  return Vec4.mul(b, (a.x*b.x + a.y*b.y));
}

Vec4 cross(Vec4 a, Vec4 b){
  return new Vec4(a.y*b.z - a.z*b.y, a.x*b.z - a.z*b.x, a.x*b.y - a.y*b.x, 0); //FIx
}
