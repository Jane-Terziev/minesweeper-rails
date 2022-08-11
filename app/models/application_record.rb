class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include Pagy::Backend

  ACTIVERECORD_MAX_INTEGER = 2_147_483_647.freeze

  def self.find_by_id(id)
    Optional.of_nullable(find_by(primary_key => id))
  end

  def self.get_by_id(id)
    find_by_id(id).or_else_raise { ActiveRecord::RecordNotFound.new("Cannot find #{name.demodulize} with id: #{id}") }
  end

  def self.paginate(collection:, page_request: { page: 1, page_size: 10 }, vars: {})
    pagy = Pagy.new(count: collection.count(:all), page: page_request[:page], items: page_request[:page_size], **vars)
    [pagy, collection.offset(pagy.offset).limit(pagy.items)]
  end

  def self.save(record)
    record.tap(&:save)
  end

  def self.save!(record)
    record.tap(&:save!)
  end

  def self.delete!(record)
    record.tap(&:destroy!)
  end
end
