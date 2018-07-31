import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect kinect;

// Angle for rotation
float a = 0;

void setup() {
  size(640, 480, P3D);
  kinect = new Kinect(this); 
  kinect.initDepth();
}

void draw() {
  background(0); 

  //PImage depthImage = kinect.getDepthImage();
  //image(depthImage, 0, 0);
  
  
   // Translate and rotate
  pushMatrix();
  translate(width/2, height/2, -2250);
  //rotateY(a);

  int[] depth = kinect.getRawDepth();
  int skip = 16;

  stroke(255);
  strokeWeight(2);
  beginShape(POINTS);
  for ( int x = 0; x < kinect.width; x += skip ) {
    for ( int y = 0; y < kinect.height; y += skip ) {
      int offset = x + y*kinect.width;

      PVector point = depthToPointCloudPos(x, y, depth[offset]);

      vertex(point.x, point.y, point.z);
    }
  }
  
  endShape();

  popMatrix();

  fill(255);
  text(frameRate, 50, 50);

  // Rotate
  a += 0.0015;
}

PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();

  point.z = (depthValue);
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx; 
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;

  return point;
}
