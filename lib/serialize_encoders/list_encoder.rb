class ListEncoder
  # @param reject :blank? to remove empty strings
  def initialize(delimiter = ',', reject: nil)
    @delimiter = delimiter
    @reject = reject
  end

  def load(coma_str)
    return nil if coma_str == nil
    coma_str.split(@delimiter)
  end

  def dump(array)
    return nil if array == nil
    array = array.reject(&@reject) if @reject
    d = array.join(@delimiter)
    d << @delimiter unless array.empty? # add delimiter(,) at end, to make possible queries "LIKE ? '1,'"
    d
  end
end