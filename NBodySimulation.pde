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

        // //狭範囲
        // setView(new View(new Vector(0, 0), 2.0820893E+11*3, 2.0820893E+11*3, winwid, winhei));

        //中範囲
        setView(new View(new Vector(0, 0), 3.0820893E+11*3, 3.0820893E+11*3, winwid, winhei));

        ////広範囲
        //setView(new View(new Vector(0, 0), 8.0820893E+11*2.5, 8.0820893E+11*2.5, winwid, winhei));

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

    //! 全ての星を対象に，次の（dt秒後）の物体の状態を求める
    void simulate(){
        simulate(0, body.size());
    }

    //! 星番号startNoからnum個の星を対象に，1dt分だけ物体運動をシミュレートする
    void simulate(int startNo, int num){
        int endNo = startNo + num - 1;

        //println("simulate: " + startNo + " .. " + endNo);

        // 物体にかかる力をリセット
        for (int i=startNo; i<=endNo; i++){
            body.get(i).f.set(0, 0);
        }

        // 物体に加わる力を計算
        ////1 for (int i=0; i<body.size(); i++){
        ////1     for (int j=0; j<i; j++){
        ////1         Vector f = body.get(i).calcf(body.get(j));
        ////1         body.get(i).f.addD(f);
        ////1         body.get(j).f.subD(f);
        ////1     }
        ////1 }
        for (int i=startNo; i<=endNo; i++){
            for (int j=0; j<body.size(); j++){
                if (i != j){
                    Vector f = body.get(i).calcf(body.get(j));
                    body.get(i).f.addD(f);
                }
            }
        }

        // 物体を移動させる
        for (int i=startNo; i<=endNo; i++){
            body.get(i).move(dt);
        }

        //// 星0を描画領域の中心にする
        this.view.setOrigin(body.get(0).pos);

    }


    //! 現在の物体集合を描画する．
    void draw(){
        for (int i=0; i<body.size(); i++){
            body.get(i).draw(view);
        }
    }
}
