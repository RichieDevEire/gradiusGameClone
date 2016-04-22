import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
//AudioPlayer snd, snd2, snd3;

PImage imgShip, imgShot1;

int shipX = 25;
int shipY = 250;

int lastTime;

void setup()
{
  lastTime = millis();
  size(1920, 500);
  
  imgShip = loadImage("ship.png");
  imgShot1 = loadImage("shot1.png");
  
  
  int s = 0;//stars
  while (s < 100)
  {
    x[s] = random(0, width);
    y[s] = random(0, height);
    speed[s] = random(0.2f, 1.0f);
    s += 1;
  }
  force = new PVector();
  acceleration = new PVector();
  pos = new PVector(shipX, shipY);
  forward = new PVector(0, -1);
  velocity = new PVector(0, 0);
  right = new PVector(1, 0);
  mass = 1;
  
  enemyBoss = new EnemyBoss(50, 50);
}
int shotRate = 120/6;
//boolean[] keys = new boolean[2000];

float[] x = new float[100];
float[] y = new float[100];
float[] speed = new float[100];

PVector pos;
PVector forward, right;
PVector velocity;
PVector force;
PVector acceleration;
float mass, timeDelta = 1.0f / 60.0f;


ArrayList<Bullet> bullets = new ArrayList<Bullet>();

EnemyBoss enemyBoss;


void draw()
{
  background(0);
  stroke(255);
  getkeys();

  timeDelta = (millis() - lastTime) / 1000.0f;
  lastTime = millis();
  //println(timeDelta);

  int s = 0;
  while (s < 100)
  {
    point(x[s], y[s]);  

    x[s] = x[s] - speed[s];
    if (x[s] < 0)
    {
      x[s] = width;
    }
    s += 1;
  }
  //  rect(shipX, shipY, 25,25);

  acceleration = PVector.div(force, mass);
  velocity.add(PVector.mult(acceleration, timeDelta));
  pos.add(PVector.mult(velocity, timeDelta));
  force.x = force.y = 0;
  velocity.mult(0.99f);

  updateShip();
  enemyBoss.update();
  enemyBoss.render();

  for (int i = bullets.size () -1; i >= 0; i --)
  {
    Bullet b = bullets.get(i);
    b.update();
    b.render();
    if (PVector.dist(b.pos, enemyBoss.pos) < enemyBoss.halfW)
    {
      enemyBoss.health --;
    }
  }
}



  void updateShip()
  {
    println(pos);
    stroke(255);
    pushMatrix();
    translate(pos.x, pos.y);
    image(imgShip, 5, 2);
    popMatrix();
  }

