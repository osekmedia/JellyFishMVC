/**
* @author Erin Duvall
* @description Parent controller object
* @displayname Controller
* @output false
**/

component {
	property model models;
	VARIABLES.objService = {};
	

	public controller function init(){
		VARIABLES.objService = new mvc.services.mvcObjectService();
		THIS.models = APPLICATION.mvc.model;
		return this;
	}

	public controller function new( required string name ){
		return VARIABLES.objService.new( type = APPLICATION.mvc.settings.controllerFolder, name = ARGUMENTS.name );
	}
}