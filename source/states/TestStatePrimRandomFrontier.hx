package states ;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import haxe.ds.Vector;
import flixel.util.FlxColor;
import Math;
import Std;

import Reg;

class TestStatePrimRandomFrontier extends FlxState
{
	var isPathUp:Array<Array<Bool>> = new Array<Array<Bool>>();
	var isPathDown:Array<Array<Bool>> = new Array<Array<Bool>>();
	var isPathLeft:Array<Array<Bool>> = new Array<Array<Bool>>();
	var isPathRight:Array<Array<Bool>> = new Array<Array<Bool>>();
	private var _isFrontier:Array<Array<Bool>> = new Array<Array<Bool>>();
	private var _cells:Array<Array<FlxSprite>>;
	
	private var _wallGraphics:Array<String>;
	
	public var walls:FlxGroup;
	
	var sprstart:FlxSprite;
	var stext:FlxText;
	
	var delay:Int;
	
	private var _connectX:Int;
	private var _connectY:Int;
	private var _frontierX:Int;
	private var _frontierY:Int;
	private var _growthConnections:Int;
	private var _connectDirection:Int;
	
	private var _complete:Bool = false;

	override public function create():Void
	{
		
		emptyMap(isPathUp);
		emptyMap(isPathDown);
		emptyMap(isPathLeft);
		emptyMap(isPathRight);
		emptyMap(_isFrontier);
		
		walls = new FlxGroup();
		
		trace("sadasdsad");
		_wallGraphics = new Array<String>();
		for ( i in 0 ... 17 )
		{
			_wallGraphics.push("");
		}
		_wallGraphics[0] = "assets/images/cellOpenNone.png";
		_wallGraphics[1] = "assets/images/cellOpenUp.png";
		_wallGraphics[2] = "assets/images/cellOpenDown.png";
		_wallGraphics[3] = "assets/images/cellOpenUpDown.png";
		_wallGraphics[4] = "assets/images/cellOpenLeft.png";
		_wallGraphics[5] = "assets/images/cellOpenUpLeft.png";
		_wallGraphics[6] = "assets/images/cellOpenDownLeft.png";
		_wallGraphics[7] = "assets/images/cellOpenUpDownLeft.png";
		_wallGraphics[8] = "assets/images/cellOpenRight.png";
		_wallGraphics[9] = "assets/images/cellOpenUpRight.png";
		_wallGraphics[10] = "assets/images/cellOpenDownRight.png";
		_wallGraphics[11] = "assets/images/cellOpenUpDownRight.png";
		_wallGraphics[12] = "assets/images/cellOpenLeftRight.png";
		_wallGraphics[13] = "assets/images/cellOpenUpLeftRight.png";
		_wallGraphics[14] = "assets/images/cellOpenDownLeftRight.png";
		_wallGraphics[15] = "assets/images/cellOpenAll.png";
		_wallGraphics[16] = "assets/images/cellFrontier.png";
		
		// Make blank board
		var cell:FlxSprite = new FlxSprite(0, 0);
		cell.makeGraphic(30*12, 30*12, FlxColor.GRAY);
		cell.immovable = true;
		add(cell);
		
		// Make all empty cells
		_cells = new Array<Array<FlxSprite>>();
		while ( _cells.length < 30 )
		{
			_cells.push(new Array<FlxSprite>());
			while (_cells[_cells.length - 1].length < 30)
			{
				var _newCellSprite:FlxSprite = new FlxSprite( (_cells.length - 1) * 12, (_cells[_cells.length - 1].length) * 12 );
				_newCellSprite.makeGraphic(12,12, FlxColor.GRAY);
				add(_newCellSprite);
				_cells[_cells.length - 1].push(_newCellSprite);
			}
		}
		
		// Add a random starting cell to the frontier.
		var _startx = Reg.getRandomIntZeroToUnder(22) + 5;
		var _starty = Reg.getRandomIntZeroToUnder(22) + 5;
		_isFrontier[_startx][_starty - 1] = true;
		_isFrontier[_startx][_starty + 1] = true;
		_isFrontier[_startx - 1][_starty - 1] = true;
		_isFrontier[_startx - 1][_starty + 1] = true;
		_isFrontier[_startx - 2][_starty] = true;
		_isFrontier[_startx + 1][_starty] = true;
		isPathLeft[_startx][_starty] = true;
		isPathRight[_startx - 1][_starty] = true;
		
		_cells[_startx][_starty].loadGraphic(_wallGraphics[4]);
		_cells[_startx-1][_starty].loadGraphic(_wallGraphics[8]);
		
		stext = new FlxText(12, 12,200,"");
		add(stext);
		
		delay = 0;
		
		super.create();
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	override public function update():Void
	{
		if ( !_complete )
		{
		trace("Finding frontier");
		// Pick a random Frontier cell
		while (true)
		{
			_frontierX = Reg.getRandomIntZeroToUnder(30);
			_frontierY = Reg.getRandomIntZeroToUnder(30);
			if (_isFrontier[_frontierX][_frontierY]) break;
		}
		_isFrontier[_frontierX][_frontierY] = false;
		
		// Pick a maze path
		var _picking = true;
		while (_picking)
		{
			_connectDirection = Reg.getRandomIntZeroToUnder(4) + 1;
			switch (_connectDirection)
			{
				case 1:
					if ( _getConnections(_frontierX, _frontierY - 1) > 0 ) { _picking = false; }
					trace("Connecting Up");
				case 2:
					if ( _getConnections(_frontierX, _frontierY + 1) > 0 ) { _picking = false; }
					trace("Connecting Down");
				case 3:
					if ( _getConnections(_frontierX - 1, _frontierY) > 0 ) { _picking = false; }
					trace("Connecting Left");
				case 4:
					if ( _getConnections(_frontierX + 1, _frontierY) > 0 ) { _picking = false; }
					trace("Connecting Right");
			}
		}
		
		_connectX = _frontierX;
		_connectY = _frontierY;
		
		switch (_connectDirection)
		{
			case 1: // Grow up
				_connectY = _frontierY - 1;
				isPathDown[_connectX][_connectY] = true;
				isPathUp[_frontierX][_frontierY] = true;
				if ( _getConnections(_frontierX, _frontierY - 1) < 1 && _frontierY > 0 ) _isFrontier[_frontierX][_frontierY - 1] = true;
				if ( _getConnections(_frontierX - 1, _frontierY) < 1 && _frontierX > 0 ) _isFrontier[_frontierX - 1][_frontierY] = true;
				if ( _getConnections(_frontierX + 1, _frontierY) < 1 && _frontierX < 29 ) _isFrontier[_frontierX + 1][_frontierY] = true;
			case 2: // Grow down
				_connectY = _frontierY + 1;
				isPathUp[_connectX][_connectY] = true;
				isPathDown[_frontierX][_frontierY] = true;
				if ( _getConnections(_frontierX, _frontierY + 1) < 1 && _frontierY < 29 ) _isFrontier[_frontierX][_frontierY + 1] = true;
				if ( _getConnections(_frontierX - 1, _frontierY) < 1 && _frontierX > 0 ) _isFrontier[_frontierX - 1][_frontierY] = true;
				if ( _getConnections(_frontierX + 1, _frontierY) < 1 && _frontierX < 29 ) _isFrontier[_frontierX + 1][_frontierY] = true;
			case 3: // Grow left
				_connectX = _frontierX - 1;
				isPathRight[_connectX][_connectY] = true;
				isPathLeft[_frontierX][_frontierY] = true;
				if ( _getConnections(_frontierX, _frontierY - 1) < 1 && _frontierY > 0 ) _isFrontier[_frontierX][_frontierY - 1] = true;
				if ( _getConnections(_frontierX, _frontierY + 1) < 1 && _frontierY < 29 ) _isFrontier[_frontierX][_frontierY + 1] = true;
				if ( _getConnections(_frontierX - 1, _frontierY) < 1 && _frontierX > 0 ) _isFrontier[_frontierX - 1][_frontierY] = true;
			case 4: // Grow right
				_connectX = _frontierX + 1;
				isPathLeft[_connectX][_connectY] = true;
				isPathRight[_frontierX][_frontierY] = true;
				if ( _getConnections(_frontierX, _frontierY - 1) < 1 && _frontierY >= 0 ) _isFrontier[_frontierX][_frontierY - 1] = true;
				if ( _getConnections(_frontierX, _frontierY + 1) < 1 && _frontierY <= 29 ) _isFrontier[_frontierX][_frontierY + 1] = true;
				if ( _getConnections(_frontierX + 1, _frontierY) < 1 && _frontierX <= 29 ) _isFrontier[_frontierX + 1][_frontierY] = true;
		}
		
		trace("Setting paths");
		_cells[_frontierX][_frontierY].loadGraphic(_getGraphic(_frontierX, _frontierY));
		if ( _frontierY - 1 > 0 ) _cells[_frontierX][_frontierY - 1].loadGraphic(_getGraphic(_frontierX, _frontierY - 1));
		if ( _frontierY + 1 < 30 ) _cells[_frontierX][_frontierY + 1].loadGraphic(_getGraphic(_frontierX, _frontierY + 1));
		if ( _frontierX - 1 > 0 ) _cells[_frontierX - 1][_frontierY].loadGraphic(_getGraphic(_frontierX - 1, _frontierY));
		if ( _frontierX + 1 < 30 ) _cells[_frontierX + 1][_frontierY].loadGraphic(_getGraphic(_frontierX + 1, _frontierY));
		
		var frontiers:Int = 0;
		for ( x in 0 ... 30 )
		{
			for ( y in 0 ... 30 )
			{
				if(_isFrontier[x][y]) frontiers++;
			}
		}
		trace("Frontiers");
		trace(frontiers);
		if ( frontiers == 0 )
		{
			_complete = true;
			for ( x in 0 ... 30 )
			{
				for ( y in 0 ... 30 )
				{
					_cells[x][y].loadGraphic(_getGraphic(x, y));
				}
			}
		}
		}
		
		super.update();
	}
	
	private function emptyMap(a:Array<Array<Bool>>, ?size:Int = 30 ):Void
	{
		while ( a.length < size )
		{
			a.push(new Array<Bool>());
			while (a[a.length - 1].length < size)
			{
				a[a.length - 1].push(false);
			}
		}
	}
	
	private function _getConnections(x:Int, y:Int):Int
	{
		if ( x < 0 || y < 0 ) return 0;
		if ( x > 29 || y > 29 ) return 0;
		_growthConnections = 0;
		if ( isPathUp[x][y]) _growthConnections++;
		if ( isPathDown[x][y]) _growthConnections++;
		if ( isPathLeft[x][y]) _growthConnections++;
		if ( isPathRight[x][y]) _growthConnections++;
		return _growthConnections;
	}
	
	private function _getGraphic(x:Int, y:Int):String
	{
		var g:Int = 0;
		if ( isPathUp[x][y] ) g++;
		if ( isPathDown[x][y] ) g+=2;
		if ( isPathLeft[x][y] ) g+=4;
		if ( isPathRight[x][y] ) g += 8;
		if ( _isFrontier[x][y] ) g = 16;
		return _wallGraphics[g];
	}
}