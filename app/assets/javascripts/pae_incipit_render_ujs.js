/*
	Attach to the PAE input boxes to create the PAE preview

*/
(function(jQuery) {
	
	var self = null;
	jQuery.fn.paeIncipitRender = function() {
		var handler = function() {
			if (!this.paeIncipitRender) {
				this.paeIncipitRender = new jQuery.paeIncipitRender(this);
			}
		};
		
		if (jQuery.fn.on !== undefined) {
			jQuery(document).on('update', ".pae_input", handler);
			return jQuery(document).on('keydown', ".pae_input", handler);
		} else {
			return this.live('keydown', handler);
		}
	};

	jQuery.paeIncipitRender = function (e) {
		_e = e;
		this.init(_e);
	};

	jQuery.paeIncipitRender.fn = jQuery.paeIncipitRender.prototype = {
		paeIncipitRender: '0.0.1'
	};

	jQuery.paeIncipitRender.fn.extend = jQuery.paeIncipitRender.extend = jQuery.extend;
	jQuery.paeIncipitRender.fn.extend({
		init: function(e) {
			// Atach to the keyup event
			$(e).keyup(function(e) {
				e.preventDefault();
				display_music(this)
			});
			
			// Handle the button
			$('a[data-pae-button]').click(function(e) {
				e.preventDefault();
				display_music(this);
			});
			
			function display_music(obj) {
				grid = $(obj).parents(".tag_grid");
			
				pae_key = $(".subfield_entry[data-subfield='n']", grid).val();
				pae_time = $(".subfield_entry[data-subfield='o']", grid).val();
				pae_clef = $(".subfield_entry[data-subfield='g']", grid).val();
				pae_data = $(".subfield_entry[data-subfield='p']", grid).val(); //$(obj).val();
				width = $(obj).width(); // Get the parent textbox with so the image is the same
			
				target_div = $('.pae_incipit_target', grid);

				marc_editor_incipit(
					pae_clef,
					pae_key,
					pae_time,
					pae_data,
					target_div, width);
    		
					$(target_div).parents('table').show();
					$(target_div).show();
			}
			
			// Update on first load
			display_music(e);
		}
	});
	
	jQuery(document).ready(function() {
		jQuery(".pae_input").paeIncipitRender();
		jQuery(".pae_input").trigger('update');
		
		$()
		
	});
	
})(jQuery);