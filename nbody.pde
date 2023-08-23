

NBodySimulation simulator;

//! 初期化関数
void setup(){
    // 描画領域の表示
    size(800, 800); 
    background(0, 0, 0);

    // N体問題の設定
    simulator = new NBodySimulation(width, height);
    simulator.setDt(300);
    addBodies(simulator);

}

//! 描画関数
void draw(){
    // 描画領域全体を黒で塗り潰す
    noStroke();
    fill(0, 0, 0, 64);
    rect(0, 0, width, height);

    // 物体情報の更新
    simulator.simulate(256);

    // 物体の描画 
    fill(255, 255, 255, 255);
    simulator.draw();

    if (frameCount % 60 == 0){
        println("frameRate = " + frameRate);
    }

    //if (frameCount > 300){
    //    noLoop();
    //}
}

double myrand(double a, double b){
    return Math.random()*(b-a) + a;
}



void addBodies(NBodySimulation s){
    //主要な星の追加
    //               <--------------位置[m]------------------->  <----------速度[m/s]-------------->  <-質量[kg]->
    s.add(new Planet(new Vector(0            ,               0), new Vector(0         ,           0), 1.99E+30,    "Sun"));
    s.add(new Planet(new Vector(-5.791E+10   ,          1.0E+5), new Vector(0         ,  4.78725E+4), 3.302E+23,   "Mercury"));
    s.add(new Planet(new Vector(1.0E+5       ,   1.0820893E+11), new Vector(3.50214E+4,           0), 4.869E+24,   "Venus"));
    s.add(new Planet(new Vector(1.4959787E+11,          1.0E+5), new Vector(0,          -2.97859E+4), 5.9742E+24,  "Earth"));
    s.add(new Planet(new Vector(1.4959787E+11,         3.84E+8), new Vector(1.1E+3,     -2.97859E+4), 7.35E+22,    "Moon"));

    s.add(new Planet(new Vector(1.0E+5       , -2.27936640E+11), new Vector(-2.41309E+4,          0), 6.4191E+23,  "Mars"));

    s.add(new Planet(new Vector(0            ,   7.7841201E+11), new Vector(1.30697E+4,           0), 1.899E+27,   "Jupiter"));
    s.add(new Planet(new Vector(1.4267254E+12,               0), new Vector(0,           -9.6724E+3), 5.688E+26,   "Saturn"));


    for (int i=0; i<300; i++){
        s.add(new Planet(new Vector(myrand(0.5,1.5)*2.0E+11,  myrand(0.5,1.5)*2.0E+11), 
                         new Vector(myrand(-1,1)*4.0E+4, myrand(-1,1)*4.0E+4 ), 
                         5.688E+25, 
                         ""));
    }
}


