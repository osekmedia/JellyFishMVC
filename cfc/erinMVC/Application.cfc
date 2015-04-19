/**
	@author erin duvall
    @description "Application Settings CFC file."
*/

component {

	THIS.name = "erinMVC_v1_017";
	THIS.applicationTimeout = CreateTimeSpan(1, 0, 0, 0);
	THIS.clientManagement = false;
	THIS.loginStorage = "session"; 
	THIS.sessionManagement = true;
	THIS.sessionTimeout = CreateTimeSpan(0, 0, 20, 0);
	THIS.scriptProtect = true;
	THIS.datasource = "newsdb";

	//Request timeout
    THIS.timeout = 60; 

    //Map MVC directory
    THIS.mappings["/mvc"] = ExpandPath( "./cfc/erinMVC" );

    /**
        @hint "Runs when an application times out or the server is shutting down."
    */
	public void function onApplicationEnd(struct ApplicationScope = {}) {
		return;
	}

	/**
    	@hint "Runs when ColdFusion receives the first request for a page in the application."
    	@ApplicationScope "The application scope."
    */
	public boolean function onApplicationStart() {

		//MVC Settings
		APPLICATION.mvc = {};
		APPLICATION.mvc.model = new cfc.models.model();
		APPLICATION.mvc.controller = new cfc.controllers.controller();
		APPLICATION.mvc.settings = { 
			apiFolder = "api",
			apiTemplate = "_request.cfm",
			cfcFolder = "cfc",
			controllerFolder = "controllers",
			modelFolder = "models",
			viewFolder = "views",
			viewTemplate = "_layout.cfm",
			resetParam = "resetApp",
			resetPassword = ""
		};

		//Site settings
		APPLICATION.settings = {
			apiKey = "demo"
		};

		return true;
	}
    	
	public void function onError(required any Exception, required string EventName) {
		//Debug Output for Development Only
		WriteOutput('<p class="oops">Oops, something must have broken. Please try your request again<p>');
		WriteDump( ARGUMENTS );
        return;
	}
    
	public boolean function onMissingTemplate(required string TargetPage) {
		onRequestStart( ARGUMENTS.TargetPage );
		return true;
	}
    
    
    /**
        @hint "Runs at the end of a request, after all other CFML code."
    */	
	public void function onRequestEnd() {
		return;
	}
    
	
    /**
        @output true
    */	
	public boolean function onRequestStart( required string TargetPage ) {

		var loc = {};
		//loc.resetPassRequired = Len( APPLICATION.mvc.settings.resetPassword );
	
		if( StructKeyExists( URL, APPLICATION.mvc.settings.resetParam ) ) {
			onApplicationStart();
			writeDump(var = "Reset: " & Now());
			abort;
		}

		loc.args = {};
		loc.mvc = APPLICATION.mvc.settings;

		//Build Routing Engine
		loc.routing = new mvc.adapters.routing();

		//Build Render Engine
		loc.renderEngine = new mvc.services.render();

		//PRocess Route
		loc.routing.setUrlPattern( ARGUMENTS.TargetPage );
		loc.routing.processRoute( loc.mvc, new mvc.services.routingService(), URL, FORM );

		//Create view/controller data adapter
		loc.dataAdapter = new mvc.adapters.data( APPLICATION.mvc.controller, APPLICATION.mvc.settings, loc.routing );	

		try {
			//Build data
			loc.dataAdapter.buildData();

			//Set viewdata variable
			VARIABLES.viewData = loc.dataAdapter.getData();

			//Load view render data
			loc.view = loc.renderEngine.renderView( loc.routing, VARIABLES.viewData, loc.mvc );

			if( Len( loc.view.mainContent ) ) {
				VARIABLES.mainContent = loc.view.mainContent;
			}

			//Load view/API template
			include loc.view.viewTemplate;
		} 
		catch( any e ) {
			WriteOutput('<p class="oops">Oops, we are unable to find the page you are looking for.<p>');
			WriteDump( e ); 
		}
		
		abort;

		return true;
	}

	public void function onSessionEnd(required struct SessionScope, struct ApplicationScope={}) {
		return;
	}


	public void function onSessionStart() {
		return;
	}

}