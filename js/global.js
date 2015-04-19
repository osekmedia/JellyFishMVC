//Sort key value map
var sortOnKeys = function ( map ) {

    var sorted = [],
    	tempMap = {};

    //Build array from map
    for(var key in map) {
        sorted[ sorted.length ] = key;
    }

    //ort array
    sorted.sort();
    
    //Rebuild map
    for( var i = 0; i < sorted.length; i++ ) {
        tempMap[sorted[i]] = map[sorted[i]];
    }

    return tempMap;
}