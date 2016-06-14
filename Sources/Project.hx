package;

import game.*;
import game.entities.*;
import game.objects.*;
import game.util.*;

import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Project {
	var teamL : Group<Player>;
	var teamR : Group<Player>;
	var court : Court;
	
	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		
		court = new Court(0, System.windowHeight() * 4 / 5, System.windowWidth(), System.windowHeight() * 1 / 5);
		
		teamL = new Group<Player>();
		teamL.add(new Player(System.windowWidth() * 1 / 5, court.y, EPlayer.PLAYER_1));
		teamL.add(new Player(System.windowWidth() * 3 / 5, court.y, EPlayer.PLAYER_1));
		teamL.each(function (p) { p.setMovementBounds(System.windowHeight() / 5, court.y); });
		
		teamR = new Group<Player>();
		teamR.add(new Player(System.windowWidth() * 2 / 5, court.y, EPlayer.PLAYER_2));
		teamR.add(new Player(System.windowWidth() * 4 / 5, court.y, EPlayer.PLAYER_2));
		teamR.each(function (p) { p.setMovementBounds(System.windowHeight() / 5, court.y); });
	}

	function update(): Void {
		teamL.update();
		teamR.update();
	}

	function render(framebuffer: Framebuffer): Void {
		var g2 = framebuffer.g2;
		g2.begin(Color.Black);
		g2.color = Color.White;
		
		teamL.draw(g2);
		teamR.draw(g2);
		
		g2.color = Color.Orange;
		court.draw(g2);
		
		g2.end();		
	}
}
