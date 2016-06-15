package game.entities;

import game.Sprite;

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
    
    public function new(x, y) {
        super(x, y, Assets.images.ball);
        
        Random.Default.GetIn(0, 1) == 0 ? dx = -1 : dx = 1;
        Random.Default.GetIn(0, 1) == 0 ? dy = -1 : dy = 1;
        
        minX = minY = 0;
        maxX = System.windowWidth() - width;
        maxY = System.windowHeight() - height;
        
        v = 3;
    }
    
    override public function update() : Void {
        x += dx * v;
        y += dy * v;
        
        if (x < minX || x > maxX) dx *= -1;
        if (y < minY || y > maxY) dy *= -1;
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
}