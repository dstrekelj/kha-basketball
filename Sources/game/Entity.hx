package game;

import kha.graphics2.Graphics;

class Entity extends Object {
    var isOverlapping : Bool;
    
    public function new(x : Float, y : Float, width : Float, height : Float) {
        super(x, y, width, height);
        
        isOverlapping = false;
    }
    
    public inline function overlapsPoint(px : Float, py : Float) : Bool {
        isOverlapping = false;
        
        if (x > px) return false;
        if (y > py) return false;
        if ((x + width) < px) return false;
        if ((y + height) < py) return false;
        
        isOverlapping = true;
        
        return true;
    }
    
    public inline function overlapsEntity(e : Entity) : Bool {
        isOverlapping = false;
        
        if (x > (e.x + e.width)) return false;
        if (y > (e.y + e.height)) return false;
        if ((x + width) < e.x) return false;
        if ((y + height) < e.y) return false;
        
        isOverlapping = true;
        
        return true;
    }
}
