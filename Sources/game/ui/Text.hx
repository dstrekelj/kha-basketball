package game.ui;

import game.Object;

import kha.Font;
import kha.graphics2.Graphics;

class Text extends Object {
    public var font : Font;
    public var size(default, set) : Int;
    public var value(default, set) : String; 
    
    public function new(font : Font, size : Int) {
        super(0, 0, 0, 0);
        this.font = font;
        this.size = size;
        this.value = "";
    }
    
    override public function draw(g : Graphics) : Void {
        g.font = font;
        g.fontSize = size;
        g.drawString(value, x, y);
    }
    
    private function set_value(v : String) : String {
        value = v;
        height = font.height(size);
        width = font.width(size, value);
        return value;
    }
    
    private function set_size(s : Int) : Int {
        size = s;
        height = font.height(size);
        width = font.width(size, value);
        return size;
    }
}
