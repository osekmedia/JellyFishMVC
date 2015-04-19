/**
* @author Erin Duvall
* @description Parent model object
* @displayname Model
* @output false
**/

component {
	VARIABLES.objService = {};

	public model function init(){
		VARIABLES.objService = new services.mvcObjectService();
		return this;
	}

	public model function new( required string name ){
		return VARIABLES.objService.new( type = APPLICATION.mvc.settings.modelFolder, name = ARGUMENTS.name );
	}
}