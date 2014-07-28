package maps;

/**
 * ...
 * @author ...
 * 
 * 
 * @usage
 * The MapNode is a SNES Screen size area.
 * It can be attached to MapSection to make an area several SNES sizes big.
 * 
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