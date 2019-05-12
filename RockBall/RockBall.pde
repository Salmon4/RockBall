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

  Rock(float x, float y, PImage rockI) {
    super(x, y);  
    rocktype = rockI;
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

  //=======
  //    return true;
  //  }

  float getRadius() {
    return radius;
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y, PImage rock) {
    super(x, y, rock);
  }
  void move() {
    Random rng = new Random();
    int randomNum = rng.nextInt(4);
    if (randomNum == 0  && super.y > 10) {
      super.y = super.y - 10;
    }
    if (randomNum == 1 && super.y < 790) {
      super.y = super.y + 10;
    }
    if (randomNum == 2 && super.x > 10) {
      super.x = super.x - 10;
    }
    if (randomNum == 3 && super.x < 990) {
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

    x+=random(-5, 5);
    y+=random(-5, 5);
  }
  void display() {
    super.display();
    fill(255, 0, 0);  
    circle(x+15, y+15, 10 );
    circle(x+35, y+15, 10 );
  }
}

class Ball extends Thing implements Displayable, Moveable {
  float goalx;
  float goaly;
  float red, green, blue;
  float xspeed, yspeed;
  float radius;
  float ored,ogreen,oblue;
  Ball(float x, float y) {
    super(x, y);
    goalx = 50+random(width-100);
    goaly =50+random(height)-100;
    red = random(0, 255);
    green = random(0, 255);
    blue = random(0, 255);
    ored = red;
    ogreen = green;
    oblue = blue;
    xspeed = random(-4, 4);
    yspeed = random(-4, 4);
    radius = 25;
  }

  boolean isTouching(Thing other) {

    float dx = this.x - other.x;
    float dy = this.y - other.y;
    float dist = sqrt(sq(dx)+sq(dy));
    if (dist < this.radius+other.radius) {
      //super.x = super.x+10;
      return true;
    }
    return false;
  }

  void display() {
    fill(red, green, blue);  
    circle(x, y, 2 * radius);
  }

  void move() {
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
  float spinradius;
  Ball1(float x, float y) {
    super(x, y);
    angle = 0;
    c = random(.5, 1.5);
    speed = random(-PI/180, PI/180);
    centerx = random(width/4, 3*width/4);
    centery = random(height/4, 3*height/4);
    spinradius = random(50, 500);
  }

  void display() {
    float squarex = x-(radius*cos(PI/4));
    float squarey = y-(radius*sin(PI/4));
    float sqrt = (float)Math.sqrt(2);
    fill(red, green, blue);  
    circle(x, y, 2 * radius);
    square(squarex, squarey, radius*2/sqrt);
    triangle(squarex, squarey, squarex + 2*radius/sqrt, squarey, squarex+radius/sqrt, squarey+2*radius/sqrt);
    noFill();
    triangle(squarex+radius/sqrt, squarey, squarex, squarey+2*radius/sqrt, squarex+2*radius/sqrt, squarey+2*radius/sqrt);
    //circle(x, y, radius*3/2);
    //circle(x, y, radius);
    //circle(x, y, radius/2);
  }

  void move() {
    angle+= speed;
    x = sin(angle) * c * spinradius + centerx;
    y = cos(angle) * spinradius + centery;

    if ((x < radius || x > width - radius) ||  (y < radius || y > height - radius)) {
      speed*=-1;
      angle -= PI/360;
      if (speed < 0) {
        angle -= PI/360;
      } else {
        angle += PI/360;
      }
    }
    red = ored;
    green = ogreen;
    blue = oblue;
    for (Collideable c : collisions) {
      if (isTouching((Thing) c)) {
        red = 255;
        green = 0;
        blue = 0;
      }
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
  float angle;
  float c;
  float speed;
  float centerx;
  float centery;
  Ball2(float x, float y) {
    super(x, y);
    angle = random(0, 360);
    c = random(.5, 1.5);
    speed = random(-PI/180, PI/180);
    centerx = random(width/4, 3*width/4);
    centery = random(height/4, 3*height/4);
    float nx = sin(angle) * sin(angle) * c * radius * 10 + centerx;
    float ny = cos(angle) * radius * 10 + centery;
    if ((nx < radius || nx > width - radius) ||  (ny < radius || ny > height - radius)) {
      angle = random(0, 360);
      centerx = random(width/4, 3*width/4);
      centery = random(height/4, 3*height/4);
    }
  }

  void display() {
    fill(red, green, blue);  
    circle(x, y, 2 * radius);
    circle(x, y, radius*3/2);
    circle(x, y, radius);
    circle(x, y, radius/2);
  }

  void move() {

    angle+= speed;
    x = sin(angle) * sin(angle) * c * radius * 10 + centerx;
    y = cos(angle) * radius * 10 + centery;
    if ((x < radius || x > width - radius) ||  (y < radius || y > height - radius)) {
      speed*=-1;
      if (speed < 0) {
        angle -= PI/360;
      } else {
        angle += PI/360;
      }
    }
    red = ored;
    green = ogreen;
    blue = oblue;
    for (Collideable c : collisions) {
      if (isTouching((Thing) c)) {
        red = 255;
        green = 0;
        blue = 0;
      }
    }
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
  PImage rockI = loadImage("rock1.jpeg");
  PImage rockI2 = loadImage("rock2.png");
  Random rng = new Random();
  Rock r;
  for (int i = 0; i < 10; i++) {
    Ball1 b = new Ball1(50+random(width-100), 50+random(height-100));
    Ball2 b1 = new Ball2(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToDisplay.add(b1);
    thingsToMove.add(b);
    thingsToMove.add(b1);
    int setRock = rng.nextInt(2);
    if (setRock == 0) r = new Rock(50+random(width-100), 50+random(height-100), rockI);     
    else r = new Rock(50+random(width-100), 50+random(height-100), rockI2);     
    thingsToDisplay.add(r);
    collisions.add(r);
  }
  LivingRock m;
  for (int i = 0; i < 3; i++) {
    int setRock = rng.nextInt(2);
    if (setRock == 0) m = new LivingRock(50+random(width-100), 50+random(height-100), rockI);
    else m = new LivingRock(50+random(width-100), 50+random(height-100), rockI2);
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
}
