/**
*
* @author  Erin Duvall
* @description Renders view and view template for MVC system
* @output false
* @implements IRenderer
*/

component {

	public IRenderer function init() {
		return this;
	}

	public struct function renderView( required mvc.adapters.IRoutingAdapter routing, required struct data,  required struct mvcSettings ) {
		
		var loc = {};
		loc.mvc = ARGUMENTS.mvcSettings;
		loc.mainContent = "";
		loc.viewFile = "";

		//Build layout template path
		loc.viewTemplate = "/" & ( ARGUMENTS.routing.isApiRequest() ? ( loc.mvc.apiFolder & "/" & loc.mvc.apiTemplate ) : ( loc.mvc.cfcFolder & "/" & loc.mvc.viewFolder & "/" & loc.mvc.viewTemplate ) );

		//If this is NOT an API request, load view
		if( !ARGUMENTS.routing.isApiRequest() ) {
			loc.viewFile = "/" & loc.mvc.cfcFolder & "/" & loc.mvc.viewFolder & "/" & ARGUMENTS.routing.getRequestService() & ".cfm";
			VARIABLES.viewData = ARGUMENTS.data;
			
			savecontent variable="loc.mainContent" { 
				include loc.viewFile;
			};
		}
		
		return { viewTemplate = loc.viewTemplate, mainContent = loc.mainContent };

	}
}