package game;

import kha.graphics2.Graphics;

class Object {
    public var x : Float;
    public var y : Float;
    public var width : Float;
    public var height : Float;
    public var active : Bool;
    public var visible : Bool;
    
    public function new(x : Float, y : Float, width : Float, height : Float) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        active = true;
        visible = true;
    }
    
    public function update() : Void {}
    
    public function draw(g : Graphics) : Void {}
    
    public inline function positionCenter(x : Float, y : Float) : Void {
        this.x = x - width / 2;
        this.y = y - height / 2;
    }
    
    public inline function position(x : Float, y : Float) : Void {
        this.x = x;
        this.y = y;
    }
}
