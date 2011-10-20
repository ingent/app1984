class Report < ActiveRecord::Base

  attr_accessor :filter

  def i_from
    from.to_i
  end

  def i_to
    to.to_i
  end

  protected
  def validate
    if from > to then
      errors.add(:to, "must be greater or equal to from")
    end
  end

end
