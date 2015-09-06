

NBody nbody;


//! 初期化関数
void setup(){
    // 描画領域の表示
    size(400, 400); 
    background(0, 0, 0);

    // N体問題の設定
    nbody = new NBody(width, height);
    nbody.add(new Planet(new Vector(0, 0), new Vector(0, 0), 1.99E+30, "Sun"));

    //主要な星      <----位置[m]---------->   <-質量[kg]->    <-半径[m]--->   <-----速度[m/s]-------> 
    //nbody.addBody(0,                    0,  1.99E+30,       (1.39E+9)*5,    0,                    0,        Color.red,              "太");
    //nbody.addBody(-5.791E+10,      1.0E+5,  3.302E+23,      (4.87E+6)*180,  0,           4.78725E+4,        new Color(200,200,200), "水");
    //nbody.addBody(1.0E+5,   1.0820893E+11,  4.869E+24,      (1.21E+7)*90,   3.50214E+4,           0,        Color.orange,           "金");
    //nbody.addBody(1.4959787E+11,   1.0E+5,  5.9742E+24,     (1.29E+8)*30,   0,          -2.97859E+4,        Color.blue,             "地");
    //nbody.addBody(1.0E+5, -2.27936640E+11,  6.4191E+23,     (6.79E+6)*180,  -2.41309E+4,          0,        new Color(255,200,100), "火");
    //nbody.addBody(0,        7.7841201E+11,  1.899E+27,      jr,             1.30697E+4,           0,        new Color(220,200,180), "木");
    //nbody.addBody(1.4267254E+12,        0,  5.688E+26,      (1.21E+8)*20,   0,           -9.6724E+3,        new Color(255,230,40),  "土");
    //nbody.addBody(1.4959787E+11,  3.84E+8,  7.35E+22,       (3.47E+3)*20,   1.1E+3,     -2.97859E+4,        Color.yellow,           "月");

}

//! 描画関数
void draw(){
    noStroke();
    fill(0, 0, 0);
    rect(0, 0, width, height);
    fill(255, 255, 255);


    if (frameCount > 300){
        noLoop();
    }
}
