package maps;

/**
 * ...
 * @author ...
 */
class PrimMazeWall
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