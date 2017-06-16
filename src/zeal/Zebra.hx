package zeal;
import htmlHelper.canvas.Leaf;
import zeal.Zeal;
import htmlHelper.tools.ImageLoader;
import js.html.ImageElement;
import js.html.CanvasRenderingContext2D;
import js.html.Element;
import js.Browser;
import js.html.CanvasRenderingContext2D;
class Zebra {
    var surface:            CanvasRenderingContext2D; 
    public var angle:       Float;
    // initial position
    var x:                  Int;
    var y:                  Int;
	var imageLoader:        ImageLoader;
	// Zebra body and limbs
    var body:               Leaf;
    var head:               Leaf;
    var neck:               Leaf;
    var chin:               Leaf;
    var tail:               Leaf;
    var backHoff:           Leaf;
    var frontHoff:          Leaf;
    var frontLegTop:        Leaf;
    var backLegTop:         Leaf;
    var frontLegBottom:     Leaf;
    var backLegBottom:      Leaf;  
    var backHoff2:          Leaf;
    var frontHoff2:         Leaf;
    var frontLegTop2:       Leaf;
    var backLegTop2:        Leaf;
    var frontLegBottom2:    Leaf;
    var backLegBottom2:     Leaf;
    public function new(    surface_:       CanvasRenderingContext2D
                        ,   x_:             Int
                        ,   y_:             Int 
                        ,   imageLoader_:   ImageLoader
                        ){
        angle       = Math.PI;
        surface     = surface_;
        x           = x_;
        y           = y_;
        imageLoader = imageLoader_;
        createSkeleton();
    }
    public inline function createSkeleton(){
        var images: Hash<ImageElement>  = imageLoader.images;
        var imageB                  = images.get('body.png');
        // create Leaf renderers for all the limbs.
        body                    = new Leaf( imageB, x, y );
        head                    = new Leaf( images.get('head.png') );
        neck                    = new Leaf( images.get('neck.png') );
        chin                    = new Leaf( images.get('chin.png') );
        tail                    = new Leaf( images.get('tail.png') );
        backHoff                = new Leaf( images.get('backHoff.png') );
        frontHoff               = new Leaf( images.get('frontHoff.png') );
        frontLegTop             = new Leaf( images.get('frontLegTop.png') );
        backLegTop              = new Leaf( images.get('backLegTop.png') );
        frontLegBottom          = new Leaf( images.get('frontLegBottom.png') );
        backLegBottom           = new Leaf( images.get('backLegBottom.png') );    
        backHoff2               = new Leaf( images.get('backHoff.png') );
        frontHoff2              = new Leaf( images.get('frontHoff.png') );
        frontLegTop2            = new Leaf( images.get('frontLegTop.png') );
        backLegTop2             = new Leaf( images.get('backLegTop.png') );
        frontLegBottom2         = new Leaf( images.get('frontLegBottom.png') );
        backLegBottom2          = new Leaf( images.get('backLegBottom.png') );
        // Add leaves to parents, with the offset that thier rotation point should be placed on.
        neck.addLeaf(               head,               18, 32 );
        head.addLeaf(               chin,               20, 62 );
        body.addLeaf(               tail,               230, 25 );
        body.addLeaf(               neck,               33, 49 );
        frontLegTop2.addLeaf(       frontLegBottom2,    35, 95 - 2  );
        backLegTop2.addLeaf(        backLegBottom2,     47, 75 - 2  );
        frontLegBottom2.addLeaf(    frontHoff2,         10, 50 - 2  );
        backLegBottom2.addLeaf(     backHoff2,          10, 55 - 2  );
        body.addLeaf(               backLegTop2,        185, 57 - 2 );
        body.addLeaf(               frontLegTop2,       28, 87 - 2  );
        frontLegTop.addLeaf(        frontLegBottom,     35, 95      );
        backLegTop.addLeaf(         backLegBottom,      47, 75      );
        frontLegBottom.addLeaf(     frontHoff,          10, 50      );
        backLegBottom.addLeaf(      backHoff,           10, 55      );
        body.addLeaf(               backLegTop,         185, 57     );
        body.addLeaf(               frontLegTop,        28, 87      );
        // setup starting limb rotation and thier rotation point.
        tail.rotate(                0, 5, 5 );
        body.rotate(                0, imageB.width/2, imageB.height/2 );
        chin.rotate(                0, 11, -5 );
        head.rotate(                0, 40, 30 );
        neck.rotate(                0, 80, 90 );        
        frontHoff.rotate(           0, 15, 0 );
        backHoff.rotate(            0, 15, 0 );
        frontLegBottom.rotate(      0, 10, 10 );
        backLegBottom.rotate(       0, 15, 5 );
        frontLegTop.rotate(         0, 25, 25 );
        backLegTop.rotate(          0, 23, -8 );
        frontHoff2.rotate(          0, 15, 0 );
        backHoff2.rotate(           0, 15, 0 );
        frontLegBottom2.rotate(     0, 10, 10 );
        backLegBottom2.rotate(      0, 15, 5 );
        frontLegTop2.rotate(        0, 25, 25 );
        backLegTop2.rotate(         0, 23, -8 );
        // have to call this to resolve set_theta
        body.renderOn( surface );
    }
    public inline
    function animateAcross(   dx:     Int -> Int -> Float -> Int
                          ,   dy:     Int -> Int -> Float -> Int
                          ){
        // clear last Zebra
        //surface.clearRect( body.left - 150, body.top - 100, body.wid + 300, body.hi + 300 );
        
        // Animate body of Zebra
        runMovement();
        // Move accross screen;
        x                       = dx( x, y, angle );
        y                       = dy( x, y, angle );
        body.x                  = x;
        body.y                  = y;
        // render Zebra on screen
        body.renderOn( surface );
    }
    public function setPosition( x_: Int, y_: Int ){
        x = x_;
        y = y_;
    }
    public inline 
    function runMovement(){
        angle += 0.4;
        // adjust angle of limbs, if not adjusted they assume to be just down
        // thier default rotation is not effected by their parent, only the position.
        var sin                 = Math.sin( angle );            
        var cos                 = Math.cos( angle );
        var cos2                = Math.cos( -angle );
        var spi                 = sin*Math.PI;
        var cpi                 = cos*Math.PI;
        body.theta              = -Math.PI/50*sin;
        frontLegTop2.theta      = cpi/7 + Math.PI/14;
        backLegTop2.theta       = Math.PI/10*cos2;
        frontLegBottom2.theta   = -Math.PI/10 - cpi/20 ;
        backLegBottom2.theta    = Math.PI/10 - Math.PI/10*cos2/2 ;
        frontLegTop.theta       = Math.PI/7*sin + Math.PI/14;
        backLegTop.theta        = spi/10;
        frontLegBottom.theta    = -Math.PI/10 - Math.PI/10*sin/2 ;
        backLegBottom.theta     = Math.PI/10 - Math.PI/10*sin/2 ;
        tail.theta              = spi/30;
        chin.theta              = spi/20 - Math.PI/10;
        neck.theta              = -spi/25;
    }
}