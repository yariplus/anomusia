package generation;

/**
 * ...
 * @author 
 * yariplus
 * 
 * @usage
 * Respresents a wall in a 2d tile grid, can have a passage between the two tiles.
 * Used for generating a maze-like area.
 * 
 */
class GridWall
{
	public var _x1(default,null):Int = 0;
	public var _x2(default,null):Int = 0;
	public var _y1(default,null):Int = 0;
	public var _y2(default,null):Int = 0;
	public var passage(default,null):Bool = false;
	
	public function new(x1, y1, x2, y2) 
	{
		_x1 = x1;
		_x2 = x2;
		_y1 = y1;
		_y2 = y2;
	}
}