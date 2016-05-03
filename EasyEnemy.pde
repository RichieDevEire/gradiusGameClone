class EasyEnemy extends GameObject
{ 
  
  int maxHealth = 10;
  int health = maxHealth;
  float enemySpeedX = 2;
  float enemySpeedY; 
  
  EasyEnemy()
  {
    super();
  }
  
  EasyEnemy(float x, float y)
  {
    super(x, y);
    enemySpeedX = random(1, 4);
    enemySpeedY = random(0.1, 1);
  }
  
  // This OVERRIDES the update method from the superclass
  void update()
  {
    pos.x -= enemySpeedX; 
   if(pos.x < -100)
  {
   pos.x = width + 100;
   pos.y = random(height);
  } 
  if(pos.y > playerPos.y)
  {
    pos.y --;
  }
  if(pos.y < playerPos.y)
  {
    pos.y ++;
  }
  if(health <= 0)
  {
    killEnemies();
  }
  }
    void render()
  {
    stroke(255);
    pushMatrix(); // reset the translation and rotation
    translate(pos.x, pos.y);
    fill(255, 0, 0);
    stroke(255, 0, 0);
    rect(-halfW, -w, 50, 10);
    fill(0, 255, 0);
    stroke(0, 255, 0);
    rect(-halfW, -w, 50 * ((float)health / (float)maxHealth), 10);
    stroke(255);
    rotate(theta);   
    //imageMode(CENTER);  
    image(imgEasyEnemy, 0, w);
    popMatrix();
  }   
  void killEnemies()
  {
    pos.x = width + 100;
    pos.y = random(height);
    health = 10;
    enemySpeedX = random(1, 3);
    enemySpeedY = random(0.1, 1);
  }
}
