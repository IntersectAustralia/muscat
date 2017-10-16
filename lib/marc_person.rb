class MarcPerson < Marc
  def initialize(source = nil)
    super("person", source)
  end

  def get_full_name_and_dates
    composer = ""
    composer_d = ""
    dates = nil

    if node = first_occurance("100", "a")
      if node.content
        composer = node.content.truncate(128)
        composer_d = node.content.downcase.truncate(128)
      end
    end
    
    if node = first_occurance("100", "d")
      if node.content
        dates = node.content.truncate(24)
      end
    end
    
    [composer, composer_d, dates]
  end
  
  def get_alternate_names_and_dates
    names = nil
    dates = nil

    if node = first_occurance("400", "a")
      if node.content
        names = node.content
      end
    end
    
    if node = first_occurance("400", "d")
      if node.content
        dates = node.content
      end
    end
    
    [names, dates]
  end
    
  def get_gender_birth_place_source_and_comments
    gender = 0
    birth_place = nil
    source = nil
    comments = nil

    if node = first_occurance("370", "a")
      if node.content
        birth_place = node.content.truncate(128)
      end
    end
    # OPTIMIZE Gender should be saved as string 
    if node = first_occurance("375", "a")
      if node.content
        gender = 1
      end
    end
    
    if node = first_occurance("670", "a")
      if node.content
        source = node.content.truncate(255)
      end
    end
    
    if node = first_occurance("680", "i")
      if node.content
        comments = node.content
      end
    end
    
    [gender, birth_place, source, comments]
  end
 
  def get_authority_links
    links = Hash.new {|hsh, key| hsh[key] = [] }
    tags_024 = by_tags(["024"])    
    tags_024.each do |tag|
      agency = tag.fetch_first_by_tag("2").content rescue ""
      agency_id = tag.fetch_first_by_tag("a").content rescue ""
      links[agency] << agency_id
    end
    return links
  end

  def individualized?
    if node = first_occurance("042", "a")
      if node.content == "individualized"
        return true
      end
    end
    return false
  end

  def to_source_node(tag)
    person = Person.find(get_id)
    node = MarcNode.new("source", tag, "", "1#")
    node.add_at(MarcNode.new("source", "a", person.full_name, nil), 0)
    node.add_at(MarcNode.new("source", "d", person.life_dates, nil), 0)
    node.add_at(MarcNode.new("source", "0", person.id, nil), 0)
    node.sort_alphabetically
    return node
  end
  
  
end
