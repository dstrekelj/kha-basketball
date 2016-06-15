package;

import game.*;
import game.entities.*;
import game.objects.*;
import game.util.*;

import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.math.Random;

class Project {
	var teamL : Group<Player>;
	var teamR : Group<Player>;
	var court : Court;
	var ball : Ball;
	
	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		
		if (Random.Default == null) Random.init(160615);
		
		ball = new Ball(System.windowWidth() / 2, System.windowHeight() / 2);
		ball.setMovementBounds(0, 0, System.windowWidth(), System.windowHeight());
		
		court = new Court(0, System.windowHeight() * 4 / 5, System.windowWidth(), System.windowHeight() * 1 / 5 - ball.height);
		
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
		ball.update();
		
		teamL.each(function (p : Player) {
			if (ball.overlapsEntity(p)) {
				ball.resolveCollision(p);
			}
		});
		
		teamR.each(function (p : Player) {
			if (ball.overlapsEntity(p)) {
				ball.resolveCollision(p);
			}
		});
	}

	function render(framebuffer: Framebuffer): Void {
		var g2 = framebuffer.g2;
		g2.begin(Color.fromValue(0xff555555));
		
		g2.color = Color.fromValue(0xff888888);
		court.draw(g2);
		
		g2.color = Color.White;
		teamL.draw(g2);
		teamR.draw(g2);
		ball.draw(g2);
		
		g2.end();		
	}
}
