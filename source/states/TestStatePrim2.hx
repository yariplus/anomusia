package unusedstates ;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
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
class TestStatePrim2 extends FlxState
{
	private var _walls:Array<PrimMazeWall> = new Array<PrimMazeWall>();
	var isMaze:Array<Array<Bool>> = new Array<Array<Bool>>();
	var gridGraphics:Array<Array<Int>> = new Array<Array<Int>>();
	var gridSprites:Array<Array<FlxSprite>> = new Array<Array<FlxSprite>>();
	
	private var _wallGraphics:Array<String>;

	var stext:FlxText;
	
	var delay:Int;
	
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
		_wallGraphics[16] = "assets/images/cellFrontier.png";
		
		// Add a random starting cell and add walls.
		var _startx = Reg.getRandomIntZeroToUnder(22) + 5;
		var _starty = Reg.getRandomIntZeroToUnder(22) + 5;
		_startx = 15;
		_starty = 28;
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
			var isFirstCellMaze = isMaze[x1][y1];
			var isSecondCellMaze = isMaze[x2][y2];
			
			if ( !(isFirstCellMaze && isSecondCellMaze) )
			{
				var iFirstPath = 0;
				var iSecondPath = 0;
				switch (x2-x1)
				{
					case -1: // Left
						iFirstPath += 4;
						iSecondPath += 8;
					case 1: // Right
						iFirstPath += 8;
						iSecondPath += 4;
				}
				switch (y2-y1)
				{
					case -1: // Up
						iFirstPath += 1;
						iSecondPath += 2;
					case 1: // Down
						iFirstPath += 2;
						iSecondPath += 1;
				}
				
				updateGridCell(x1, y1, iFirstPath);
				updateGridCell(x2, y2, iSecondPath);
				
				if (!isFirstCellMaze)
				{
					isMaze[x1][y1] = true;
					if ( x1 > 0 ) _walls.push(new PrimMazeWall(x1, y1, x1 - 1, y1));
					if ( y1 > 0 ) _walls.push(new PrimMazeWall(x1, y1, x1, y1 - 1));
					if ( x1 < 29 ) _walls.push(new PrimMazeWall(x1, y1, x1 + 1, y1));
					if ( y1 < 29 ) _walls.push(new PrimMazeWall(x1, y1, x1, y1 + 1));
				} else {
					isMaze[x2][y2] = true;
					if ( x2 > 0 ) _walls.push(new PrimMazeWall(x2, y2, x2 - 1, y2));
					if ( y2 > 0 ) _walls.push(new PrimMazeWall(x2, y2, x2, y2 - 1));
					if ( x2 < 29 ) _walls.push(new PrimMazeWall(x2, y2, x2 + 1, y2));
					if ( y2 < 29 ) _walls.push(new PrimMazeWall(x2, y2, x2, y2 + 1));
				}
			}
			
			// Remove wall
			_walls.splice(iwall, 1);
		}
		
		super.update();
	}
	
	private function getRandomWall()
	{
	}
	
	private function updateGridCell(x, y, change)
	{
		gridGraphics[x][y] += change;
		gridSprites[x][y].loadGraphic(_wallGraphics[gridGraphics[x][y]]);
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