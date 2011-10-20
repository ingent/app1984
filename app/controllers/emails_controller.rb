require "csv"

class EmailsController < ApplicationController

  include ApplicationHelper

  def index
    list
    render :action => 'list'
  end

  def list
    @email_pages, @emails = paginate :emails, { :per_page => 50, :order => 'created_at DESC' }
  end

  def show
    @email = Email.find(params[:id])
  end

  def report
    if params[:commit] then
      @report = Report.new(params[:report])
      if @report.valid? then
        @emails = Email.find(:all, :order => "`#{@report.order}`", :conditions => ["`from` LIKE ? AND (created_at BETWEEN ? and ?)","%#{@report.filter}",@report.from,@report.to])
        if params[:commit]=="Download" then
          csv_report
        end
      end
    else
      @report = Report.new
      @report.to = Time.now
      @report.from = @report.to.months_ago 1
    end
  end


  private

  def csv_report
    content_type = if request.user_agent =~ /windows/i
                     ' application/vnd.ms-excel '
                   else
                     ' text/csv '
                   end
    CSV::Writer.generate(output = "") do |csv|
      csv << ["DATE", "HOUR", "FROM", "TO", "SUBJECT", "ATTACHMENTS", "BYTES"]
      @emails.each do |email|
        csv << ["\"#{data(email.created_at)}\"",hora(email.created_at),email.from, email.to, email.subject, email.attachments, email.bytes]
      end
    end
    send_data(output,
              :type => content_type,
              :filename => "email-report.csv")
  end

end
