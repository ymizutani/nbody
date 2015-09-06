

NBody nbody;


//! 初期化関数
void setup(){
    // 描画領域の表示
    size(400, 400); 
    background(0, 0, 0);

    // N体問題の設定
    nbody = new NBody(width, height);

    //主要な星           <--------------位置[m]------------------>   <----------速度[m/s]------------->   <-質量[kg]->
    nbody.add(new Planet(new Vector(0            ,               0), new Vector(0         ,           0), 1.99E+30,    "Sun"));
    nbody.add(new Planet(new Vector(-5.791E+10   ,          1.0E+5), new Vector(0         ,  4.78725E+4), 3.302E+23,   "Mercury"));
    nbody.add(new Planet(new Vector(1.0E+5       ,   1.0820893E+11), new Vector(3.50214E+4,           0), 4.869E+24,   "Venus"));
    nbody.add(new Planet(new Vector(1.4959787E+11,          1.0E+5), new Vector(0,          -2.97859E+4), 5.9742E+24,  "Earth"));
    nbody.add(new Planet(new Vector(1.4959787E+11,         3.84E+8), new Vector(1.1E+3,     -2.97859E+4), 7.35E+22,    "Moon"));
    nbody.add(new Planet(new Vector(1.0E+5       , -2.27936640E+11), new Vector(-2.41309E+4,          0), 6.4191E+23,  "Mars"));
    nbody.add(new Planet(new Vector(0            ,   7.7841201E+11), new Vector(1.30697E+4,           0), 1.899E+27,   "Jupiter"));
    nbody.add(new Planet(new Vector(1.4267254E+12,               0), new Vector(0,           -9.6724E+3), 5.688E+26,   "Saturn"));


}

//! 描画関数
void draw(){
    noStroke();
    fill(0, 0, 0);
    rect(0, 0, width, height);
    fill(255, 255, 255);

    nbody.draw();


    if (frameCount > 300){
        noLoop();
    }
}
