/**
* @author Erin Duvall
* @description Send HTTP request
* @output false
**/
component { 
	
	property HttpRequestSettings RequestParams;
	
	public HttpRequest function init(required HttpRequestSettings params) {
		this.HttpRequestSettings = ARGUMENTS.params;
		return this;
	}
	
	/*
		SendHttpRequest()
		Requires HttpRequestSettings - Settings Object
		Sends request using http
	*/
	public struct function SendHttpRequest() {
		var RtnObj = {};
		var httpService = new http();
		RtnObj.Success = true;

		try{
			/* Set Attributes */ 
			httpService.setMethod(this.HttpRequestSettings.settings.Method); 
			httpService.setCharset(this.HttpRequestSettings.settings.Charset); 
			httpService.setUrl(this.HttpRequestSettings.settings.Url);
			httpService.setThrowOnError(this.HttpRequestSettings.settings.throwError);

			if(this.HttpRequestSettings.settings.timeOut){
				httpService.setTimeout(this.HttpRequestSettings.settings.timeOut);	
			} 
			
			/*If Uing HTTP Authentication set Username and Password*/
			if(this.HttpRequestSettings.settings.UseHttpAuth){
				httpService.setUsername(this.HttpRequestSettings.settings.UserName);
				httpService.setPassword(this.HttpRequestSettings.settings.Password);
			}
			
			/* Add Http params */ 
			if(ArrayLen(this.HttpRequestSettings.paramList)){
				for(var i = 1; i < ArrayLen(this.HttpRequestSettings.paramList) + 1; i++) 
				{ 
				   httpService.addParam(type=this.HttpRequestSettings.paramList[i].type, name=this.HttpRequestSettings.paramList[i].name, value=this.HttpRequestSettings.paramList[i].value);
				}
			}
			
			/* Send Request */ 
			RtnObj.Response = httpService.send().getPrefix();
			
		}
		catch(any e){
			RtnObj.Success = false;
			RtnObj.error = e.message;
			RtnObj.errorDetails = e.detail;
		}
		
		return RtnObj;
	}

	/*Parse the cookies if any from the response*/
	public struct function GetResponseCookies(required struct Response){
		var loc = {};
		loc.Cookies = {};
		
		if(!StructKeyExists(ARGUMENTS.Response.ResponseHeader,"Set-Cookie")){
			return loc.Cookies;
		}
		
		loc.ReturnedCookies = ARGUMENTS.Response.ResponseHeader[ "Set-Cookie" ];

		if(!isStruct(loc.ReturnedCookies)){
			return loc.Cookies;
		}
		
		for(loc.CookieIndex in loc.ReturnedCookies){
			loc.CookieString = loc.ReturnedCookies[ loc.CookieIndex ];
			
			for(loc.Index =1; loc.Index != ListLen( loc.CookieString, ';' ); loc.Index++){
				loc.Pair = ListGetAt(loc.CookieString,loc.Index,";");
				loc.Name = ListFirst( loc.Pair, "=" );
				
				if(ListLen( loc.Pair, "=" ) > 1){
					loc.Value = ListRest( loc.Pair, "=" );
				} else {
					loc.Value = "";
				}
				
				if(loc.Index EQ 1){
					loc.Cookies[ loc.Name ] = {};
					loc.Cookie = loc.Cookies[ loc.Name ];
					loc.Cookie.Value = loc.Value;
					loc.Cookie.Attributes = {};
				} else {
					loc.Cookie.Attributes[ loc.Name ] = loc.Value;
				}
			}
		}
		return loc.Cookies;	
    }

}