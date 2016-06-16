package;

import game.*;
import game.entities.*;
import game.objects.*;
import game.ui.*;
import game.util.*;

import kha.Assets;
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
	var instructions : Text;
	var scoreL : Text;
	var scoreR : Text;
	var timer : Timer;
	
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
		
		instructions = new Text(Assets.fonts.slkscr, 16);
		instructions.value = "PLAYER 1: STRIPED. 'W' - UP, 'S' - DOWN.    PLAYER 2: OPAQUE. 'O' - UP, 'L' - DOWN.";
		instructions.position(0, System.windowHeight() - instructions.height);
		
		scoreL = new Text(Assets.fonts.slkscr, 64);
		scoreR = new Text(Assets.fonts.slkscr, 64);
		
		timer = new Timer(Assets.fonts.slkscr, 64, 110);
		timer.positionCenter(System.windowWidth() / 2, timer.height);
		timer.onComplete = endGame;
		Scheduler.addTimeTask(timer.update, 0, 1, timer.time);
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
			scoreR.value = Std.string(basketL.ballsPassed);
			scoreR.positionCenter(System.windowWidth() * 2 / 3, System.windowHeight() - scoreR.height);
		} else {
			ball.resolveBasketCollision(basketR);
			scoreL.value = Std.string(basketR.ballsPassed);
			scoreL.positionCenter(System.windowWidth() / 3, System.windowHeight() - scoreL.height);
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
		
		timer.draw(g2);
		
		instructions.draw(g2);
		
		g2.color = Color.fromValue(0xff333333);
		scoreL.draw(g2);
		scoreR.draw(g2);
		
		g2.end();		
	}
	
	function endGame() : Void {
		ball.active = false;
		ball.visible = false;
	}
}
