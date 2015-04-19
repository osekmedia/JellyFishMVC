/**
* @author Erin Duvall
* @output false
**/
component {

	public mvcObjectService function init(){
		return this;
	}

	public struct function new( required string name, required string  type ){
		var loc = {};
		
		//Build model object path
		loc.path = APPLICATION.mvc.settings.cfcFolder & "." & Trim( ARGUMENTS.type ) & "." & Trim ( ARGUMENTS.name );

	 	//Create Object
		loc.newObj = createObject( "component",  loc.Path ).init();
		
		return loc.newObj;
	}
}