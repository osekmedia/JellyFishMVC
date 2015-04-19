/**
* @author  Erin DUvall
* @description HTTP request param
* @output false
**/
component { 
	property string type;
	property string name;
	property string value;
	
	public HttpParamObj function init(required string type, required string name, required string value){
		this.type = ARGUMENTS.type;
		this.name = ARGUMENTS.name;
		this.value = ARGUMENTS.value;
		return this;
	}
}