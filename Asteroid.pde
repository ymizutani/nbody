
/**
* 小惑星を表す抽象クラス
*/
class Asteroid extends Body {
    String name;

    //! コンストラクタ
    Asteroid(Vector pos, Vector v, double m, String n){
        super(pos, v, m);
        name = " " + n;
    }

    //! コンストラクタ
    Asteroid(String n){
        super();
        name = " " + n;
    }

    void draw(View view){
        //println("Planet.draw(): " + name + ", " + width + ", " + height);
        ellipse(view.convertToWindowX(pos.x),
                view.convertToWindowY(pos.y), 4, 4);
        text(this.name, view.convertToWindowX(pos.x), view.convertToWindowY(pos.y));
    }

}
