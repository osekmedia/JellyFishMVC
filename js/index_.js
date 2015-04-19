var leadsList = function(){

	var init = function( sort ){
		var currentState = 'active';

		$( 'a.details' ).click(function(){
				var data = _getLeadDetails( 
					$(this).data( 'id' ), 
					function( jhtml ) { 
						$.colorbox( { html : jhtml, width : 430 } );
					}
				);

			return false;
		});

		//Handle div click and effects
		$( '#view div' ).click( function(){
			$( this ).find('a.details').click();
		}).hover( function() {
	        $( this ).addClass('highlight');
	    }, function() {
	        $( this ).removeClass('highlight');
	    });

		//handle acive/inactive links
		$( '#active, #inactive' ).click( function(){
			
			var id = $( this ).prop( 'id' ),
				localState = currentState;

			if( id != localState ){
				$( this ).addClass( 'nolink' );
				$('#' + localState + 'leads' ).fadeOut( 300, function(){

					$( '#' + id + 'leads' ).fadeIn( 500 );
					$( '#' + localState ).removeClass( 'nolink' );

				});

				currentState = id;
			}

			return false
		});
	},
	//Get the details
	_getLeadDetails = function ( id, cb ){
		var leadData = {},
			items = ['<section id="leadDetails">', '<header>Lead Details</header>'];

		$.getJSON( '/api/leads/get.cfm?id=' + id, function( data ) {
			var lead = sortOnKeys( data.leads[ 0 ] );

			if( data.success ){
				for ( var key in lead ) {
					if ( lead.hasOwnProperty( key ) && lead[ key ].length ) {
						var val = key == 'phone' && !isNaN( lead[ key ] ) ? Number( lead[ key ] ) : lead[ key ];
						items.push( '<div><span> ' + key + ':</span> ' + decodeURI( val ) + '</div>' );
					}
				}
			}
			else {
				items.push( '<div><span>Unable to load lead data.</span></div>' );
			}

			items.push( '</section>' );

			cb( items.join( '' ) );
		});

	};

	return { init : init };

}

$(document).ready(function(){
	leadsList().init();
});