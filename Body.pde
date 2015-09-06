
/**
* 物体を表す抽象クラス
*/
abstract class Body {
    Vector pos; //!< 位置[m]
    Vector v;   //!< 速度[m/s]
    Vector a;   //!< 加速度[m/s^2]
    double m;   //!< 質量[kg]

    //! コンストラクタ
    Body(Vector pos, Vector v, Vector a, double m){
        this.pos = pos;
        this.v = v;
        this.a = a;
        this.m = m;
    }

    //! コンストラクタ
    Body(double px, double py, double vx, double vy, double ax, double ay, double m){
        this(new Vector(px, py),
                new Vector(vx, vy),
                new Vector(ax, ay),
                m);
    }

    //! コンストラクタ
    Body(){
        this(0, 0, 0, 0, 0, 0, 0);
    }

    String toString(){
        return "pos:" + pos.toString() + ", v:" + v.toString() + ", a:" + a.toString() + ", m:" + m;
    }

    //! 物体を描画するメソッド．
    abstract void draw();

}

