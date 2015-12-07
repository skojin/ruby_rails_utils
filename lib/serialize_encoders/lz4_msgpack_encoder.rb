require 'msgpack'
require 'lz4-ruby'

# encode in MessagePack with LZ4 compression
module LZ4MsgpackEncoder
  extend self

  def load(v)
    return nil if v == nil
    MessagePack.unpack(LZ4::uncompress(v))
  end
  def dump(v)
    return nil if v == nil
    LZ4::compressHC(MessagePack.pack(v))
  end
end