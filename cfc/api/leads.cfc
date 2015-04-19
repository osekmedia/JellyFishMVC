/**
* @author  Erin DUvall
* @description API controller for leads service
**/

component {

	//Get lead data from model, package and return
	public struct function get( numeric id = 0 ){
		var loc = {};
		loc.returnObj = { "success" = false, "leads" = [] };

		//Load lead data from model
		loc.leads = new cfc.models.leads();

		if( ARGUMENTS.id ){
			//get lead from model
			loc.leadsData = loc.leads.getLead( ARGUMENTS.id );

			if( StructKeyExists( loc.leadsData, "response" ) && StructKeyExists( loc.leadsData.response, "lead" ) ) {
				loc.returnObj.leads[ 1 ] = loc.leadsData[ "response" ][ "lead" ];
				loc.returnObj.success = true;
			}
		} 
		else {
			//Get list of leads from model
			loc.leadsData = loc.leads.getLeadsList();

			if( StructKeyExists( loc.leadsData, "response" ) && isArray( loc.leadsData[ "response" ][ "leads" ] ) && ArrayLen( loc.leadsData[ "response" ][ "leads" ] ) ){
				loc.returnObj.leads = loc.leadsData[ "response" ][ "leads" ];
				loc.returnObj.success = true;
			}
		}

		return loc.returnObj;
	}

}