/**
* @author Erin Duvall
* @displayname HttpRequestSettings
* @description Send HTTP request
* @output false
**/
component { 

	property array paramList;
	property struct settings;
	
	public HttpRequestSettings function init( string requestMethod = 'post', string charset = 'utf-8', required string requestUrl ){
		
		this.paramList = [];

		this.settings = {
			Method = ARGUMENTS.requestMethod,
			Charset = ARGUMENTS.charset,
			Url = ARGUMENTS.requestUrl
		};
		
		return this;
	}
	
	public void function pushHttpParam( required HttpParamObj param ){
		ArrayAppend( this.paramList, ARGUMENTS.param );
	}
}