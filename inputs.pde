boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}
void getkeys()
{
  if (keys[UP])
  {

    // The direction is the forward vector
    // The amount is 10 newtons
    // we add this to the force vector
    force.add(PVector.mult(forward, 250));
    println(force);
  }      
  if (keys[DOWN])
  {
    // The direction is the forward vector
    // The amount is 10 newtons
    // we add this to the force vector
    force.sub(PVector.mult(forward, 250));
  }      
  if (keys[LEFT])
  {
    //      theta -= 0.1f;
    force.sub(PVector.mult(right, 300));
  }
  if (keys[RIGHT])
  {
    //      theta += 0.1f;
    force.add(PVector.mult(right, 300));
  }

  if (keys[' '])
  {
    shotTime -= timeDelta;
    if(shotTime <= 0)
  {
    PVector bulletPos = pos.get();
    bulletPos.add(PVector.mult(right, 30)); // Start the bullet 30 units in front of the player
    Bullet b = new Bullet(bulletPos.x, bulletPos.y);
    bullets.add(b);
    shotTime = 0.1f;
  }
  }
} 
float shotTime = 0.1 ;
