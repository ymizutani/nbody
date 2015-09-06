
/**
* 名前付きの物体を表す抽象クラス
*/
class NamedBody extends Body {
    String name;

    //! コンストラクタ
    NamedBody(Vector pos, Vector v, Vector a, double m, String n){
        super(pos, v, a, m);
        name = n;
    }

    //! コンストラクタ
    NamedBody(double px, double py, double vx, double vy, double ax, double ay, double m, String n){
        super(px, py, vx, vy, ax, ay, m);
        name = n;
    }

    //! コンストラクタ
    NamedBody(String n){
        super();
        name = n;
    }

    void draw(){
        println("NamedBody.draw()");
        ellipse((float)pos.x, (float)pos.y, 10, 10);
    }

}
