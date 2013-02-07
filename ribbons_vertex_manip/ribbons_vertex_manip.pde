int pts = 40; 
float angle = 0;
float radius = 60.0;

// lathe segments
int segments = 60;
float latheAngle = 0;
float latheRadius = 100.0;

//vertices
PVector vertices[], vertices2[];

// for shaded or wireframe rendering 
boolean isWireFrame = false;

// for optional helix
boolean isHelix = false;
float helixOffset = 5.0;

PFont font;

void setup(){
  size(1600, 900, OPENGL);
 // frameRate(30);
  smooth();
  font = createFont("Arial Bold",48);
}

void draw(){
  background(0, 0, 0);
  
    // oversampled fonts tend to look better
  textFont(font,36);
  // white float frameRate
  fill(255);
  text(frameRate,40,40);
  
  // basic lighting setup
  lights();
  // 2 rendering styles
  // wireframe or solid
  if (isWireFrame){
    stroke(255, 255, 150);
    noFill();
  } 
  else {
    noStroke();
    fill(200, 200, 200);
  }
  //center and spin toroid ***GRID
  
  int cell_size = 8;
  int grid_size = 200;
  translate(0, height/2, -500);

  rotateX(frameCount*PI/150);
//  rotateY(frameCount*PI/170);
//  rotateZ(frameCount*PI/90);
  
  // draw grid
  //float osc = sin(frameCount*0.1) * cell_size *2;
  int ribbon_padding = 4;
  float period = 120;
  float osc = abs( ((frameCount % period) / period) - 0.5)* cell_size *3;
//  print("\n" + osc);
  for (int j=0; j<grid_size; j++){
    beginShape(QUAD_STRIP);
    
    int y = j * (cell_size+ribbon_padding);
    
    float z = random(-osc, osc);
    vertex(0, y, z);
    vertex(0, y+cell_size, z);

    for (int i=0; i<grid_size; i++) {
      z = random(-osc, osc);
      vertex(i*cell_size+cell_size, y, z);
      
      vertex(i*cell_size+cell_size, y+cell_size, z);   
    }
    endShape(QUAD_STRIP);
  }

//  // initialize point arrays
//  vertices = new PVector[pts+1];
//  vertices2 = new PVector[pts+1];
//
//  // fill arrays
//  for(int i=0; i<=pts; i++){
//    vertices[i] = new PVector();
//    vertices2[i] = new PVector();
//    vertices[i].x = latheRadius + sin(radians(angle))*radius;
//    if (isHelix){
//      vertices[i].z = cos(radians(angle))*radius-(helixOffset* 
//        segments)/2;
//    } 
//    else{
//      vertices[i].z = cos(radians(angle))*radius;
//    }
//    angle+=360.0/pts;
//  }
//
//  // draw toroid
//  latheAngle = 0;
//  for(int i=0; i<=segments; i++){
//    beginShape(QUAD_STRIP);
//    for(int j=0; j<=pts; j++){
//      if (i>0){
//        vertex(vertices2[j].x, vertices2[j].y, vertices2[j].z);
//      }
//      vertices2[j].x = cos(radians(latheAngle))*vertices[j].x;
//      vertices2[j].y = sin(radians(latheAngle))*vertices[j].x;
//      vertices2[j].z = vertices[j].z;
//      // optional helix offset
//      if (isHelix){
//        vertices[j].z+=helixOffset;
//      } 
//      vertex(vertices2[j].x, vertices2[j].y, vertices2[j].z);
//    }
//    // create extra rotation for helix
//    if (isHelix){
//      latheAngle+=720.0/segments;
//    } 
//    else {
//      latheAngle+=360.0/segments;
//    }
//    endShape();
//  }
}

/*
 left/right arrow keys control ellipse detail
 up/down arrow keys control segment detail.
 'a','s' keys control lathe radius
 'z','x' keys control ellipse radius
 'w' key toggles between wireframe and solid
 'h' key toggles between toroid and helix
 */
void keyPressed(){
  if(key == CODED) { 
    // pts
    if (keyCode == UP) { 
      if (pts<40){
        pts++;
      } 
    } 
    else if (keyCode == DOWN) { 
      if (pts>3){
        pts--;
      }
    } 
    // extrusion length
    if (keyCode == LEFT) { 
      if (segments>3){
        segments--; 
      }
    } 
    else if (keyCode == RIGHT) { 
      if (segments<80){
        segments++; 
      }
    } 
  }
  // lathe radius
  if (key =='a'){
    if (latheRadius>0){
      latheRadius--; 
    }
  } 
  else if (key == 's'){
    latheRadius++; 
  }
  // ellipse radius
  if (key =='z'){
    if (radius>10){
      radius--;
    }
  } 
  else if (key == 'x'){
    radius++;
  }
  // wireframe
  if (key =='w'){
    if (isWireFrame){
      isWireFrame=false;
    } 
    else {
      isWireFrame=true;
    }
  }
  // helix
  if (key =='h'){
    if (isHelix){
      isHelix=false;
    } 
    else {
      isHelix=true;
    }
  }
}
