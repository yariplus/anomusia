package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.text.FlxText;
import flixel.*;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;

import flash.events.Event;

import entities.CrEntity;

import maps.Map;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	
	private var _player:FlxText;
	private var _level:FlxText;
	
	private var _walls:FlxGroup;
	private var _leftWall:FlxSprite;
	private var _rightWall:FlxSprite;
	private var _topWall:FlxSprite;
	private var _bottomWall:FlxSprite;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		_walls = new FlxGroup();

		_leftWall = new FlxSprite(0, 0);
		_leftWall.makeGraphic(10, 240, FlxColor.GRAY);
		_leftWall.immovable = true;
		_walls.add(_leftWall);

		_rightWall = new FlxSprite(310, 0);
		_rightWall.makeGraphic(10, 240, FlxColor.GRAY);
		_rightWall.immovable = true;
		_walls.add(_rightWall);

		_topWall = new FlxSprite(0, 0);
		_topWall.makeGraphic(320, 10, FlxColor.GRAY);
		_topWall.immovable = true;
		_walls.add(_topWall);

		_bottomWall = new FlxSprite(0, 239);
		_bottomWall.makeGraphic(320, 10, FlxColor.TRANSPARENT);
		_bottomWall.immovable = true;
		_walls.add(_bottomWall);
		
		add(_walls);
		
		_player = new FlxText(30, 30, 160, "Test");
		_player.setFormat(null, 8, FlxColor.WHITE, "left", FlxText.BORDER_NONE, FlxColor.BLUE);
		add(_player);
		
		_player.moves = true;
		_player.maxVelocity.set(400, 400);
		_player.drag.x = _player.maxVelocity.x * 8;
		_player.drag.y = _player.maxVelocity.y * 8;
		
		_level = new FlxText(100, 100, 160, "Level 1");
		_level.setFormat(null, 8, FlxColor.WHITE, "left", FlxText.BORDER_NONE, FlxColor.BLUE);
		add(_level);
		
		
		
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		_player.velocity.x = 0;
		_player.velocity.y = 0;

		if (FlxG.keys.pressed.LEFT)
		{
			_player.velocity.x = -_player.maxVelocity.x;
		}

		if (FlxG.keys.pressed.RIGHT)
		{
			_player.velocity.x = _player.maxVelocity.x;
		}

		if (FlxG.keys.pressed.UP)
		{
			_player.velocity.y = -_player.maxVelocity.y;
		}

		if (FlxG.keys.pressed.DOWN)
		{
			_player.velocity.y = _player.maxVelocity.y;
		}

		
		super.update();
	}	
}