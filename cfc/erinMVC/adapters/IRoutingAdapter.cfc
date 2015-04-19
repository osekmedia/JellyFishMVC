
interface {
	this.args;
	this.controller;
	this.service;
	this.key;
	
	public struct function getArguments();
	public string function getControllerName();
	public string function getRequestKey();
	public string function getRequestService();
	public void function processRoute( required struct mvcSettings, required mvc.services.IPatternParser routeService, struct urlQuery = {}, struct formParams = {} );
}