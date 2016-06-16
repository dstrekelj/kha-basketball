package game.objects;

import game.ui.Text;

import kha.Font;

class Timer extends Text {
    public var onComplete : Void->Void;
    public var time : Int;
    
    public function new(font : Font, size : Int, time : Int) {
        super(font, size);
        
        this.time = time;
        onComplete = null;
        
        value = Std.string(time);
    }
    
    override public function update() : Void {
        time -= 1;
        value = format(time);
        if (time == 0 && onComplete != null) {
            trace('onComplete');
            onComplete();
        }
    }
    
    function format(v : Int) : String {
        if (v < 1) return "000";
        if (v < 10) return "00" + Std.string(v);
        if (v < 100) return "0" + Std.string(v);
        return Std.string(v);
    }
} 