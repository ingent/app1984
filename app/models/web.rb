class Web < ActiveRecord::Base

  validates_uniqueness_of :domain, :scope => [ :dia, :ip ]
end
