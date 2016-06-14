package game.objects;

import game.Object;

import kha.graphics2.Graphics;

class Court extends Object {
    public function new(x, y, width, height) {
        super(x, y, width, height);
    }
    
    override public function draw(g : Graphics) : Void {
        g.fillRect(x, y, width, height);
    }
}