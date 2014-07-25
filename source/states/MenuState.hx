package states;

import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUICursor;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.interfaces.IFlxUIWidget;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class MenuState extends FlxUIState
{
	private var _textTitle:FlxText;
	
	private var _btnPrimRandomWall:FlxButton;
	private var _btnPrimRandomFrontier:FlxButton;
	private var _btnPlayArea:FlxButton;
	
	override public function create():Void
	{
		//_xml_id = "menu";
		//_makeCursor = true;
		super.create();
		
		_textTitle = new FlxText( 20, 25, -1, "Project: Anomusia", 18);
		
		_btnPrimRandomWall = new FlxButton(20, 120, "Prim's Random Wall", clickPrimRandomWalls);
		_btnPrimRandomFrontier = new FlxButton(20, 160, "Prim's Random Frontier", clickPrimRandomFrontier);
		_btnPlayArea = new FlxButton(20, 200, "Play Area Experiments", clickPlayArea);
		
		_btnPrimRandomWall.makeGraphic(130, 20, FlxColor.AZURE);
		_btnPrimRandomFrontier.makeGraphic(130, 20, FlxColor.AZURE);
		_btnPlayArea.makeGraphic(130, 20, FlxColor.AZURE);
		
		add(_textTitle);
		add(_btnPrimRandomWall);
		add(_btnPrimRandomFrontier);
		add(_btnPlayArea);
		
		//updateInputMethod();
	}
	
	public override function getEvent(name:String, sender:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Void {

	}
	
	private function clickPrimRandomWalls():Void
	{
		FlxG.switchState(new TestStatePrimRandomWall());
	}
	
	private function clickPrimRandomFrontier():Void
	{
		FlxG.switchState(new states.TestStatePrimRandomFrontier());
	}
	
	private function clickPlayArea():Void
	{
		FlxG.switchState(new states.TestStatePlayArea());
	}
}