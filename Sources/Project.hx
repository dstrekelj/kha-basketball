package;

import game.*;
import game.util.*;
import game.entities.*;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Project {
	var teamL : Group<Player>;
	var teamR : Group<Player>;
	
	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		
		teamL = new Group<Player>();
		teamL.add(new Player(System.windowWidth() * 2 / 5, 100, EPlayer.PLAYER_1));
		teamL.add(new Player(System.windowWidth() * 4 / 5, 100, EPlayer.PLAYER_1));
		
		teamR = new Group<Player>();
		teamR.add(new Player(System.windowWidth() * 1 / 5, 100, EPlayer.PLAYER_2));
		teamR.add(new Player(System.windowWidth() * 3 / 5, 100, EPlayer.PLAYER_2));
	}

	function update(): Void {
		teamL.update();
		teamR.update();
	}

	function render(framebuffer: Framebuffer): Void {
		var g2 = framebuffer.g2;
		g2.begin(kha.Color.Black);
		g2.color = kha.Color.White;
		
		teamL.draw(g2);
		teamR.draw(g2);
		
		g2.end();		
	}
}
