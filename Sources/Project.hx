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
	var basketL : Basket;
	var basketR : Basket;
	
	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		
		if (Random.Default == null) Random.init(160615);
		
		basketL = new Basket(System.windowWidth() / 15, System.windowHeight() * 2 / 7, EPlayer.PLAYER_1);
		basketR = new Basket(System.windowWidth() * 14 / 15, System.windowHeight() * 2 / 7, EPlayer.PLAYER_2);
		
		ball = new Ball(System.windowWidth() / 2, System.windowHeight() / 2);
		ball.setMovementBounds(System.windowWidth() / 15, 0, System.windowWidth() * 14 / 15, System.windowHeight());
		
		court = new Court(0, System.windowHeight() * 4 / 5, System.windowWidth(), System.windowHeight() * 1 / 5 - ball.height);
		
		teamL = new Group<Player>();
		teamL.add(new Player(System.windowWidth() * 1 / 5, court.y, EPlayer.PLAYER_1));
		teamL.add(new Player(System.windowWidth() * 3 / 5, court.y, EPlayer.PLAYER_1));
		teamL.each(function (p) { p.setMovementBounds(System.windowHeight() / 5, court.y); });
		
		teamR = new Group<Player>();
		teamR.add(new Player(System.windowWidth() * 4 / 5, court.y, EPlayer.PLAYER_2));
		teamR.add(new Player(System.windowWidth() * 2 / 5, court.y, EPlayer.PLAYER_2));
		teamR.each(function (p) { p.setMovementBounds(System.windowHeight() / 5, court.y); });
	}

	function update(): Void {
		teamL.update();
		teamR.update();
		ball.update();
		
		teamL.each(function (p : Player) {
			ball.resolvePlayerCollision(p);
		});
		
		teamR.each(function (p : Player) {
			ball.resolvePlayerCollision(p);
		});
		
		if (ball.x < (System.windowWidth() / 2)) {
			ball.resolveBasketCollision(basketL);
		} else {
			ball.resolveBasketCollision(basketR);
		}
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
		basketL.draw(g2);
		basketR.draw(g2);
		
		g2.end();		
	}
}
