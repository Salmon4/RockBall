import java.util.*;

interface Displayable {
  void display();
}
interface Moveable {
  void move();
}
abstract class Thing implements Displayable {
  float x, y;

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing {
  PImage rocktype; //stores which of the two rocks it is

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
   image(rocktype,x,y);
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
    if (key == 'w') {
      super.y = super.y - 10;
    }
    if (key == 's') {
      super.y = super.y + 10;
    }
    if (key == 'a') {
      super.x = super.x - 10;
    }
    if (key == 'd') {
      super.x = super.x + 10;
    }
    key = 'p';
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
    //PImage photo;
    //photo = loadImage("ball1.png");
    //image(photo, x, y);
    fill(red, green, blue);  
    circle(x, y, 2 * radius);
    /* ONE PERSON WRITE THIS */
  }

  void move() {
    /*
    boolean atX = false;
     boolean atY = false;
     if (Math.abs(x - goalx) >  (2 * increment)) {
     if (goalx > x) {
     x += increment;
     } else {
     x -= increment;
     }
     } else {
     x = goalx;
     atX = true;
     }
     if (Math.abs(y - goaly) > (2 * increment)) {
     if (goaly > y) {
     y += increment;
     } else {
     y -= increment;
     }
     } else {
     y = goaly;
     atY = true;
     }
     if (atX && atY) {
     goalx = 60+random(width-110);
     goaly = 60+random(height)-110;
     }
     */
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

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
  thingsToDisplay.add(m);
  thingsToMove.add(m);
}

void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}
