double desp;
PImage img;
ArrayList<Planet> array;
int playerX,playerY,playerZ,playerSpeed,playerRotateX,playerRotateY,playerRotateZ,camX,camY,camZ;
boolean freeCam;

void setup(){
  size(1000,700,P3D);
  stroke(170);
  textSize(32);
  desp=0.5;
  imageMode(CENTER);
  img = loadImage("espacio.jpg"); 
  playerX = 0;
  playerY = 0;
  playerZ = 0;
  playerRotateX=0;
  playerRotateY=0;
  playerRotateZ=0;
  playerSpeed=3;
  freeCam=false;
  array = new ArrayList<Planet>();
  array.add(new Planet(25, 1, 0.25, "Mercurio",true));
  array.add(new Planet(15, 1.2, 0.4, "Venus",false));
  array.add(new Planet(25, 1.6, 0.7, "Tierra",true));
  array.add(new Planet(10, 1.8, 1, "Marte",false));
  array.add(new Planet(30, 0.6, 1.2, "Júpiter",false));
  
  camX=0;
  camY=0;
  camZ=0;
}

void draw(){
  background(img);
  scale(0.5);
  if(!freeCam)textBeforeFreeCam();
  translate(width,height,0);
  rotateX(radians(-20));
  
  pushMatrix();
  rotateY(radians((int)-desp));
  sphere(50);
  popMatrix();
  
  
  for(Planet p: array){
    movePlanet(p); 
  }
  if(freeCam){
    moveCam();
  }else{
    camera();  
  }
  desp++;
  
}
public void moveCam(){
  camera(width/2.0,height/2.0,(height/2.0-camZ)/tan(PI*30/180.0),width/2.0-camX,height/2.0-camY,0,0,1,0);
  if (keyPressed && key == 'w') {
    camZ+=playerSpeed;
  }else if(keyPressed && key == 's'){
    camZ-=playerSpeed;
  }else if(keyPressed && key == 'a'){
    camX+=playerSpeed;
  }else if(keyPressed && key == 'd'){
    camX-=playerSpeed;
  }else if(keyPressed && key == 'r'){
    camY+=playerSpeed;
  }else if(keyPressed && key == 'f'){
    camY-=playerSpeed;
  }
  textControlCam();
}

public void movePlanet(Planet p){
  pushMatrix();
  rotateY(radians((int)(desp * p.speedFactor)));
  translate((float)(-width*p.distFactor),0,0);
  sphere(p.size);
  
  fill(255,255,255);
  rotateY(radians((int)-(desp * p.speedFactor)));
  text(p.name,p.size/2,-p.size,0);
   
  if(p.satelite){
    pushMatrix();
    rotateZ(radians((int)(desp*p.speedFactor)));
    translate((float)(-width*p.distFactor*0.15),0,0);
    box(6);
    popMatrix();
  }
  popMatrix();
}
public void textBeforeFreeCam(){
  fill(255);
  textSize(30);
  text("pulse V para moverse libremente por el planetarium.",0,25,0);
  
}

public void textControlCam(){
  fill(255);
  textSize(15);
  text("pulse W para moverse hacia alante.\npulse S para moverse hacia atras.\npulse R para ascender.\npulse F para descender.\npulse A para rotar hacia la izquierda.\npulse D para rotar hacia la derecha.\n pulse V para volver a la vista general.",0,25,0);
  
}

void keyPressed() {
  if (key == 'v') {
    if(freeCam){
      freeCam = false;  
    }else{
      freeCam = true;
    }
  }
}

private class Planet{
  boolean satelite;
  String name;
  int size;
  double speedFactor;
  double distFactor;
  
  public Planet(int size, double speed, double dist, String name,boolean satelite){
    this.size = size;
    this.speedFactor=speed;
    this.distFactor=dist;
    this.name = name;
    this.satelite = satelite;
  }
}
