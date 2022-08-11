module Types
  include Dry::Types()

  Email = Types::String.constructor(&:downcase).constrained(
      format: /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/i
  )
  UUID = Types::Strict::String.constrained(
      format: /\A[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}\z/i
  )
  DateTime = Types::DateTime.constructor(&:to_datetime)
  Date = Types::Date.constructor(&:to_date)
end
