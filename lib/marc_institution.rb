class MarcInstitution < Marc
  def initialize(source = nil)
    super("institution", source)
  end
  
  def get_name_and_place
    name = ""
    place = ""

    if node = first_occurance("110", "a")
      if node.content
        name = node.content.truncate(128)
      end
    end
    
    if node = first_occurance("110", "c")
      if node.content
        place = node.content.truncate(24)
      end
    end
    [name, place]
  end
  def get_address_and_url
    address = ""
    url = ""

    if node = first_occurance("371", "a")
      if node.content
        address = node.content.truncate(128)
      end
    end
    
    if node = first_occurance("371", "u")
      if node.content
        url = node.content.truncate(24)
      end
    end
    [address, url]
  end
 
  def get_siglum
    if node = first_occurance("110", "g")
      if node.content
        node.content.truncate(32)
      end
    end
  end
  def to_external(updated_at = nil, versions = nil, holdings = false)
    # cataloguing agency
    _003_tag = first_occurance("003")
    if !_003_tag
      agency = MarcNode.new(@model, "003", RISM::AGENCY, "")
      @root.children.insert(get_insert_position("003"), agency)
    end
  
    if updated_at
      last_transcation = updated_at.strftime("%Y%m%d%H%M%S") + ".0"
      # 005 should not be there, if it is avoid duplicates
      _005_tag = first_occurance("005")
      if !_005_tag
        @root.children.insert(get_insert_position("003"),
            MarcNode.new(@model, "005", last_transcation, nil))
      end
    end
    by_tags("667").each {|t| t.destroy_yourself}
  end
  
 
end
