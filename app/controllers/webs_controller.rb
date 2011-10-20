require "csv"

class WebsController < ApplicationController

  layout 'emails'

  include ApplicationHelper

  def index
    @web_pages, @webs = paginate :webs, { :per_page => 50, :order => 'updated_at DESC' }
  end

  def analize_yesterday
    day = Time.now.yesterday.to_i
    @processed = LogAnalizer.analize(day)
  end

  def report
    if params[:commit] then
      @report = Report.new(params[:report])
      if @report.valid? then
        if @report.filter and @report.filter.size > 0
          @webs = Web.find(:all, :order => "#{@report.order} DESC", :conditions => ["ip = ? AND ( dia BETWEEN ? AND ? )",@report.filter,@report.i_from,@report.i_to])
        else
          @webs = Web.find(:all, :order => "#{@report.order} DESC", :conditions => ["dia BETWEEN ? AND ?",@report.i_from,@report.i_to])
        end
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
      csv << ["DAY", "IP", "DOMAIN", "FIRST", "LAST", "BYTES", "COUNT"]
      @webs.each do |web|
        csv << [ Time.at(web.dia).strftime("%d %b %Y"), web.ip, web.domain, web.hora_inici, web.hora_fi, web.bytes, web.contador ]
      end
    end
    send_data(output,
              :type => content_type,
              :filename => "www-report.csv")
  end
  
  
end
