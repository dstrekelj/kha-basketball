package game.entities;

import kha.Assets;
import kha.graphics2.Graphics;

import game.Sprite;
import game.util.EPlayer;

class Basket extends Sprite {
    public var ballsPassed : Int;
    
    var backboardOffset : Float;
    
    public function new(x : Float, y : Float, player : EPlayer) {
        super(x, y, Assets.images.basket);
        
        ballsPassed = 0;
        
        backboardOffset = 0;
        
        if (player == PLAYER_2) {
            this.x -= width;
            backboardOffset = width;
        }
    }
    
    override public function draw(g : Graphics) : Void {
        super.draw(g);
        g.drawLine(x + backboardOffset, y + height, x + backboardOffset, 0, 8);
    }
}
