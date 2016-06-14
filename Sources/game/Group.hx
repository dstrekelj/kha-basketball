package game;

import game.Object;

import kha.graphics2.Graphics;

class Group<T : Object> {
    var elements : Array<T>;
    
    public inline function new() {
        elements = new Array<T>();
    }
    
    public inline function update() : Void {
        for (e in elements) e.update();
    }
    
    public inline function draw(g : Graphics) : Void {
        for (e in elements) e.draw(g);
    }
    
    public inline function add(e : T) : Void {
        elements.push(e);
    }
    
    public inline function each(f : T->Void) {
        for (e in elements) f(e);
    }
}