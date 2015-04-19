/**
* @author Erin Duvall
* @description Data adapter for mvc system. Builds controllers to build view data struct.
* @displayname data
* @implements IDataAdapter
* @output false
* @accessors true
**/

component {

	property struct viewData;
	property struct params;
	property struct mvc;
	property string service;
	property string type;
	property boolean isApiRequest;

	VARIABLES.controller = {
		master = {},
		request = { 
			type = "",
			obj = {}
		}
	};

	//Builds and inits controller and view data
	public IDataAdapter function init(
		required mvc.controller controller,  
		required struct mvcSettings,
		required IRoutingAdapter route 
	){

		var loc = {
			params = ARGUMENTS.route.getArguments(),
			key = ARGUMENTS.route.getRequestKey()
		};

		//Store master controller and request type to variable
		VARIABLES.controller.master = ARGUMENTS.controller;
		VARIABLES.controller.request.type = ARGUMENTS.route.getControllerName();
		
		//Add request data to params
		loc.params[ "controller" ] = VARIABLES.controller.request.type;
		loc.params[ "action" ] = ARGUMENTS.route.getRequestService();

		//Add request key to params
		if( Len( loc.key ) ) {
			loc.params[ "key" ] = loc.key;
		}

		//Populate properties
		setMvc( ARGUMENTS.mvcSettings );
		setParams( loc.params );
		setService( ARGUMENTS.route.getRequestService() );
		setIsApiRequest( ARGUMENTS.route.isApiRequest() );

		return this;
	}

	//Processes controller and builds viewData struct
	public void function buildData() {
		var loc = {};
		loc.mvc = getMvc();
		loc.service = getService();

		if( getIsApiRequest() ) {
			//Create API controller object
			VARIABLES.controller.request.obj = CreateObject( "component", loc.mvc.cfcFolder & "." & loc.mvc.apiFolder & "." & VARIABLES.controller.request.type );
		} else {
			//Create new controller instance
			VARIABLES.controller.request.obj = VARIABLES.controller.master.new( VARIABLES.controller.request.type );
		}

		//Set controller service
		loc.getData = VARIABLES.controller.request.obj[ loc.service != "init" ? loc.service : "index" ];

		//Get view data from controller service
		if( !StructIsEmpty( getParams() ) ){
			loc.tmpData = loc.getData( argumentCollection = getParams() );	
		} else {
			loc.tmpData = loc.getData();
		}
		
		//If this is not an api request, pass params to the view
		if( !getIsApiRequest() ){
			StructAppend( loc.tmpData, getParams() );
		}
		
		setViewData( loc.tmpData  );
	}

	//Get data and return to view
	public struct function getData() {
		return getViewData();
	}
	
}