package maps;

/**
 * ...
 * @author ...
 * 
 * 
 * @usage
 * A SNES Screen size area.
 * It can be attached to AreaGroup to make an area several SNES sizes big.
 * 
 */
class Area
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