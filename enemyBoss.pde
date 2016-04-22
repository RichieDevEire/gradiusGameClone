class EnemyBoss extends GameObject
{ 
  
  int maxHealth = 100;
  int health = maxHealth;
  
  EnemyBoss()
  {
    super();
  }
  
  EnemyBoss(float x, float y)
  {
    super(x, y);
  }
  
  // This OVERRIDES the update method from the superclass
  void update()
  {
      forward.x = sin(theta);
      forward.y = - cos(theta);
      
      // Move in the direction we are rotated
      pos.add(right);
            
      if (pos.y - halfW < 0)
      {
        theta = HALF_PI;
        pos.y = halfW;
      }
      if (pos.x + halfW > width)
      {
        theta = PI;
        pos.x = width - halfW;
      }
      if (pos.y + halfW > height)
      {
        theta = PI + HALF_PI;
        pos.y = height - halfW;
      }
      if (pos.x < halfW)
      {
        theta = 0;
        pos.x = halfW;
      }    
  }
  
  void render()
  {
    stroke(255);
    pushMatrix(); // reset the translation and rotation
    translate(pos.x, pos.y);
//    if (PVector.dist(b.pos, enemyBoss.pos) < enemyBoss.halfW)
//    {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    rect(-halfW, -w, 50, 10);
    fill(0, 255, 0);
    stroke(0, 255, 0);
    rect(-halfW, -w, 50 * ((float)health / (float)maxHealth), 10);
//    }
    stroke(255);
    rotate(theta); // We want rotate to happen first, so you make the call AFTER translate  
    imageMode(CENTER);  
    image(imgBossEnemy, 0, w);
    popMatrix();
  }   

}
