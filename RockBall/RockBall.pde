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
//    fill(160,160,160);
//    ellipse(x,y,100,100);
      PImage rock;
      rock = loadImage("rock1.jpeg");
      image(rock,x,y);
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

class Ball extends Thing implements Moveable {
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
<<<<<<< HEAD
    //fill(255, 0, 255);
    //circle(x, y, 50);
    PImage photo;
    photo = loadImage("ball1.png");
    image(photo, x, y);
=======
    //PImage photo;
    //photo = loadImage("ball1.png");
    //image(photo, x, y);
    fill(255, 0, 0);
    circle(x, y, 50);
    fill(255, 165, 0);
    circle(x, y, 40);
    fill(255, 255, 0);
    circle(x, y, 30);
    circle(x, y, 20);
    circle(x, y, 10);
>>>>>>> 53f9d200304373b846a5d8bafe7fc27c86c391e4
    /* ONE PERSON WRITE THIS */
  }

  void move() {
    /* ONE PERSON WRITE THIS */
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