//brickbreaker
Ball terry=new Ball(50,30);
Stick adam=new Stick(50,10);
Block[] blocks=new Block[50];
float timer=0;
Boolean paused=false;
void setup(){
  for (int i=0;i<5;i++){
    for(int j=0;j<10;j++){
       blocks[i*10+j]=new Block(5+j*10,55-(3*i));
    }   
  }
  size(800,600);
  surface.setResizable(true);
  scale(-1,1);
}

void draw(){
   scale(1,-1);
   translate(0,-height);
   background(#00FF00);
   fill(0,0,0);
   textSize(60);
   stroke(#ff3399);
   fill(#ff3300);
   if(!paused){
   terry.move(adam,blocks); adam.move();
   }
   terry.display();
   adam.display();
   timer++;
   for (Block b:blocks){
     b.display();
   }
}
public class Vector{
  float x,y;
  
  public Vector(float a, float b){
     x=a; y=b;
  }
  public void add(Vector v){
    this.x+=v.x; this.y+=v.y;
  }
}
public class Ball{
   Vector pos;
   Vector v; //velocity
   Ball(float x, float y){
      pos= new Vector(x,y);
      v= new Vector(0.2,0.2);
   }
   void move(Stick a, Block[] b){
      //v.x=v.x*(1+pow(timer,0.4)*0.00005);
      //v.y=v.y*(1+pow(timer,0.4)*0.00005);
      this.pos.add(this.v);
      if(pos.x>100 || pos.x<0){
        v.x=-v.x;
      }
      if(pos.y>60){
        v.y=-v.y;
      }
      if(pos.y<0){
         pos.x=50;
         pos.y=35;
         for (Block bl:b){
            bl.alive=true;
         }
      }
      if(pow(pos.x-a.pos.x,2)<36  &&  pow(pos.y-a.pos.y,2)<1){
        v.y=-v.y;
        v.x+=(a.pos.x-pos.x)*0.05;
        v.x+=a.v.x*0.05;
        if(pow(v.x,2)>0.25){v.x*=(0.25/pow(v.x,2));}
        pos.y+=1.5*v.y;
      }
      for (Block bl:b){
        if(bl.alive && pow(pos.x-bl.pos.x,2)<16  &&  pow(pos.y-bl.pos.y,2)<1){
            v.y=-v.y;
            bl.alive=false;
        }
      }
   }
   
     void display(){
     ellipse(pos.x*width/100,(pos.y)*height/60,1*width/100,1*width/100);}
}
public class Block{
    Vector pos;
    boolean alive;
    public Block(float x, float y){
       pos=new Vector(x,y);   
       alive=true;
    }
    void display(){
       if (alive){
         rect((pos.x-4)*width/100,(pos.y-0.5)*height/60,8*width/100,height/60);
       }
    }
}
public class Stick{
    Boolean bounced=false;
    Vector pos;
    Vector v=new Vector(0,0);
    Stick(float x, float y){pos=new Vector(x,y);}
    void move(){
        v.x/=1.06;
        pos.x+=v.x;
        if (pos.y>64){
           pos.y=64; v.y=-0.5*v.y;
        }
        else if (pos.y<7){
           pos.y=7; v.y=-0.5*v.y;
        }
    }
    void display(){
       rect((pos.x-6)*width/100,(pos.y-0.5)*height/60,12*width/100,height/60);
    }
    
}
void keyPressed(){
   if(key=='p' || key=='P'){paused=!paused;}
   if (key=='d'||key=='D'){
      if (adam.pos.x<=95){
      adam.v.x+=0.6;
      }
      else{adam.pos.x=95;adam.v.x=0;}
   }
    if (key=='a'||key=='A'){
      if (adam.pos.x>=5){
      adam.v.x-=0.6;
      }
      else{adam.pos.x=5; adam.v.x=0;}
   }
   
}