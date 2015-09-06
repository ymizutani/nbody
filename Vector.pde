
/**
* 2次元ベクトルを表すクラス
*/
class Vector {
    double x;
    double y;

    //! コンストラクタ
    public Vector(double x0, double y0){
        x = x0;
        y = y0;
    }

    //! コンストラクタ
    public Vector(){
        this(0, 0);
    }

    //! コピーコンストラクタ
    public Vector(Vector v){
        this(v.x, v.y);
    }


    //! 加算（副作用あり）
    public Vector add(double x1, double y1){
        return new Vector(this.x + x1, this.y + y1);
    }

    //! 加算（副作用あり）
    public Vector add(Vector v){
        return add(v.x, v.y);
    }

    //! 加算（副作用なし）
    public void addD(double x1, double y1){
        this.x += x1;
        this.y += y1;
    }

    //! 加算（副作用なし）
    public void addD(Vector v){
        addD(v.x, v.y);
    }

    //! 減算（副作用なし）
    public Vector sub(double x1, double y1){
        return new Vector(this.x - x1, this.y - y1);
    }

    //! 減算（副作用なし）
    public Vector sub(Vector v){
        return sub(v.x, v.y);
    }

    //! 減算（副作用あり）
    public void subD(double x1, double y1){
        this.x -= x1;
        this.y -= y1;
    }

    //! 減算（副作用あり）
    public void subD(Vector v){
        subD(v.x, v.y);
    }



    // 表示
    public String toString(){
        return "(" + this.x + ", " + this.y + ")";
    }

}
