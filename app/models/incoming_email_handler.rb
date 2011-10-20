class IncomingEmailHandler < ActionMailer::Base
  def receive(email)
    e = Email.new
    begin
      e.from = email.from.join(" ").strip[0..254]
      e.to = email.to.join(" ").strip[0..254]
      e.body = email.body.strip[0..254]
      e.subject = email.subject.strip[0..254]
      e.spam = true if email.header_string("X-Spam-Flag")
      e.spam_score = email.header_string("X-Spam-Score").to_f
      e.bytes = email.to_s.size
      if email.has_attachments?
        e.attachments = email.attachments.collect{|a| a.original_filename}.join(" ").strip[0..254]
      end
      e.save!
    rescue
      e.save
    end
  end
end
