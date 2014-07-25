package states ;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import haxe.Timer;
import maps.MapNode;
import haxe.ds.Vector;
import flixel.util.FlxColor;
import Math;
import Std;
import maps.PrimMazeWall;

import Reg;

/**
 * ...
 * @author ...
 */
class TestStatePrimRandomWall extends FlxState
{
	private var _walls:Array<PrimMazeWall> = new Array<PrimMazeWall>();
	var isMaze:Array<Array<Bool>> = new Array<Array<Bool>>();
	var gridGraphics:Array<Array<Int>> = new Array<Array<Int>>();
	var gridSprites:Array<Array<FlxSprite>> = new Array<Array<FlxSprite>>();
	
	private var UP:Int = 1;
	private var DOWN:Int = 2;
	private var LEFT:Int = 4;
	private var RIGHT:Int = 8;
	private var LANDMARK:Int = 16;
	
	private var _wallGraphics:Array<String>;
	private var _cellSprites:Array<FlxSprite>;

	var stext:FlxText;
	
	var delay:Int;
	var s1:Float = 0;
	var s2:Float = 0;
	
	
	private var _complete:Bool = false;

	override public function create():Void
	{	
		emptyBoolGrid(isMaze);
		emptyIntGrid(gridGraphics);
		emptySpriteGrid(gridSprites);

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
		
		_wallGraphics[16] = "assets/images/cellLandmarkOpenNone.png";
		_wallGraphics[17] = "assets/images/cellLandmarkOpenUp.png";
		_wallGraphics[18] = "assets/images/cellLandmarkOpenDown.png";
		_wallGraphics[19] = "assets/images/cellLandmarkOpenUpDown.png";
		_wallGraphics[20] = "assets/images/cellLandmarkOpenLeft.png";
		_wallGraphics[21] = "assets/images/cellLandmarkOpenUpLeft.png";
		_wallGraphics[22] = "assets/images/cellLandmarkOpenDownLeft.png";
		_wallGraphics[23] = "assets/images/cellLandmarkOpenUpDownLeft.png";
		_wallGraphics[24] = "assets/images/cellLandmarkOpenRight.png";
		_wallGraphics[25] = "assets/images/cellLandmarkOpenUpRight.png";
		_wallGraphics[26] = "assets/images/cellLandmarkOpenDownRight.png";
		_wallGraphics[27] = "assets/images/cellLandmarkOpenUpDownRight.png";
		_wallGraphics[28] = "assets/images/cellLandmarkOpenLeftRight.png";
		_wallGraphics[29] = "assets/images/cellLandmarkOpenUpLeftRight.png";
		_wallGraphics[30] = "assets/images/cellLandmarkOpenDownLeftRight.png";
		_wallGraphics[31] = "assets/images/cellLandmarkOpenAll.png";
		
		_cellSprites = new Array<FlxSprite>();
		_cellSprites.push( new FlxSprite("assets/images/cellOpenNone.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenUp.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenDown.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenUpDown.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenLeft.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenUpLeft.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenDownLeft.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenUpDownLeft.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenUpRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenDownRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenUpDownRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenLeftRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenUpLeftRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenDownLeftRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellOpenAll.png") );
		
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenNone.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenUp.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenDown.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenUpDown.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenLeft.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenUpLeft.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenDownLeft.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenUpDownLeft.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenUpRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenDownRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenUpDownRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenLeftRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenUpLeftRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenDownLeftRight.png") );
		_cellSprites.push( new FlxSprite("assets/images/cellLandmarkOpenAll.png") );
		
		// Add landmarks
		for (i in 1...12)
		{
			var x = Reg.getRandomIntZeroToUnder(28);
			var y = Reg.getRandomIntZeroToUnder(28);
			if (gridGraphics[x][y] & 16 == 16 ) continue;
			if (gridGraphics[x+1][y] & 16 == 16 ) continue;
			if (gridGraphics[x][y+1] & 16 == 16 ) continue;
			if (gridGraphics[x + 1][y + 1] & 16 == 16 ) continue;
			isMaze[x+1][y] = true;
			isMaze[x+1][y+1] = true;
			isMaze[x][y] = true;
			isMaze[x][y+1] = true;
			setGridCell(x, y, LANDMARK+DOWN+RIGHT);
			setGridCell(x+1, y, LANDMARK+DOWN+LEFT);
			setGridCell(x, y+1, LANDMARK+UP+RIGHT);
			setGridCell(x+1, y+1, LANDMARK+UP+LEFT+RIGHT);
		}
		
		
		// Add a random starting cell and add walls.
		var _startx = Reg.getRandomIntZeroToUnder(22) + 5;
		var _starty = Reg.getRandomIntZeroToUnder(22) + 5;
		_startx = 15;
		_starty = 15;
		isMaze[_startx][_starty] = true;
		updateGridCell(_startx, _starty, 0);
		_walls.push(new PrimMazeWall(_startx, _starty, _startx - 1, _starty));
		_walls.push(new PrimMazeWall(_startx, _starty, _startx, _starty - 1));
		_walls.push(new PrimMazeWall(_startx, _starty, _startx + 1, _starty));
		_walls.push(new PrimMazeWall(_startx, _starty, _startx, _starty + 1));
		
		super.create();
	}
	
