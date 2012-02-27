class Array
  # Fuuuuck RestClient.
  def to_param_hash
    hash = {}
    self.each_with_index do |obj, i|
      hash[i] = obj
    end
    hash
  end

end
