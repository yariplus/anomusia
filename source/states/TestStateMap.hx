package states;

import flixel.FlxState;
import flixel.text.FlxText;
import maps.AMap;

/**
 * ...
 * @author ...
 */
class TestStateMap extends FlxState
{
	
	private var _map:AMap;

	public function new() 
	{
		_map = new AMap();
		
		add(new FlxText(50, 50 , 200, "MapTest", 16));
		add(_map);
		
		super();
	}
	
}