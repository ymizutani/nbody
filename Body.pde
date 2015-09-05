
/**
* 物体を表す抽象クラス
*/
abstract class Body {
    Vector pos; //!< 位置[m]
    Vector v;   //!< 速度[m/s]
    Vector a;   //!< 加速度[m/s^2]
    double m;   //!< 質量[kg]

    //! コンストラクタ
    Body(){
        pos = new Vector();
        m = 0.0;
        v = new Vector();
        a = new Vector();
    }


    //! 物体を描画するメソッド．
    abstract void draw();

}

