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
  if (keys[UP] && playerPos.y > 100)
  {

    // The direction is the forward vector
    // The amount is 10 newtons
    // we add this to the force vector
    force.add(PVector.mult(forward, 300));
    println(force);
  }      
  if (keys[DOWN]&& playerPos.y < height - 100)
  {
    // The direction is the forward vector
    // The amount is 10 newtons
    // we add this to the force vector
    force.sub(PVector.mult(forward, 300));
  }      
  if (keys[LEFT] && playerPos.x > 100)
  {
    //      theta -= 0.1f;
    force.sub(PVector.mult(right, 350));
  }
  if (keys[RIGHT] && playerPos.x < width/3)
  {
    //      theta += 0.1f;
    force.add(PVector.mult(right, 350));
  }

  if (keys[' '])
  {
    shotTime -= timeDelta;
    if(shotTime <= 0)
  {
    PVector bulletPos = playerPos.get();
    bulletPos.add(PVector.mult(right, 50)); // Start the bullet 30 units in front of the player
    Bullet b = new Bullet(bulletPos.x, bulletPos.y);
    bullets.add(b);
    shotTime = 0.2f;
    snd.setGain(-5.0);
    snd.play();
    snd.rewind();
  }
  }
} 
float shotTime = 0.2f ;
