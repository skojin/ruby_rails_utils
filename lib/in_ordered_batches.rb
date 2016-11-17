# same as find_in_batches but with order support
# @usage InOrderedBatches.new(BizLocal.where(...), :updated_at, '2015-01-01'.to_time).each{|records| ... }
class InOrderedBatches
  def initialize(scope, key, start, batch_size: 1000)
    @scope = scope.order("#{key}, id").limit(batch_size)
    @key = key
    @value = start
    @batch_size = batch_size
  end

  def each # &:block
    last_id = 0
    while (records = @scope.where("(#{@key} = :v AND id > :id) OR (#{@key} > :v)", v: @value, id: last_id).to_a).present?
      yield(records)
      break if records.size < @batch_size
      @value = records.last.try(@key)
      last_id = records.last.try(:id)
    end
  end
end