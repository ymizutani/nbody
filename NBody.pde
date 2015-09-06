/**
* N体問題シミュレーションを表すクラス．
*/
class NBody {
    private ArrayList<Body> body;   //!< シミュレーションで扱う物体の集合．
    private View view = null;       //!< 宇宙空間の表示範囲．
    private int dt;                 //!< シミュレーション内の時間間隔．単位は秒．

    //! コンストラクタ
    NBody(int winwid, int winhei){
        body = new ArrayList<Body>();
        setView(new View(new Vector(0, 0), 1.0820893E+11*3, 1.0820893E+11*3, winwid, winhei));
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


    //! 現在の物体集合を描画する．
    void draw(){
        for (int i=0; i<body.size(); i++){
            body.get(i).draw(view);
        }
    }
}
