/**
* @author Erin Duvall
* @description parses route information from get/post style requests
* @implements IUrlPatternService
* @output false
**/

component {

	public struct function parseUrlPattern( required string pattern, struct queryParams = {}, struct formParams = {}, required string apiFolder ) {
		var loc = {
			isApiRequest = _getIsApiRequest( ARGUMENTS.pattern, ARGUMENTS.apiFolder ),
			service = _getService( ARGUMENTS.pattern )
		};

		return {
			args = _getArgumentsFromQueryPattern( [ ARGUMENTS.queryParams, ARGUMENTS.formParams ], [ true, false ] ),
			base = ListFirst( ARGUMENTS.pattern, "/" ),
			controller = _getController( ARGUMENTS.pattern, loc.service, loc.isApiRequest ),
			key = _getKey( ARGUMENTS.pattern, loc.isApiRequest ),
			isApiRequest = loc.isApiRequest,
			service = loc.service 
		};
	}

	private string function _getIsApiRequest( required string pattern, required string apiFolder ) {
		return ( ListFirst( ARGUMENTS.pattern, "/" ) == ARGUMENTS.apiFolder );
	}

	private struct function _getArgumentsFromQueryPattern( required array params, required array isUrl ) {
		var loc = {};
		loc.args = {};

		for( loc.i = 1; loc.i < ArrayLen( ARGUMENTS.params ) + 1; loc.i++ ) {
			loc.params = [];
			if( !StructIsEmpty( ARGUMENTS.params[ loc.i ] ) ) {

				loc.params = ListToArray( StructKeyList( ARGUMENTS.params[ loc.i ] ),',' , false );

				for( loc.j = 1; loc.j < ArrayLen( loc.params ) + 1; loc.j++ ) {
					if( IsValid( "variableName" , loc.params[ loc.j ] ) ) {
						loc.args[ loc.params[ loc.j ] ] = ARGUMENTS.isUrl[ loc.i ] ? URLDecode( ARGUMENTS.params[ loc.i ][ loc.params[ loc.j ] ] ) : ARGUMENTS.params[ loc.i ][ loc.params[ loc.j ] ];
					}
				}
			}
		}

		return loc.args;
	}

	private string function _getController( required string pattern, required string service, required boolean isApiRequest ) {
		var controller = {};

		if( ListLen( ARGUMENTS.pattern, "/" ) > 1 ) {
			controller = ListGetAt( ARGUMENTS.pattern, ARGUMENTS.isApiRequest ? 2 : 1, "/" ); //Set controller to base folder from URL pattern
		} else {
			controller = ARGUMENTS.service; //No controller, set controller to service
		}

		return controller;
	}

	private string function _getService( required string pattern ) {
		return ListFirst( ListLast( ARGUMENTS.pattern, "/" ), "." );
	}

	private string function _getKey( required string pattern, required boolean isApiRequest ) {
		var loc = {
			key = "",
			urlLen = ListLen( ARGUMENTS.pattern, "/" )
		};

		if( ( ( !ARGUMENTS.isApiRequest && loc.urlLen > 2 ) || ( loc.urlLen > 3 ) ) && IsNumeric( ListGetAt( ARGUMENTS.pattern, loc.urlLen - 1, "/" ) ) ) {
			loc.key = ListGetAt( ARGUMENTS.pattern, loc.urlLen - 1, "/" );
		}

		return loc.key;
	}

}