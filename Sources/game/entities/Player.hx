package game.entities;

import game.Sprite;
import game.util.EPlayer;

import kha.Assets;
import kha.Key;
import kha.graphics2.Graphics;
import kha.input.Keyboard;

class Player extends Sprite {
    var dy : Int;
    var v : Float;
    var player : EPlayer;
    
    public function new(x : Float, y : Float, player : EPlayer) {
        super(0, 0, player == EPlayer.PLAYER_1 ? Assets.images.player_a : Assets.images.player_b);
        
        this.player = player;
        
        positionCenter(x, y);
        
        dy = 0;
        v = 8;
        
        if (Keyboard.get() != null) Keyboard.get().notify(onKeyDown, onKeyUp);
    }
    
    override public function update() : Void {
        y += dy * v; 
    }
    
    override public function draw(g : Graphics) : Void {
        super.draw(g);
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