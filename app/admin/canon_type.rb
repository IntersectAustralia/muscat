ActiveAdmin.register CanonType do

  menu :parent => "indexes_menu", :label => proc {I18n.t(:menu_canon_types)}

  # Remove mass-delete action
  batch_action :destroy, false

  # Remove all action items
  config.clear_action_items!

  collection_action :autocomplete_canon_type_name, :method => :get

  breadcrumb do
    active_admin_muscat_breadcrumb
  end

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # temporarily allow all parameters
  controller do

    autocomplete :canon_type, :name

    after_destroy :check_model_errors
    before_create do |item|
      item.user = current_user
    end

    def action_methods
      return super - ['new', 'edit', 'destroy'] if is_selection_mode?
      super
    end

    def check_model_errors(object)
      return unless object.errors.any?
      flash[:error] ||= []
      flash[:error].concat(object.errors.full_messages)
    end

    def permitted_params
      params.permit!
    end

    def index
      @results, @hits = CanonType.search_as_ransack(params)

      index! do |format|
        @canon_types = @results
        format.html
      end
    end

    def show
      begin
        @canon_type = CanonType.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to admin_root_path, :flash => { :error => "#{I18n.t(:error_not_found)} (Canon Type #{params[:id]})" }
        return
      end
      @prev_item, @next_item, @prev_page, @next_page = CanonType.near_items_as_ransack(params, @canon_type)

      @jobs = @canon_type.delayed_jobs
    end

    # redirect update failure for preserving sidebars
    def update
      update! do |success,failure|
        success.html { redirect_to collection_path }
        failure.html { redirect_to :back, flash: { :error => "#{I18n.t(:error_saving)}" } }
      end
    end

    # redirect create failure for preserving sidebars
    def create
      create! do |success,failure|
        failure.html { redirect_to :back, flash: { :error => "#{I18n.t(:error_saving)}" } }
      end
    end
  end

  ###########
  ## Index ##
  ###########

  # Solr search all fields: "_equal"
  filter :name_equals, :label => proc {I18n.t(:any_field_contains)}, :as => :string

  index :download_links => false do
    selectable_column if !is_selection_mode?
    column (I18n.t :filter_id), :id
    column (I18n.t :filter_name), :name
    column (I18n.t :filter_relationship_operator), :relationship_operator
    active_admin_muscat_actions( self )
  end

  sidebar :actions, :only => :index do
    render :partial => "activeadmin/filter_workaround"
    render :partial => "activeadmin/section_sidebar_index"
  end

  ##########
  ## Show ##
  ##########

  show do
    active_admin_navigation_bar( self )
    render('jobs/jobs_monitor')
    attributes_table do
      row (I18n.t :filter_name) { |r| r.name }
      row (I18n.t :filter_relationship_operator) { |r| r.relationship_operator }
    end

    active_admin_user_wf( self, canon_type )
    active_admin_navigation_bar( self )
    active_admin_comments if !is_selection_mode?
  end

  sidebar :actions, :only => :show do
    render :partial => "activeadmin/section_sidebar_show", :locals => { :item => canon_type }
  end

  ##########
  ## Edit ##
  ##########

  form do |f|
    f.inputs do
      f.input :name, :label => (I18n.t :filter_name)
      f.input :relationship_operator, :label => (I18n.t :filter_relationship_operator)
      f.input :lock_version, :as => :hidden
    end
  end

  sidebar :actions, :only => [:edit, :new, :update] do
    render :partial => "activeadmin/section_sidebar_edit", :locals => { :item => canon_type }
  end

end