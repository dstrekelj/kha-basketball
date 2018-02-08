package game.entities;

import kha.Assets;
import kha.System;
import kha.graphics2.Graphics;
import kha.input.KeyCode;
import kha.input.Keyboard;

import game.Sprite;
import game.util.EPlayer;

class Player extends Sprite {
    public var player : EPlayer;
    
    var dy : Int;
    var v : Float;
    var minY : Float;
    var maxY : Float;
    
    public function new(x : Float, y : Float, player : EPlayer) {
        super(0, 0, player == EPlayer.PLAYER_1 ? Assets.images.player_striped : Assets.images.player_full);
        
        this.player = player;
        
        positionCenter(x, y);
        
        dy = 0;
        v = 10;
        minY = 0;
        maxY = System.windowHeight() - height;
        
        if (Keyboard.get() != null) Keyboard.get().notify(onKeyDown, onKeyUp);
    }
    
    override public function update() : Void {
        y += dy * v;
        
        if (y < minY) y = minY;
        if (y > maxY) y = maxY;
    }
    
    override public function draw(g : Graphics) : Void {
        super.draw(g);
    }
    
    public inline function setMovementBounds(minY : Float, maxY : Float) : Void {
        this.minY = minY;
        this.maxY = maxY - height;
    }
    
    private function onKeyDown(keyCode:KeyCode):Void {
        if (player == EPlayer.PLAYER_1) {
            switch (keyCode) {
                case KeyCode.W: dy = -1;
                case KeyCode.S: dy = 1;
            default: return;
            }
        } else {
            switch (keyCode) {
                case KeyCode.O: dy = -1;
                case KeyCode.L: dy = 1;
            default: return;
            }
        }
    }
    
    private function onKeyUp(keyCode:KeyCode):Void {
        if (player == EPlayer.PLAYER_1) {
            switch (keyCode){
                case KeyCode.W: dy = 0;
                case KeyCode.S: dy = 0;
            default: return;
            }
        } else {
            switch (keyCode) {
                case KeyCode.O: dy = 0;
                case KeyCode.L: dy = 0;
            default: return;
            }
        }
    }
}
