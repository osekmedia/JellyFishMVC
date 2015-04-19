/**
* @author Erin Duvall
* @description model to get data list from MSPWare
* @accessors true
* @extends model
* @output false
**/

component {

	property string baseUrl;

	public model function init(){
		SUPER.init();
		setBaseUrl( "http://REMOVED_FOR_SECURITY/JSON/v1/" );
		return this;
	}

	//Get a full list of leads from API
	public struct function getLeadsList(){

		var loc = {};
		loc.Url = getBaseUrl() & "leads.json"; 

		loc.params = {
			appkey = APPLICATION.settings.apiKey,
			appId = "demo"
		};

		return {response = {leads = []}};//getData( loc.Url, loc.params );
	}

	//Get a specific lead from API
	public struct function getLead( required numeric id ) {

		var loc = {};
		loc.Url = getBaseUrl() & "leads/" & ARGUMENTS.id & ".json"; 

		loc.params = {
			appkey = APPLICATION.settings.apiKey,
			appId = "demo"
		};

		return getData( loc.Url, loc.params );
	}

	//Get API data
	private struct function getData( required string url, struct params = {} ){

		var loc = {};
		loc.attribs.Method = 'get';
		loc.attribs.Charset = 'utf-8';
		loc.attribs.Url = ARGUMENTS.url & buildParams( ARGUMENTS.params );
		loc.responseError = false;
		loc.response = "";

		//Build request settings object
		loc.httpparamsList = new cfc.lib.HttpRequestSettings( 
			requestMethod = loc.attribs.Method, 
			charset = loc.attribs.Charset, 
			requestUrl = loc.attribs.Url, 
			timeout = 120, 
			throwError = true 
		);

		//Build and send HTTP request  
		loc.HttpRequestObj = new cfc.lib.HttpRequest( loc.httpparamsList );
		loc.HttpResponseObj = loc.HttpRequestObj.SendHttpRequest();

		//Handle response
		if( loc.HttpResponseObj.Success && structKeyExists( loc.HttpResponseObj.response, "fileContent" ) ) {
			loc.response = DeSerializeJSON( loc.HttpResponseObj.response.fileContent );
		} else {
			loc.responseError = true;
		}

		return { isError = loc.responseError, response = loc.response, request = loc.attribs.Url };
	}

	//Convert params to URL params
	private string function buildParams( required struct params ) {
		var loc = {};
		loc.returnObj = '';

		//Create array of params in struct
		loc.paramsArr = ListToArray( StructKeyList( ARGUMENTS.params ), ',', false );
		loc.count = ArrayLen( loc.paramsArr );

		if( loc.count ){
			//Loop over params array and build request string
			for ( loc.i = 1; loc.i <= loc.count; loc.i++ ) {
				loc.prefix = loc.i > 1 ? '&' : '?';
				loc.returnObj &= loc.prefix & lCase( loc.paramsArr[ loc.i ] ) & '=' & UrlEncodedFormat( ARGUMENTS.params[ loc.paramsArr[ loc.i ] ], "utf-8" );	
			}
		}

		return loc.returnObj;
	}

}