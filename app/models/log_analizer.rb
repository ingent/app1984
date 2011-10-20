class LogAnalizer < ActiveRecord::Base

  require 'file/tail'

  LOGFILE = "/var/log/squid/access.log"
  EXCLUDE = ["cache_object://localhost","localhost"]
  
  # data            bytes ip          
  # 1203503096.141    152 192.0.0.200 TCP_MISS/200 455 GET http://logc147.xiti.com/hit.xiti? - DIRECT/80.118.149.114 image/GIF

  def self.realtime_analize
    `echo #{Process.pid} > /var/run/1984.pid`
    @last_analized = Web.find(:first, :order => "dia DESC").dia.to_i rescue 0
    File::Tail::Logfile.open(LOGFILE) do |log|
      log.tail { |line| analize_line(line) }
    end
  end

  private

  def self.analize_line(line)
    line    = line.split
    t       = Time.at line[0].to_i
    dia     = (t.to_i - t.seconds_since_midnight).to_i
    # saltar els accessos mes antics d'avui, tot i que es repetiran els que ja hagin fet avui..
    return if @last_analized > dia
    bytes   = line[1].to_i
    ip      = line[2]
    begin
      domini  = line[6].split("/")[2].gsub(/www\./,'')
    rescue Exception => e
      domini = line[6]
      logger.error("\nanalize_line Exception in line: #{domini}\n#{e}")
    end
   
    return if EXCLUDE.include?(domini)
    
    web     = Web.find(:all, :conditions => [ "domain = ? AND ip = ? AND dia = ?", domini, ip, dia], :limit => 1).first

    min  = t.min  < 10 ? "0#{t.min}" : t.min
    hour = t.hour < 10 ? "0#{t.hour}" : t.hour

    if web.nil?
      web = Web.new
      web.dia         = dia
      web.bytes       = bytes
      web.ip          = ip
      web.domain      = domini
      web.hora_inici  = "#{hour}:#{min} h"
      web.contador    = 0
    end

    web.contador += 1
    web.hora_fi = "#{hour}:#{min} h"

    web.save

  end

end
