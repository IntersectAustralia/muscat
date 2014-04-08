# A StandardTerm is a standardized keyword, ex. "Airs (instr.)"
#
# === Fields
# * <tt>term</tt> - the keyword
# * <tt>alternate_terms</tt> - alternate spellings for this keyword
# * <tt>notes</tt>
# * <tt>src_count</tt> - keeps track of the Source models tied to this element
#
# Other standard wf_* not shown
# The other functions are standard, see Catalogue for a general description

class StandardTerm < ActiveRecord::Base
  
  has_and_belongs_to_many :sources
    
  validates_presence_of :term
  
  validates_uniqueness_of :term
    
  before_destroy :check_dependencies
    
  def check_dependencies
    if (self.sources.count > 0)
      errors.add :base, "The standard term could not be deleted because it is used"
      return false
    end
  end
  
end
