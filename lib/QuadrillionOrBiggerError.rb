class QuadrillionOrBiggerError < StandardError
  attr_reader :object

  def initialize(object)
    super("The number is quadrillion or bigger #{object}")
    @object = object
  end
end