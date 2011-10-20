class Email < ActiveRecord::Base
  def spam_score=(v)
    write_attribute("spam_score", v.to_f * 100)
  end

  def spam_score
    read_attribute("spam_score").to_f / 100
  end
end
