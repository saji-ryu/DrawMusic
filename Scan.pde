public class Scan {
  int x;
  int speed;
  color[] getr;
  int delay;
  int cntb = 0;
  int cntr = 0;
  int cntg = 0;
  boolean isRed = false;
  boolean isGreen = false;


  Scan() {
    x = 100;
    speed = 2;
    //delay =45;
  }

  void update() {
    if (x >= width) {
      x=0;
    }
    int[] ipoint_b = {};
    int[] ipoint_y = {};
    isRed = false;
    isGreen = false;

    cntb++;
    cntr++;
    cntg++;

    for (int i=0; i<video.width; i++) {
      color c = video.get(width-x, i);
      float b = brightness(c);
      color n = color(0, 0, b);
      if (blue(c)-(green(c)+red(c))/2>30) {
        ipoint_b = append(ipoint_b, i);
        i+=5;
      }
      if (red(c)-(green(c)+blue(c))/2>70) {
        isRed = true;
      }
      if (green(c)-(red(c)+blue(c))/2>45 && red(c)<150) {
        isGreen = true;
      }
      //if (green(c)>170&&red(c)>150&&blue(c)<140) {
      //  ipoint_y = append(ipoint_y, i);
      //  i+=5;
      //}
    }
    //playYellow(ipoint_y);
    playBlue(ipoint_b);
    if (isRed) {
      playRed();
    }
    if (isGreen) {
      playGreen();
    }
  }

  void display() {
    background(0);
    image(result, 0, 0);
    stroke(200, 200, 200);

    line(x, 0, x, height);

    x+=speed;
    //println(cnt);
    image(result, 0, 0);
  }

  void playRed() {
    if (cntr>5) {
      OscMessage msg = new OscMessage("/run-code");
      msg.add("fromP5");
      msg.add("sample :bd_tek;");
      oscP5.send(msg, location);
      cntr = 0;
    }
  }
  
  void playGreen() {
    if (cntg>5) {
      OscMessage msg = new OscMessage("/run-code");
      msg.add("fromP5");
      msg.add("sample :drum_cymbal_closed;");
      oscP5.send(msg, location);
      cntg = 0;
    }
  }

  void playBlue(int[] p) {
    if (cntb>5) {
      String scale ="";
      for (int i=0; i<p.length; i++) {
        scale += round(map(p[i], 0, height, 36, 95));
        scale += ",";
      }
      println(scale);
      OscMessage msg = new OscMessage("/run-code");
      msg.add("fromP5");
      msg.add("use_synth :dsaw; play ["+scale+"],amp: 0.5;");

      oscP5.send(msg, location);
      cntb = 0;
    }
  }
  
  void playYellow(int[] p) {
    if (cntb>5) {
      String scale ="";
      for (int i=0; i<p.length; i++) {
        scale += round(map(p[i], 0, height, 36, 95));
        scale += ",";
      }
      println(scale);
      OscMessage msg = new OscMessage("/run-code");
      msg.add("fromP5");
      msg.add("use_synth :piano; play ["+scale+"],amp: 0.5;");

      oscP5.send(msg, location);
      cntb = 0;
    }
  }
}