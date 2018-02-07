# A Canon Type
#
# === Fields
# * <tt>name</tt>
# * <tt>relationship_operator</tt>
#
# Usual wf_* fields are not shown

class CanonType < ActiveRecord::Base

  has_many :delayed_jobs, -> { where parent_type: "CanonType" }, class_name: Delayed::Job, foreign_key: "parent_id"
  belongs_to :user, :foreign_key => "wf_owner"

  validates_presence_of :name

  before_destroy :check_dependencies

  after_save :reindex

  attr_accessor :suppress_reindex_trigger

  alias_attribute :id_for_fulltext, :id

  enum wf_stage: [ :inprogress, :published, :deleted ]
  enum wf_audit: [ :basic, :minimal, :full ]

  # Suppresses the solr reindex
  def suppress_reindex
    self.suppress_reindex_trigger = true
  end

  def reindex
    return if self.suppress_reindex_trigger == true
    self.index
  end

  searchable :auto_index => false do
    integer :id
    text :id_text do
      id_for_fulltext
    end
    string :name_order do
      name
    end
    text :name

    string :relationship_operator do
      relationship_operator
    end
    text :relationship_operator

  end

  # ToDo: add in association check once canonic_technique table added
  def check_dependencies
    # if (self.canonic_techniques.count > 0)
    #   errors.add :base, "The canon type could not be deleted because it is used"
    #   return false
    # end
  end
end