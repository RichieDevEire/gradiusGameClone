import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
AudioPlayer snd;

PImage imgShip, imgShot1, imgBossEnemy, imgEasyEnemy;

int shipX = 25;
int shipY = 250;

int lastTime;

void setup()
{
  lastTime = millis();
  size(1920, 500);
  
  imgShip = loadImage("ship.png");
  imgShot1 = loadImage("shot1.png");
  imgBossEnemy = loadImage("bossEnemy.png");
  imgEasyEnemy = loadImage("easyEnemy.png");
  
  minim = new Minim(this);
  snd = minim.loadFile("shot.wav");
  
  // "s" == stars in background
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
  playerPos = new PVector(shipX, shipY);
  forward = new PVector(0, -1);
  velocity = new PVector(0, 0);
  right = new PVector(1, 0);
  mass = 1;
  
  enemyBoss = new EnemyBoss(50, 50);
//  easyEnemy = new EasyEnemy(width+ 20, random(height));
//  easyEnemy1 = new EasyEnemy(width+ 20, random(height));
  
  for(int i = 0 ; i < easyEnemies.length ; i++)
  {
    easyEnemies[i] = new EasyEnemy(width+ 20, random(height));
  }
}
int shotRate = 120/6;
//boolean[] keys = new boolean[2000];

float[] x = new float[100];
float[] y = new float[100];
float[] speed = new float[100];

PVector playerPos;
PVector forward, right;
PVector velocity;
PVector force;
PVector acceleration;
float mass, timeDelta = 1.0f / 60.0f;


ArrayList<Bullet> bullets = new ArrayList<Bullet>();


EnemyBoss enemyBoss;
EasyEnemy[] easyEnemies = new EasyEnemy[6];



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

  acceleration = PVector.div(force, mass);
  velocity.add(PVector.mult(acceleration, timeDelta));
  playerPos.add(PVector.mult(velocity, timeDelta));
  force.x = force.y = 0;
  velocity.mult(0.97f);

  updateShip();

for(int i = 0 ; i < easyEnemies.length ; i++)
  {
    easyEnemies[i].render();
    easyEnemies[i].update();
    
  }

  for (int i = bullets.size () -1; i >= 0; i --)
  {
    Bullet b = bullets.get(i);
    b.update();
    b.render();
    if (PVector.dist(b.pos, enemyBoss.pos) < enemyBoss.halfW && enemyBoss.health >= 0)
    {
      enemyBoss.health --;
      b.reset();
    }
    for(int a = 0 ; a < easyEnemies.length ; a ++)
    {
      if (PVector.dist(b.pos, easyEnemies[a].pos) < easyEnemies[a].halfW && easyEnemies[a].health >= 0)
      {
        easyEnemies[a].health -= 10;
        b.reset();
        
      }
    }
//    if (PVector.dist(b.pos, easyEnemy.pos) < easyEnemy.halfW && easyEnemy.health >= 0)
//    {
//      easyEnemy.health --;
//      b.reset();
//    }
  }
}



  void updateShip()
  {
    println(playerPos);
    stroke(255);
    pushMatrix();
    imageMode(CENTER);
    translate(playerPos.x, playerPos.y);
    image(imgShip, 5, 2);
    popMatrix();
  }

