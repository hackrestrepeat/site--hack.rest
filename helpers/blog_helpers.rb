module BlogHelpers

  def get_author(author_slug)
    author_slug = author_slug.downcase 
    result = data.authors.select { | author | author.keys.first == author_slug }
    raise ArgumentError unless result.any?
    result.first
  end

end