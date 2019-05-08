import java.util.*;

interface Displayable {
  void display();
}
interface Moveable {
  void move();
}
interface Collideable {
  boolean isTouching(Thing other);
}

abstract class Thing implements Displayable {
  float x, y;
  float radius;
  Thing(float x, float y) {
    this.x = x;
    this.y = y;
    radius = 25;
  }
  abstract void display();
}

class Rock extends Thing implements Collideable {
  PImage rocktype; //stores which of the two rocks it is
  float radius = 25;

  Rock(float x, float y) {
    super(x, y);  
    Random rng = new Random();
    int randomNum = rng.nextInt(2);
    if (randomNum == 0) { //each rock chooses between 2 different image files
      rocktype = loadImage("rock1.jpeg");
    } else {
      rocktype = loadImage("rock2.png");
    }
  }

  void display() {
     image(rocktype,x,y,radius*2,radius*2);
  }
  
  boolean isTouching(Thing other) {
    return true;
  }
  
  float getRadius() {
    return radius;
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
    fill(red, green, blue);  
    circle(x-2, y, 2 );
    circle(x+2, y, 2 );
  }
  void move() {
    Random rng = new Random();
    int randomNum = rng.nextInt(4);
    x+=random(-5,5);
    y+=random(-5,5);
  }
}

class Ball extends Thing implements Displayable, Moveable {
  float goalx;
  float goaly;
  float red, green, blue;
  float xspeed, yspeed;
  float radius;
  Ball(float x, float y) {
    super(x, y);
    goalx = 50+random(width-100);
    goaly =50+random(height)-100;
    red = random(0, 255);
    green = random(0, 255);
    blue = random(0, 255);
    xspeed = random(-4, 4);
    yspeed = random(-4, 4);
    radius = 25;
  }

  void display() {
    fill(red, green, blue);  
    circle(x, y, 2 * radius);
  }

  void move() {
    if (x < radius || x > width - radius) {
      xspeed = -xspeed + random(-1,1);
      yspeed += random(-1,1);
    }
    if (y < radius || y > height - radius) {
      yspeed = -yspeed + random(-1,1);
      xspeed += random(-1,1);
    }
    x += xspeed;
    y+= yspeed;
  }
}



ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> collisions;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  collisions = new ArrayList<Collideable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
    collisions.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
    collisions.add(m);
  }
}
void draw() {
  background(255);
  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
<<<<<<< HEAD
}
=======
  for (Collideable thing : collisions) {
    thing.isTouching(thing);
  }
}
>>>>>>> ac068641049e88bc87adc50ce9cd5a77420c4668
