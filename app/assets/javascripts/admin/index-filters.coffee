# put this in e.g. app/assets/javascripts/admin/index-filters.coffee
# and include this in app/assets/javascripts/active_admin.js
 
$ ->
 
  # Modify the clear-filters button to clear saved filters by adding a parameter
  $('.clear_filters_btn').click ->
      window.location.search = 'clear_filters=true'