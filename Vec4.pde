// Vector Library
// Vector 4 Library
//
// Based off of
// CSCI 5611 Vector 2 Library [Example]
// Stephen J. Guy <sjguy@umn.edu>

public static class Vec4 {
  public float x, y, z, w;
  
  public Vec4(){
  }
  
  public Vec4(float x, float y, float z, float w){
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
  }
  
  public static Vec4 copy(Vec4 other) {
    return new Vec4(other.x, other.y, other.z, other.w);
  }
  
  public float get(int dim) throws Exception {
    switch (dim) {
      case 0:
        return x;
      case 1:
        return y;
      case 2:
        return z;
      case 3:
        return w;
    }
    
    throw new Exception("Vec4 get out of bounds");
  }
  
  public void set(int dim, float value) throws Exception {
    switch (dim) {
      case 0:
        x = value;
        break;
      case 1:
        y = value;
        break;
      case 2:
        z = value;
        break;
      case 3:
        w = value;
        break;
      default:
        throw new Exception("Vec4 set out of bounds");
    }
  }
  
  public String toString(){
    return "(" + x+ "," + y + "," + z + "," + w + ")";
  }
  
  public float length(){
    return sqrt(x*x+y*y+z*z+w*w);
  }
  
  public float lengthSqr(){
    return x*x+y*y+z*z+w*w;
  }
  
  public static Vec4 add(Vec4 rhs, Vec4 lhs) {
    return new Vec4(rhs.x+lhs.x, rhs.y+lhs.y, rhs.z+lhs.z, rhs.w+lhs.w);
  }
  
  public void add(Vec4 rhs){
    x += rhs.x;
    y += rhs.y;
    z += rhs.z;
    w += rhs.w;
  }
  
  public static Vec4 sub(Vec4 rhs, Vec4 lhs){
    return new Vec4(rhs.x-lhs.x, rhs.y-lhs.y, rhs.z-lhs.z, rhs.w-lhs.w);
  }
  
  public void sub(Vec4 rhs){
    x -= rhs.x;
    y -= rhs.y;
    z -= rhs.z;
    w -= rhs.w;
  }
  
  public static Vec4 mul(Vec4 rhs, float scalar){
    return new Vec4(rhs.x*scalar, rhs.y*scalar, rhs.z*scalar,rhs.w*scalar);
  }
  
  public void mul(float scalar){
    x *= scalar;
    y *= scalar;
    z *= scalar;
    w *= scalar;
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
    if (w > maxL){
      w = maxL;
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
    if (w < minL){
      w = minL;
    }
  }
  
  public void clampToLength(float maxL){
    float magnitude = sqrt(x*x + y*y + z*z + w*w);
    if (magnitude > maxL){
      x *= maxL/magnitude;
      y *= maxL/magnitude;
      z *= maxL/magnitude;
      w *= maxL/magnitude;
    }
  }
  
  public void setToLength(float newL){
    float magnitude = sqrt(x*x + y*y + z*z + w*w);
    x *= newL/magnitude;
    y *= newL/magnitude;
    z *= newL/magnitude;
    w *= newL/magnitude;
  }
  
  public void normalize(){
    float magnitude = sqrt(x*x + y*y + z*z + w*w);
    if (magnitude == 0) {
      x = 0;
      y = 0;
      z = 0;
      w = 0;
    } else {
      x /= magnitude;
      y /= magnitude;
      z /= magnitude;
      w /= magnitude;
    }
  }
  
  public Vec4 normalized(){
    float magnitude = sqrt(x*x + y*y + z*z + w*w);
    if (magnitude == 0) return new Vec4(0, 0, 0, 0); 
    else return new Vec4(x/magnitude, y/magnitude, z/magnitude, w/magnitude); 
  }
  
  public float distanceTo(Vec4 rhs){
    float dx = rhs.x - x;
    float dy = rhs.y - y;
    float dz = rhs.z - z;
    float dw = rhs.w - w;
    return sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
  }
}

Vec4 interpolate(Vec4 a, Vec4 b, float t){
  return Vec4.add(a, (Vec4.mul(Vec4.sub(b, a), t)));
}
float dot(Vec4 a, Vec4 b){
  return a.x*b.x + a.y*b.y + a.z*b.z + a.w*b.w;
}

Vec4 projAB(Vec4 a, Vec4 b){
  return Vec4.mul(b, (a.x*b.x + a.y*b.y + a.z*b.z + a.w*b.w));
}

//DO IF NESSISARY
//Vec4 cross(Vec4 a, Vec4 b){
//  return new Vec4(a.y*b.z - a.z*b.y, a.x*b.z - a.z*b.x, a.x*b.y - a.y*b.x, 0);  
//}
