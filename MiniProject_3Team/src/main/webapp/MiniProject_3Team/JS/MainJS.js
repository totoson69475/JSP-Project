function loadPage(page, tabName) {
        const existingTab = Array.from(document.querySelectorAll('#tabBarSpace div#tabName'))
        .find(tab => tab.innerText === tabName);

        if (existingTab) {
			loadContent(page);
            return;
        }
		
        const newTab = `
            <td id="tabBar">
                <div id="tabName" onclick="loadPage('${page}', '${tabName}')">${tabName}</div>
                <div id="tabClose" onclick="closeTab(this)">X</div>
            </td>
        `
        
        document.getElementById('tabBarSpace').insertAdjacentHTML('beforeend', newTab);
		loadContent(page);
    }

    function closeTab(object) {
        const tab = object.parentElement;
        tab.remove();
    }
	
	function loadContent(page) {
	    fetch(page)
	        .then(response => response.text())
	        .then(data => {
	            document.getElementById('includeDIV').innerHTML = data;
	        })
	        .catch(error => console.error('에러 발생:', error));
	}
	