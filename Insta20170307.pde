ArrayList<Particle> particles;
PVector preMouse;
float angle;
float _range;

void setup()
{
  size(512, 512, P3D);
  frameRate(30);
  blendMode(ADD);
  colorMode(HSB);
  hint(DISABLE_DEPTH_TEST);
  
  particles = new ArrayList<Particle>();
  for(int i = 0; i < 512; i++)
  {
    particles.add(new Particle(width / 2, height / 2, 0));
  }
  
  angle = 0;
  _range = 250;
}

void draw()
{
  background(0);
  
  camera(width / 2.0, height / 2.0, 0.0, 
        width / 2.0, height / 2.0, 512.0,
        0.0, 1.0, 0.0);
    
  for(Particle p : particles)
  {
    p.run();
  }

  /*
  println(frameCount);
  saveFrame("screen-#####.png");
  if(frameCount > 900)
  {
     exit();
  } 
  */
}