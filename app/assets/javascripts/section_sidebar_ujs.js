var init_sidebar_actions = function () {
	$('a[data-scroll-target]').click(function(e){
		e.preventDefault();
		
		function show_tab_group(tname) {
			var current_item = null;
			var new_item = null;
		
			// Hide all the other panels
			$( ".tab_panel" ).each(function() {
				if ($(this).attr("name") != tname) {
					$(this).hide();
				} else {
					$(this).show();

				}
			});
			//$.scrollTo($("[name=" + tname + "]"), 100, {offset: -10});
		} // function
		
		function show_all_tab_groups() {
			$( ".tab_panel" ).each(function() {
				$(this).show();
				$(this).removeData("current-item");
			})
		} // function
		
		tname = $(this).data("scroll-target");
		
		if (tname == "show_all_groups") {
			show_all_tab_groups();
		} else {
			show_tab_group(tname);
		}
		
		// If we are in preview switch to edit
		if (!$('#marc_editor_panel').is(':visible')) {
			$('#marc_editor_preview').hide();
		}
		
		window.scrollTo(0, 0);
		
	});
	
	$('a[data-sidebar-preview]').click(function(e) {
		e.preventDefault();
		marc_editor_show_hide_preview() 
	});
};

$(document).ready(init_sidebar_actions);
// Fix for turbolinks: it will not call againg document.ready
$(document).on('page:load', init_sidebar_actions);