import parallel.*;

NBodySimulation simulator;

int P = 1;
/////////////////////
int BATCH_SIZE = 8;
int ANUM = 700;
int DT = 3600;

class ParallelSimurataionCall extends ParallelTask {
    int bodynum;

    ParallelSimurataionCall(int bn){
        bodynum = bn;
    }

    void run(){
        int myrank = getMyrank();

        if (P==1){
            if (myrank == 0){
                simulator.simulate(0, bodynum-1);
            }
        }else if (P==2){
            if (myrank == 0){
                simulator.simulate(0, bodynum/2 - 1);
            }else if (myrank == 1){
                simulator.simulate(bodynum/2, bodynum-1);
            }
        }else if (P==4){
            if (myrank == 0){      simulator.simulate(0,            bodynum/4 - 1);  }
            else if (myrank == 1){ simulator.simulate(bodynum/4,    bodynum/2 -1 );  }
            else if (myrank == 2){ simulator.simulate(bodynum/2,    bodynum*3/4 -1); }
            else if (myrank == 3){ simulator.simulate(bodynum*3/4, bodynum-1);       }

        }else if (P==8){
            if (myrank == 0){       simulator.simulate(0,           bodynum*1/8 - 1); }
            else if (myrank == 1){  simulator.simulate(bodynum*1/8, bodynum*2/8 - 1); }
            else if (myrank == 2){  simulator.simulate(bodynum*2/8, bodynum*3/8 - 1); }
            else if (myrank == 3){  simulator.simulate(bodynum*3/8, bodynum*4/8 - 1); }
            else if (myrank == 4){  simulator.simulate(bodynum*4/8, bodynum*5/8 - 1); }
            else if (myrank == 5){  simulator.simulate(bodynum*5/8, bodynum*6/8 - 1); }
            else if (myrank == 6){  simulator.simulate(bodynum*6/8, bodynum*7/8 - 1); }
            else if (myrank == 7){  simulator.simulate(bodynum*7/8, bodynum*8/8 - 1); }
        }
    }
}


//! 初期化関数
void setup(){
    // 描画領域の表示
    size(800, 800); 
    background(0, 0, 0);

    // N体問題の設定
    simulator = new NBodySimulation(width, height);
    simulator.setDt(DT);
    addBodies(simulator);

    // 並列処理の初期化
    if (P>=1){
        Parallel.init(new ParallelSimurataionCall(simulator.body.size()), P, this);
    }

}

//! 描画関数
void draw(){
    // 描画領域全体を黒で塗り潰す
    noStroke();
    fill(0, 0, 0, 255);
    rect(0, 0, width, height);

    // 物体情報の更新
    if (P >= 1){
        for (int i=0; i<BATCH_SIZE; i++){
            Parallel.fexec();
        }
    }else{
        for (int i=0; i<BATCH_SIZE; i++){
            simulator.simulate();
        }
    }

    // 物体の描画 
    fill(255, 255, 255, 255);
    simulator.draw();


    // フレームレートを表示する
    if (frameCount % 30 == 0){
        println("frameRate = " + frameRate);
    }
    text("frameRate: " + (int)(frameRate*100)/(double)100, 20, 20);

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


    for (int i=0; i<ANUM; i++){
        s.add(new Planet(new Vector(myrand(0.5,1.5)*2.0E+11,  myrand(0.5,1.5)*2.0E+11), 
                         new Vector(myrand(-1,1)*4.0E+4, myrand(-1,1)*4.0E+4 ), 
                         5.688E+25, 
                         ""));
    }
}


