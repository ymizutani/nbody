/**
*
* 描画する宇宙空間の領域
*
*/
class View {
    Vector origin;  //!< 表示する宇宙空間の中心座標．
    double w;       //!< 表示する宇宙空間の横幅[m]
    double h;       //!< 表示する宇宙空間の高さ[m]

    float window_width;   //!< 描画領域の横幅[pixel]
    float window_height;  //!< 描画領域の高さ[pixel]

    //! コンストラクタ
    View(Vector origin, double w, double h, float ww, float wh){
        this.origin = origin;
        this.w = w;
        this.h = h;
        this.window_width = ww;
        this.window_height = wh;
    }

    //  //! コンストラクタ
    //  View(){
    //      this(new Vector(0, 0), 0, 0, 0, 0);
    //  }

    //! コピーコンストラクタ
    View(View view){
        this.origin = new Vector(view.origin);
        this.w = view.w;
        this.h = view.h;
        this.window_width = view.window_width;
        this.window_height = view.window_height;
    }


    //! 表示する宇宙空間の左上の座標を設定する．
    void setOrigin(Vector o){
        origin = o;
    }

    //! 表示する宇宙空間の横と縦を設定する．
    void setOrigin(double w, double h){
        this.w = w;
        this.h = h;
    }

    //! ウィンドウの描画領域の大きさを設定する．
    void setWindow(float ww, float wh){
        this.window_width = ww;
        this.window_height = wh;
    }
        

    //! 宇宙空間のx座標を描画領域のx座標に変換する．
    float convertToWindowX(double x){
        return (float)((x - (origin.x - w/2)) / w * window_width);
    }

    //! 宇宙空間のy座標を描画領域のx座標に変換する．
    float convertToWindowY(double y){
        return (float)((y - (origin.y - h/2)) / h * window_height);
    }

}

