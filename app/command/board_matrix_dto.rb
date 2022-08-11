require 'util/application_read_struct'
require 'util/types'

class BoardMatrixDto < ApplicationReadStruct
  attribute? :matrix, Types::Array.of(Types::Array.of(Types::Any)).optional
end