/**
* 物体を表す抽象クラス
*/
abstract class Body {
    Vector pos; //!< 位置[m]
    Vector v;   //!< 速度[m/s]
    double m;   //!< 質量[kg]

    //計算用のフィールド
    Vector a;   //!< 加速度[m/s^2]


    //! コンストラクタ
    Body(Vector pos, Vector v, double m){
        this.pos = pos;
        this.v = v;
        this.m = m;
    }

    //! コンストラクタ
    Body(){
        this(new Vector(0, 0), new Vector(0, 0), 0);
    }

    //! 位置を設定する．
    void setPos(Vector p){
        this.pos = p;
    }

    //! 位置を設定する．
    void setPos(double x, double y ){
        this.pos = new Vector(x, y);
    }

    //! 速度を設定する．
    void setV(Vector v){
        this.v = v;
    }

    //! 速度を設定する．
    void setV(double vx, double vy ){
        this.v = new Vector(vx, vy);
    }

    //! 加速度を設定する．
    void setA(Vector a){
        this.a = a;
    }

    //! 加速度を設定する．
    void setA(double vx, double vy ){
        this.a = new Vector(vx, vy);
    }

    //! 質量を設定する．
    void setM(double m){
        this.m = m;
    }


    String toString(){
        return "pos:" + pos.toString() + ", v:" + v.toString() + ", a:" + a.toString() + ", m:" + m;
    }

    //! 物体を描画するメソッド．
    abstract void draw(View v);

}

