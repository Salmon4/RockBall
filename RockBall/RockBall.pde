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
  Rock(float x, float y) {
    super(x, y);
  }

  void display() {
    fill(160,160,160);
    ellipse(x,y,100,100);
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
    if (key == 'w'){
      super.y = super.y - 2;
    }
    if (key == 's'){
      super.y = super.y + 2;
    }
    if (key == 'a'){
      super.x = super.x - 2;
    }
    if (key == 'd'){
      super.x = super.x + 2;
    }
    key = 'p';
  }
}

class Ball extends Thing implements Displayable, Moveable {
  float goalx;
  float goaly;
  float increment;
  Ball(float x, float y) {

    super(x, y);
    goalx = 50+random(width-100);
    goaly =50+random(height)-100;
    increment = random(1,4);
  }

  void display() {
    PImage photo;
    photo = loadImage("ball1.png");
    image(photo, x, y);
    /* ONE PERSON WRITE THIS */
  }

  void move() {
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