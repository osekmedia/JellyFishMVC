/**
* @author  Erin DUvall
* @description Populate this object with request info that will be used by the http request object
* @output false
**/

component { 
	property array paramList;
	property struct settings;
	
		
	
	public HttpRequestSettings function init(string requestMethod = 'post', string charset = 'utf-8', required string requestUrl, string httpUserName = '', string httpPassword = '', boolean useHttpAuth = false, numeric timeout = 120, boolean throwError = false){
		this.paramList = [];
		this.settings = {};
		this.settings.Method = ARGUMENTS.requestMethod;
		this.settings.Charset = ARGUMENTS.charset;
		this.settings.Url = ARGUMENTS.requestUrl;
		this.settings.UserName = ARGUMENTS.httpUserName;
		this.settings.Password = ARGUMENTS.httpPassword;
		this.settings.UseHttpAuth = ARGUMENTS.useHttpAuth;
		this.settings.timeOut = ARGUMENTS.timeout;
		this.settings.throwError = ARGUMENTS.throwError;
		
		return this;
	}
	
	public void function pushHttpParam(required HttpParamObj param){
		ArrayAppend(this.paramList,ARGUMENTS.param);
	}
}