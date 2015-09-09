/*
* N体問題シミュレーションを表すクラス．
*/
class NBodySimulation {
    private ArrayList<Body> body;   //!< シミュレーションで扱う物体の集合．
    private View view = null;       //!< 宇宙空間の表示範囲．
    private int dt;                 //!< シミュレーション内の時間間隔．単位は秒．

    //! コンストラクタ
    NBodySimulation(int winwid, int winhei){
        body = new ArrayList<Body>();
        //setView(new View(new Vector(0, 0), 2.0820893E+11*3, 1.0820893E+11*3, winwid, winhei));
        setView(new View(new Vector(0, 0), 8.0820893E+11*2.5, 8.0820893E+11*2.5, winwid, winhei));
        setDt(600);
    }

    //! viewを設定する．
    void setView(View view){
        this.view = view;
    }

    //! dtを設定する．
    void setDt(int dt){
        this.dt = dt;
    }

    //! 物体を追加する
    void add(Body b){
        body.add(b);
    }

    //! 1dt分だけ物体運動をシミュレートする．
    void simulate(){

        // 物体にかかる力をリセット
        for (int i=0; i<body.size(); i++){
            body.get(i).f.set(0, 0);
        }

        // 物体に加わる力を計算
        for (int i=0; i<body.size(); i++){
            for (int j=0; j<i; j++){
                Vector f = body.get(i).calcf(body.get(j));
                body.get(i).f.addD(f);
                body.get(j).f.subD(f);
            }
        }

        // 物体を移動させる
        for (int i=0; i<body.size(); i++){
            body.get(i).move(dt);
        }

    }

    //! N回dt分だけ物体運動をシミュレートする．
    void simulate(int N){
        for (int i=0; i<N; i++){
            simulate();
        }
    }


    //! 現在の物体集合を描画する．
    void draw(){
        for (int i=0; i<body.size(); i++){
            body.get(i).draw(view);
        }
    }
}
