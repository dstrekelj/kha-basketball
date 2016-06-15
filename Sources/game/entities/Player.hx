package game.entities;

import game.Sprite;
import game.util.EPlayer;

import kha.Assets;
import kha.Key;
import kha.System;
import kha.graphics2.Graphics;
import kha.input.Keyboard;

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
    
    private function onKeyDown(key : Key, char : String) : Void {
        if (player == EPlayer.PLAYER_1) {
            switch (char) {
                case "w": dy = -1;
                case "s": dy = 1;
            }
        } else {
            switch (char) {
                case "o": dy = -1;
                case "l": dy = 1;
            }
        }
    }
    
    private function onKeyUp(key : Key, char : String) : Void {
        if (player == EPlayer.PLAYER_1) {
            switch (char) {
                case "w": dy = 0;
                case "s": dy = 0;
            }
        } else {
            switch (char) {
                case "o": dy = 0;
                case "l": dy = 0;
            }
        }
    }
}
