import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect kinect;

void setup(){
 size(512,424);
 kinect = new Kinect(this); 
 kinect.initDepth();
}

void draw(){
 background(0); 
 
 PImage depthImage = kinect.getDepthImage();
 image(depthImage, 0, 0);
}
