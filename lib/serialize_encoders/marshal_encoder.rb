module MarshalEncoder
  extend self

  def load(v)
    return nil if v == nil
    Marshal.load(v)
  end
  def dump(v)
    return nil if v == nil
    Marshal.dump(v)
  end
end