package game;

import kha.Image;
import kha.graphics2.Graphics;

class Sprite extends Entity {
    public var graphic : Image;
    
    public function new(x : Float, y : Float, graphic : Image) {
        super(x, y, graphic.width, graphic.height);
        this.graphic = graphic;
    }
    
    override public function draw(g : Graphics) : Void {
        super.draw(g);
        
        g.drawImage(graphic, x, y);
    }
}
