class Bullet extends GameObject
{
  float speed = 10.0f;


  Bullet(float x, float y)
  {
    super(x, y);
    this.theta = theta;
  }

  void update()
  {
    forward.x = sin(theta);
    forward.y = -cos(theta);
    velocity.x = right.x;
    velocity.y = right.y;    
    velocity.mult(speed);    
    pos.add(velocity);

    if ((pos.x < 0) || (pos.x > width) || (pos.y < 0) || (pos.y > height))
    {
      bullets.remove(this);
    }
  }

  void render()
  {
    pushMatrix();
    imageMode(CENTER);
    translate(pos.x, pos.y);
    rotate(theta); 
    image(imgShot1, 15, 5);
    popMatrix();
  }
}

