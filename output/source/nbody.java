import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class nbody extends PApplet {


//! \u521d\u671f\u5316\u95a2\u6570
public void setup(){
    size(400, 400); 
}

//! \u63cf\u753b\u95a2\u6570
public void draw(){
    
}

/**
* \u7269\u4f53\u3092\u8868\u3059\u62bd\u8c61\u30af\u30e9\u30b9
*/
abstract class Body {
    Vector pos; //!< \u4f4d\u7f6e[m]
    Vector v;   //!< \u901f\u5ea6[m/s]
    Vector a;   //!< \u52a0\u901f\u5ea6[m/s^2]
    double m;   //!< \u8cea\u91cf[kg]

    //! \u30b3\u30f3\u30b9\u30c8\u30e9\u30af\u30bf
    Body(){
        pos = new Vector();
        m = 0.0f;
        v = new Vector();
        a = new Vector();
    }


    //! \u7269\u4f53\u3092\u63cf\u753b\u3059\u308b\u30e1\u30bd\u30c3\u30c9\uff0e
    public abstract void draw();

}


/**
* \u540d\u524d\u4ed8\u304d\u306e\u7269\u4f53\u3092\u8868\u3059\u62bd\u8c61\u30af\u30e9\u30b9
*/
class NamedBody extends Body {
    String name;

    //! \u30b3\u30f3\u30b9\u30c8\u30e9\u30af\u30bf
    NamedBody(String n){
        super();
        name = n;
    }

    public void draw(){
        println("NamedBody.draw()");
    }

}


/**
* 2\u6b21\u5143\u30d9\u30af\u30c8\u30eb\u3092\u8868\u3059\u30af\u30e9\u30b9
*/
class Vector {
    double x;
    double y;

    //! \u30b3\u30f3\u30b9\u30c8\u30e9\u30af\u30bf
    public Vector(double x0, double y0){
        x = 0;
        y = 0;
    }

    //! \u30b3\u30f3\u30b9\u30c8\u30e9\u30af\u30bf
    public Vector(){
        this(0, 0);
    }

    //! \u30b3\u30f3\u30b9\u30c8\u30e9\u30af\u30bf
    public Vector(Vector v){
        this(v.x, v.y);
    }

    //! \u52a0\u7b97\uff08\u526f\u4f5c\u7528\u3042\u308a\uff09
    public Vector add(double x1, double y1){
        return new Vector(this.x + x1, this.y + y1);
    }

    //! \u52a0\u7b97\uff08\u526f\u4f5c\u7528\u3042\u308a\uff09
    public Vector add(Vector v){
        return add(v.x, v.y);
    }

    //! \u52a0\u7b97\uff08\u526f\u4f5c\u7528\u306a\u3057\uff09
    public void addD(double x1, double y1){
        this.x += x1;
        this.y += y1;
    }

    //! \u52a0\u7b97\uff08\u526f\u4f5c\u7528\u306a\u3057\uff09
    public void addD(Vector v){
        addD(v.x, v.y);
    }

    //! \u6e1b\u7b97\uff08\u526f\u4f5c\u7528\u306a\u3057\uff09
    public Vector sub(double x1, double y1){
        return new Vector(this.x - x1, this.y - y1);
    }

    //! \u6e1b\u7b97\uff08\u526f\u4f5c\u7528\u306a\u3057\uff09
    public Vector sub(Vector v){
        return sub(v.x, v.y, v.z);
    }

    //! \u6e1b\u7b97\uff08\u526f\u4f5c\u7528\u3042\u308a\uff09
    public void subD(double x1, double y1){
        this.x -= x1;
        this.y -= y1;
        this.z -= z1;
    }

    //! \u6e1b\u7b97\uff08\u526f\u4f5c\u7528\u3042\u308a\uff09
    public void subD(Vector v){
        subD(v.x, v.y);
    }



    // \u8868\u793a
    public String toString(){
        return "(" + this.x + ", " + this.y + ", " + this.z + ")";
    }

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "nbody" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
