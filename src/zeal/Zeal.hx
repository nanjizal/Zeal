package zeal;
import htmlHelper.canvas.Leaf;
import htmlHelper.tools.ImageLoader;
import htmlHelper.tools.AnimateTimer;
import zeal.Zebra;
import js.html.ImageElement;
import js.html.CanvasRenderingContext2D;
import js.html.Element;
import js.Browser;
import js.html.CanvasRenderingContext2D;
typedef Hash<T> = haxe.ds.StringMap<T>;
class Zeal {
    var body:               Element;
    var surface:            CanvasRenderingContext2D;    
    var zebraSkin:          ImageLoader;
    var zebras:             Array<Zebra>;
    var zebra2:             Zebra;
    var zebra3:             Zebra;
    var zebra4:             Zebra;
    static inline var numberOfZebra: Int = 7;
    public function new( surface_: CanvasRenderingContext2D ){
        surface = surface_;
        zebraSkin = new ImageLoader
                    (  
                        [   'zebraParts/frontLegTop.png'
                        ,   'zebraParts/frontLegBottom.png'
                        ,   'zebraParts/frontHoff.png'
                        ,   'zebraParts/backLegTop.png'
                        ,   'zebraParts/backLegBottom.png'
                        ,   'zebraParts/backHoff.png'
                        ,   'zebraParts/body.png'
                        ,   'zebraParts/tail.png'
                        ,   'zebraParts/neck.png'
                        ,   'zebraParts/head.png'
                        ,   'zebraParts/chin.png'
                        ]
                        ,   onZebraLoaded
                    );
    }
    function onZebraLoaded(){ //trace( 'loaded assests for zebra ');
        zebras = [];
        for( i in 0...numberOfZebra )
        {
            var zebra = new Zebra(  surface
                                ,   Std.int( 700 + Math.random()*300)
                                ,   Std.int( 100+i*30)
                                ,   zebraSkin 
                                );
            
            zebra.angle = Math.PI/( Math.random()*8 );
            zebras.push( zebra );
        }
        animate();
    }
    function animate(){
        AnimateTimer.onFrame = animateZebra;
        AnimateTimer.create();
        //var timer = new haxe.Timer( Math.floor( 1000/30 ) );
        //timer.run = animateZebra;
    }
    inline 
    function animateZebra( count: Int ){
        surface.clearRect( 0, 0, 1024, 768 );
        for( i in 0...numberOfZebra ){ 
            zebras[i].animateAcross(    minus13 
                                    ,   upAndDown
                                    );
        }
        if( count > 80 ) resetZeal();
    }
    function resetZeal(){
        for( i in 0...numberOfZebra ){ 
            zebras[i].setPosition(   Std.int( 700 + Math.random()*300)
                                  ,   Std.int( 100+i*30)
                                  );
        }
        AnimateTimer.counter = 0;
    }
    inline public
    function minus13( x: Int, y: Int, angle: Float ): Int {
        return x - 13;
    }
    inline public
    function upAndDown( x: Int, y: Int, angle: Float ): Int {
        return y + Std.int( 3*Math.sin( angle/7 ) );
    }
}