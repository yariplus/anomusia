package maps;

/**
 * ...
 * @author ...
 */
class MapNode
{
	var isPathUp:Bool;
	var isPathDown:Bool;
	var isPathLeft:Bool;
	var isPathRight:Bool;

	public function new( ?boolPathUp:Bool = false, ?boolPathDown:Bool = false, ?boolPathLeft:Bool = false, ?boolPathRight:Bool = false )
	{
		this.isPathUp = boolPathUp;
		this.isPathDown = boolPathDown;
		this.isPathLeft = boolPathLeft;
		this.isPathRight = boolPathRight;
	}
	
}