// Put your application scripts here
$(document).ready(function(){
	$('#tiles').imagesLoaded(function() {
		var handler = null;

		// Prepare layout options.
		var options = {
			autoResize: true, // This will auto-update the layout when the browser window is resized.
			container: $('#main'), // Optional, used for some extra CSS styling
			//offset: 20, // Optional, the distance between grid items
			itemWidth: 200 // Optional, the width of a grid item
		};

		/**
		* When scrolled all the way to the bottom, add more tiles.
		*/
		
		function onScroll(event) {
			// Check if we're within 100 pixels of the bottom edge of the broser window.
			var winHeight = window.innerHeight ? window.innerHeight : $(window).height(); // iphone fix
			var closeToBottom = ($(window).scrollTop() + winHeight > $(document).height() - 100);

			if (closeToBottom) {
				// Get the first then items from the grid, clone them, and add them to the bottom of the grid.
				var items = $('#tiles li'),
				firstTen = items.slice(0, 10);
				$('#tiles').append(firstTen.clone());

				// Destroy the old handler
				if (handler.wookmarkInstance) {
					handler.wookmarkInstance.clear();
				}

				// Create a new layout handler.
				handler = $('#tiles li');
				handler.wookmark(options);
			}
		};
		

		// Capture scroll event.
		$(window).bind('scroll', onScroll);

		// Call the layout function.
		handler = $('#tiles li');
		handler.wookmark(options);
	});

	var $container = $('#container');
	$container.imagesLoaded( function(){
			$container.masonry({
				itemSelector : '.item'
		});
	});
});
