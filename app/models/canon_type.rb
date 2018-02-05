# A Canon Type
#
# === Fields
# * <tt>name</tt>
# * <tt>relationship_operator</tt>
#
# Usual wf_* fields are not shown

class CanonType < ActiveRecord::Base

  validates_presence_of :name

  enum wf_stage: [ :inprogress, :published, :deleted ]
  enum wf_audit: [ :basic, :minimal, :full ]

end