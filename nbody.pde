NamedBody b1 = new NamedBody("hoge");
NamedBody b2 = new NamedBody(100, 100, 0, 0, 0, 0, 0, "foo");

//! 初期化関数
void setup(){
    size(400, 400); 
}

//! 描画関数
void draw(){
    println(b1.toString());
    println(b2.toString());
    b1.draw();
    b2.draw();
}
