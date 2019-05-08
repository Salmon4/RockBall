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
    image(rocktype, x, y, radius*2, radius*2);
  }

  boolean isTouching(Thing other) {
    float dx = this.x - other.x;
    float dy = this.y - other.y;
    float dist = sqrt(sq(dx)+sq(dy));
    if (dist < this.radius+other.radius) {
      super.x = super.x+10;
      return true;
    }
    return false;
  }

  float getRadius() {
    return radius;
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
    Random rng = new Random();
    int randomNum = rng.nextInt(4);
    if (randomNum == 0) {
      super.y = super.y - 10;
    }
    if (randomNum == 1) {
      super.y = super.y + 10;
    }
    if (randomNum == 2) {
      super.x = super.x - 10;
    }
    if (randomNum == 3) {
      super.x = super.x + 10;
    }
    /**
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
     **/
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
      xspeed = -xspeed + random(-1, 1);
      yspeed += random(-1, 1);
    }
    if (y < radius || y > height - radius) {
      yspeed = -yspeed + random(-1, 1);
      xspeed += random(-1, 1);
    }
    x += xspeed;
    y+= yspeed;
  }
}

class Ball1 extends Ball {
  float angle;
  float c;
  float speed;
  float centerx;
  float centery;
  Ball1(float x, float y) {
    super(x, y);
    angle = 0;
    c = random(.5, 1.5);
    speed = random(-PI/180, PI/180);
    centerx = random(width/4, 3*width/4);
    centery = random(height/4, 3*height/4);
  }

  void display() {
      fill(red, green, blue);  
      circle(x, y, 2 * radius);
  }

  void move() {
    angle+= speed;
    x = sin(angle) * c * radius * 10 + centerx;
    y = cos(angle) * radius * 10 + centery;
    
    if ((x < radius || x > width - radius) ||  (y < radius || y > height - radius)) {
      speed*=-1;
      angle -= PI/360;
    }
   
    //if (x < radius || x > width - radius) {
    //  xspeed = -xspeed + random(-1, 1);
    //  yspeed += random(-1, 1);
    //}
    //if (y < radius || y > height - radius) {
    //  yspeed = -yspeed + random(-1, 1);
    //  xspeed += random(-1, 1);
    //}
   
  }
}

class Ball2 extends Ball {
  Ball2(float x, float y) {
    super(x, y);
  }

  void display() {
  }

  void move() {
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball1 b = new Ball1(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
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
}
