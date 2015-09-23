// add string trim function
String.prototype.trim = function() { return this.replace(/^\s+|\s+$/g, ''); }

function isProbablyUrl(string) {
	var substr = string.substring(0,4).toLowerCase();
	if (substr == 'ftp:' || substr == 'www.') return true;

	var substr = string.substring(0,5).toLowerCase();
	if (substr == 'http:') return true;

	var substr = string.substring(0,6).toLowerCase();
	if (substr == 'https:') return true;

	var substr = string.substring(0,7).toLowerCase();
	if (substr == 'chrome:') return true;

	return false;
}

function openList(list) {
	
	var strings = list.split(/\r\n|\r|\n/);
	
	//loop 5 by 5 URLs
	var j=1;
	var T=500
	while (j*3<strings.length) {
		//setTimeout(function () {
			for (var i=0; i<j*3; i++) {
				// check empty
				strings[i] = strings[i].trim();
				if (strings[i] == '') continue;

				var url = strings[i];

				if (!isProbablyUrl(url)) {
					// if it looks like a URL we'll open it, otherwise we will do a Google search on it
					url = 'http://www.google.com/search?q=' + encodeURI(url);
				}

				//open the new tab
				chrome.tabs.create({'url':url,'selected':false}, function(tab){
													setTimeout(function(){chrome.tabs.remove(tab.id);}, T);
										});
			}

		//}, T+5000);
		j++;
	}	
}