import oscP5.*;
import netP5.*;
import processing.video.*;

OscP5 oscP5;
NetAddress location;
Capture video;


//Controler s_controler;
Scan scan;

PImage result;

void setup() {
  size(720, 480, P3D);
  colorMode(HSB, 256);
  background(0);

  oscP5 = new OscP5(this, 12000);
  location = new NetAddress("127.0.0.1", 4557);


  //s_controler = new Controler();
  scan = new Scan();
  
  video = new Capture(this, width, height, 30);
  result = createImage(video.width, video.height, HSB);
  video.start();

  
}

void draw() {
  if (video.available()) {
    video.read();
  }
  scan.update();
  //s_controler.update();
  scan.display();
  


}

void mousePressed() {
}

void mouseClicked() {
  
}