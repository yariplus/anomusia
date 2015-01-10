package states;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

import flixel.addons.ui.FlxUIState;

class MenuState extends FlxUIState
{
	private var _textTitle:FlxText;
	
	private var _btn11:FlxButton;
	private var _btn12:FlxButton;
	private var _btn13:FlxButton;
	private var _btn14:FlxButton;
	private var _btn21:FlxButton;
	private var _btn22:FlxButton;
	private var _btn23:FlxButton;
	private var _btn24:FlxButton;
	private var _btn31:FlxButton;
	private var _btn32:FlxButton;
	private var _btn33:FlxButton;
	private var _btn34:FlxButton;
	
	override public function create():Void
	{
		//_xml_id = "menu";
		//_makeCursor = true;
		super.create();
		
		_textTitle = new FlxText( 20, 25, -1, "Project: Anomusia", 18);
		
		_btn11 = new FlxButton(20, 100, "Prim's Random Wall", click11);
		_btn12 = new FlxButton(20, 125, "Prim's Random Frontier", click12);
		_btn13 = new FlxButton(20, 150, "Play Area", click13);
		_btn14 = new FlxButton(20, 175, "Node Movement", click14);
		
		_btn21 = new FlxButton(155, 100, "Intro", click21);
		_btn22 = new FlxButton(155, 125, "Credits", click22);
		_btn23 = new FlxButton(155, 150, "Settings", click23);
		_btn24 = new FlxButton(155, 175, "Menu", click24);
		
		_btn31 = new FlxButton(290, 100, "HUD", click31);
		_btn32 = new FlxButton(290, 125, "Loading Screen", click32);
		_btn33 = new FlxButton(290, 150, "Pedia", click33);
		_btn34 = new FlxButton(290, 175, "Quit", click34);
		
		_btn11.makeGraphic(130, 20, FlxColor.AZURE);
		_btn12.makeGraphic(130, 20, FlxColor.AZURE);
		_btn13.makeGraphic(130, 20, FlxColor.AZURE);
		_btn14.makeGraphic(130, 20, FlxColor.AZURE);
		
		_btn21.makeGraphic(130, 20, FlxColor.AZURE);
		_btn22.makeGraphic(130, 20, FlxColor.AZURE);
		_btn23.makeGraphic(130, 20, FlxColor.AZURE);
		_btn24.makeGraphic(130, 20, FlxColor.AZURE);
		
		_btn31.makeGraphic(130, 20, FlxColor.AZURE);
		_btn32.makeGraphic(130, 20, FlxColor.AZURE);
		_btn33.makeGraphic(130, 20, FlxColor.AZURE);
		_btn34.makeGraphic(130, 20, FlxColor.AZURE);
		
		add(_textTitle);
		
		add(_btn11);
		add(_btn12);
		add(_btn13);
		add(_btn14);
		
		add(_btn21);
		add(_btn22);
		add(_btn23);
		add(_btn24);
		
		add(_btn31);
		add(_btn32);
		add(_btn33);
		add(_btn34);
		
		//FlxG.sound.playMusic(AssetPaths.avelinoherreraspringsun__ogg, 1, true);
	}
	
	private function click11():Void { FlxG.switchState(new TestStatePrimRandomWall()); }
	private function click12():Void { FlxG.switchState(new TestStatePrimRandomFrontier()); }
	private function click13():Void { FlxG.switchState(new TestStatePlayArea()); }
	private function click14():Void { FlxG.switchState(new TestStateMap()); }
	
	private function click21():Void { FlxG.switchState(new MenuState()); }
	private function click22():Void { FlxG.switchState(new MenuState()); }
	private function click23():Void { FlxG.switchState(new MenuState()); }
	private function click24():Void { FlxG.switchState(new MenuState()); }
	
	private function click31():Void { FlxG.switchState(new MenuState()); }
	private function click32():Void { FlxG.switchState(new MenuState()); }
	private function click33():Void { FlxG.switchState(new MenuState()); }
	private function click34():Void { FlxG.switchState(new MenuState()); }
	
}