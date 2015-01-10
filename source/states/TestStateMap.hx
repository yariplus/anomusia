package states;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import haxe.ds.Vector;
import maps.ATilemap;

import flixel.tile.FlxTilemap;


/**
 * ...
 * @author ...
 */
class TestStateMap extends FlxState
{
	
	private var _map:FlxTilemap;
	
	private var _mapcsv:Array<Int> =
	[90,90,90];

	override public function create():Void
	{
		super.create();
		
		_mapcsv.insert(12, 89);
		_mapcsv.insert(2, 89);
		_map = new FlxTilemap();
		_map.widthInTiles = 3;
		_map.heightInTiles = 3;
		
		_map.loadMap( _mapcsv, "assets/images/tilesets/dcss.png", 32, 32, 0, 0, 1, 1);
		add(_map);
		
		var _spr:FlxSprite = new FlxSprite(20, 20, "assets/images/cellFrontier.png");
		add(_spr);
		
		
	}
	
}