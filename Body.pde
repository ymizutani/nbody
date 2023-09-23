/**
* 物体を表す抽象クラス
*/
abstract class Body {
    Vector pos; //!< 物体の位置[m]
    Vector v;   //!< 物体の速度[m/s]
    double m;   //!< 物体の質量[kg]

    //計算用のフィールド
    Vector f;   //!< 物体が受ける力[m/s^2]


    //! コンストラクタ
    Body(Vector pos, Vector v, double m){
        this.pos = pos;
        this.v = v;
        this.m = m;
        this.f =  new Vector();
    }

    //! コンストラクタ
    Body(){
        this(new Vector(), new Vector(), 0);
    }

    //! 位置を設定する．
    void setPos(Vector p){
        this.pos = p;
    }

    //! 位置を設定する．
    void setPos(double x, double y ){
        this.pos = new Vector(x, y);
    }

    //! 破壊的に位置を設定する．
    void setPosD(double x, double y ){
        this.pos.x = x;
        this.pos.y = y;
    }

    //! 速度を設定する．
    void setV(Vector v){
        this.v = v;
    }

    //! 速度を設定する．
    void setV(double vx, double vy ){
        this.v = new Vector(vx, vy);
    }

    //! 破壊的に速度を設定する．
    void setVD(double vx, double vy ){
        this.v.x = vx;
        this.v.y = vy;
    }

    //! 加速度を設定する．
    void setF(Vector f){
        this.f = f;
    }

    //! 加速度を設定する．
    void setF(double fx, double fy){
        this.f = new Vector(fx, fy);
    }

    //! 破壊的に加速度を設定する．
    void setFD(double fx, double fy ){
        this.f.x = fx;
        this.f.y = fy;
    }

    //! 質量を設定する．
    void setM(double m){
        this.m = m;
    }

    //! 物体間の重力を計算する
    Vector calcf(Body target){
        double R = this.pos.distance(target.pos);
        double absf = 6.67408E-11 * this.m * target.m / (R*R);
        double cost = (target.pos.x - this.pos.x)/R;
        double sint = (target.pos.y - this.pos.y)/R;
        return new Vector(absf*cost, absf*sint);
    }

    //! 物体を移動させる 
    void move(double dt){
        // 物体の加速度を計算
        double ax = this.f.x / this.m;
        double ay = this.f.y / this.m;

        // dt秒後の物体の位置を計算
        double newposx = pos.x + v.x * dt  + 0.5 * ax * dt * dt;
        double newposy = pos.y + v.y * dt  + 0.5 * ay * dt * dt;
        this.setPosD(newposx, newposy);

        // dt秒後の物体の速度を計算
        double newvx = v.x + ax * dt;
        double newvy = v.y + ay * dt;
        this.setVD(newvx, newvy);
    }


    String toString(){
        return "pos:" + pos.toString() + ", v:" + v.toString() + ", f:" + f.toString() + ", m:" + m;
    }

    //! 物体を描画するメソッド．
    abstract void draw(View v);

}
