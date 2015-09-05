
/**
* 名前付きの物体を表す抽象クラス
*/
class NamedBody extends Body {
    String name;

    //! コンストラクタ
    NamedBody(String n){
        super();
        name = n;
    }

    void draw(){
        println("NamedBody.draw()");
    }

}

