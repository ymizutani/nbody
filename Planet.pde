
/**
* 名前付きの物体を表す抽象クラス
*/
class Planet extends Body {
    String name;

    //! コンストラクタ
    Planet(Vector pos, Vector v, double m, String n){
        super(pos, v, m);
        name = " " + n;
    }

    //! コンストラクタ
    Planet(String n){
        super();
        name = " " + n;
    }

    void draw(View view){
        //println("Planet.draw(): " + name + ", " + width + ", " + height);
        ellipse(view.convertToWindowX(pos.x),
                view.convertToWindowY(pos.y), 10, 10);
        text(this.name, view.convertToWindowX(pos.x), view.convertToWindowY(pos.y));
    }

}
