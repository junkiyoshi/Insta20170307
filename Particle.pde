class Particle
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float size;
  float radius;
  float max_force;
  float max_speed;
  float color_value;
  color body_color;
  
  Particle(float x, float y, float z)
  {
    location = new PVector(x, y, z);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    radius = 50;
    max_force = 1;
    max_speed = 8;
    size = 10;
    color_value = random(255);
    body_color = color(color_value, 255, 255);
  }
    
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  void seek(PVector target)
  {
    PVector desired = PVector.sub(target, location);
    float distance = desired.mag();
    desired.normalize();
    if(distance < radius)
    {
      float m = map(distance, 0, radius, 0, max_speed);
      desired.mult(m);
    }else
    {   
      desired.mult(max_speed);
    }
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(max_force);
    applyForce(steer);
  }
  
  void run()
  {    
    update();
    display();
  }
  
  void update()
  {     
    strokeWeight(1);    
    float power = 50;
    
    PVector future = velocity.copy();
    future.normalize();
    future.mult(power * 2);
    future.add(location);
          
    float angle_1 = random(360);
    float angle_2 = random(360);
    float x = power * cos(radians(angle_1)) + future.x;
    float y = power * sin(radians(angle_1)) + future.y;
    float z = power * cos(radians(angle_2)) + future.z;
       
    seek(new PVector(x, y, z));
    
    if(PVector.dist(new PVector(width / 2, height / 2, 0), location) > _range)
    {
      seek(new PVector(width / 2, height / 2, 0));
    }
    
    velocity.add(acceleration);
    velocity.limit(max_speed);
    location.add(velocity);
    acceleration.mult(0);
    velocity.mult(0.98);
    
    color_value = (color_value + random(1, 10)) % 255;
    body_color = color(color_value, 255, 255);
  }
  
  void display()
  {
    pushMatrix();
    translate(location.x, location.y, location.z);
    
    fill(body_color, 128);
    noStroke();
    sphere(size);
    
    popMatrix();
  }
}