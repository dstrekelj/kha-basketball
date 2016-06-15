package game.entities;

import game.Sprite;
import game.util.EPlayer;

import kha.Assets;
import kha.System;
import kha.graphics2.Graphics;
import kha.math.Random;

class Ball extends Sprite {
    var minX : Float;
    var minY : Float;
    var maxX : Float;
    var maxY : Float;
    var dx : Int;
    var dy : Int;
    var v : Float;
    var resolvedCollision : Bool;
    
    public function new(x, y) {
        super(x, y, Assets.images.ball);
        positionCenter(x, y);
        
        Random.Default.GetIn(0, 1) == 0 ? dx = -1 : dx = 1;
        Random.Default.GetIn(0, 1) == 0 ? dy = -1 : dy = 1;
        
        minX = minY = 0;
        maxX = System.windowWidth() - width;
        maxY = System.windowHeight() - height;
        
        v = 4;
        resolvedCollision = false;
    }
    
    override public function update() : Void {
        x += dx * v;
        y += dy * v;
        
        if (x < minX || x > maxX) dx *= -1;
        if (y < minY || y > maxY) dy *= -1;
        
        if (!isOverlapping && resolvedCollision) {
            resolvedCollision = false;
        }
    }
    
    override public function draw(g : Graphics) : Void {
        super.draw(g);
    }
    
    public inline function setMovementBounds(minX : Float, minY : Float, maxX : Float, maxY : Float) : Void {
        this.minX = minX;
        this.minY = minY;
        this.maxX = maxX - width;
        this.maxY = maxY - height;
    }
    
    public inline function resolveCollision(p : Player) : Void {
        if (!resolvedCollision) {
            resolvedCollision = true;
            dx = (p.player == EPlayer.PLAYER_1) ? 1 : -1;
            dy = ((y - height) < (p.y + p.height / 2)) ? -1 : 1;
        }
    }
}