	override public function update():Void
	{
		
		
		
		if (_walls.length > 0)
		{
			//Pick a random wall
			var iwall:Int = Reg.getRandomIntZeroToUnder(_walls.length);
			
			
			
			var x1 = _walls[iwall]._x1;
			var y1 = _walls[iwall]._y1;
			var x2 = _walls[iwall]._x2;
			var y2 = _walls[iwall]._y2;
			var isDestCellMaze = isMaze[x2][y2];
			var iFirstPath = 0;
			var iSecondPath = 0;
			
			switch (x2-x1)
			{
				case -1: // Left
					iFirstPath += LEFT;
					iSecondPath += RIGHT;
				case 1: // Right
					iFirstPath += RIGHT;
					iSecondPath += LEFT;
			}
			switch (y2-y1)
			{
				case -1: // Up
					iFirstPath += UP;
					iSecondPath += DOWN;
				case 1: // Down
					iFirstPath += DOWN;
					iSecondPath += UP;
			}
			
			
			if ( !isDestCellMaze || ( gridGraphics[x2][y2] & iSecondPath == iSecondPath ) )
			{
				isMaze[x2][y2] = true;
				if ( x2 > 0 ) _walls.push(new PrimMazeWall(x2, y2, x2 - 1, y2));
				if ( y2 > 0 ) _walls.push(new PrimMazeWall(x2, y2, x2, y2 - 1));
				if ( x2 < 29 ) _walls.push(new PrimMazeWall(x2, y2, x2 + 1, y2));
				if ( y2 < 29 ) _walls.push(new PrimMazeWall(x2, y2, x2, y2 + 1));
				updateGridCell(x1, y1, iFirstPath);
				updateGridCell(x2, y2, iSecondPath);
			}
			
			
			// Remove wall
			_walls.splice(iwall, 1);
			
			
		}
		
		super.update();
		
		s2 = Timer.stamp();
		trace(s2 - s1);
		s1 = Timer.stamp();
	}
	
	private function getRandomWall()
	{
	}
	
	private function setGridCell(x, y, set)
	{
		gridGraphics[x][y] = set;
		gridSprites[x][y].loadGraphicFromSprite(_cellSprites[gridGraphics[x][y]]);
	}
	
	private function updateGridCell(x, y, change)
	{
		if ( gridGraphics[x][y] & change == 0 ) setGridCell(x, y, gridGraphics[x][y] + change);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	private function emptyBoolGrid(bg:Array<Array<Bool>>, ?size:Int = 30 ):Void
	{
		while ( bg.length < size )
		{
			bg.push(new Array<Bool>());
			while (bg[bg.length - 1].length < size)
			{
				bg[bg.length - 1].push(false);
			}
		}
	}
	
	private function emptyIntGrid(ig:Array<Array<Int>>, ?size:Int = 30 ):Void
	{
		while ( ig.length < size )
		{
			ig.push(new Array<Int>());
			while (ig[ig.length - 1].length < size)
			{
				ig[ig.length - 1].push(0);
			}
		}
	}
	
	private function emptySpriteGrid(sg:Array<Array<FlxSprite>>, ?size:Int = 30 ):Void
	{
		while ( sg.length < size )
		{
			sg.push(new Array<FlxSprite>());
			while (sg[sg.length - 1].length < size)
			{
				sg[sg.length - 1].push(new FlxSprite((sg.length - 1) * 12, (sg[sg.length - 1].length) * 12).makeGraphic(12, 12, FlxColor.AZURE));
				add(sg[sg.length - 1][sg[sg.length - 1].length -1]);
			}
		}
	}
}