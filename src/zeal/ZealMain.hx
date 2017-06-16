package zeal;
import js.Browser;
import htmlHelper.canvas.Leaf;
import htmlHelper.canvas.CanvasWrapper;
import htmlHelper.tools.ImageLoader;
import js.html.Element;
import js.html.ImageElement;
import js.html.CanvasRenderingContext2D;
import zeal.Zeal;
using zeal.ZealMain;
class ZealMain{
    var canvas: CanvasRenderingContext2D;
    static function main(){ new ZealMain(); } public function new(){
        var canvas = new CanvasWrapper();
        Leaf.showBoxes = true;
        Leaf.showCrosses = true;
        canvas.width = 1024;
        canvas.height = 768;
        Browser.document.body.appendChild( cast canvas );
        new Zeal( canvas.getContext2d() );
    }
}