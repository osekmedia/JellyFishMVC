/**
* @author Erin Duvall
* @accessors true
* @implements IUrlRouting, IApiRouting
* @output false
**/

component {

	property struct args;
	property string controller;
	property string service;
	property boolean isApiRequest;
	property string pattern;
	property string key;
	
	public IRoutingAdapter function init() {
		return this;
	}

	//Public Accessors
	public struct function getArguments() {
		return getArgs();
	}

	public string function getControllerName() {
		return getController();
	}

	public boolean function isApiRequest() {
		return getIsApiRequest();
	}

	public string function getRequestKey() {
		return getKey();
	}

	public string function getRequestService() {
		return getService();
	}

	//Public set url pattern
	public void function setUrlPattern( required string urlPattern ) {
		setPattern( ARGUMENTS.urlPattern );
	}
	
	//URL routing routine
	public void function processRoute( required struct mvcSettings, required mvc.services.IPatternParser routeService, struct urlQuery = {}, struct formParams = {} ) {
		
		var route = ARGUMENTS.routeService.parseUrlPattern( getPattern(), ARGUMENTS.urlQuery, ARGUMENTS.formParams, ARGUMENTS.mvcSettings.apiFolder );
		
		setArgs( route.args );
		setController( route.controller );
		setIsApiRequest( route.isApiRequest );
		setService( route.service );
		setKey( route.key );
	}
}