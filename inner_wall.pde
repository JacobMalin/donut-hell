// object.pde

class Object {
  color tanBrown = #ce9f6e;
  color green = #918f45;
  
  PShape tree;
  Vec4 treePos = new Vec4(0, 520, 0, 0);
  float treeHypRad = 100; // Thickness in w

  public Object() {    
    // Tree
    PShape trunk, leaves;
    tree = createShape(GROUP);
    trunk = loadShape("assets/tree/oak_trunk.obj");
    leaves = loadShape("assets/tree/oak_leaves.obj");
    trunk.setFill(tanBrown);
    leaves.setFill(green);
    tree.addChild(trunk);
    tree.addChild(leaves);
  }
  
  void Draw(float w) {
    if (w < treePos.w + treeHypRad && w > treePos.w - treeHypRad) {
      // Tree
      pushMatrix();
      translate(treePos.x, treePos.y, treePos.z);
      rotateX(-0.2);
      rotateY(4.1);
      rotateZ(-0.4);
      scale(270);
      shape(tree);
      popMatrix();
    }
  }
}
