//open url in a new tab and close it			

function openUrltest(i, j, strings){
	while (i<j) {
		// check empty
		alert(i);
		strings1[i] = strings[i].trim();
		//alert(string);
		if (strings1[i] == '') continue;

		var url = strings1[i];

		if (!isProbablyUrl(url)) {
			// if it looks like a URL we'll open it, otherwise we will do a Google search on it
			url = 'http://www.google.com/search?q=' + encodeURI(url);
		}

		//open the new tab
		chrome.tabs.create({'url':url,'selected':false}, 
							function(tab){
								setTimeout(function(){chrome.tabs.remove(tab.id);}, T);
							});
		i++;
	}
}