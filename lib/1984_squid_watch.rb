#!/usr/bin/env ruby
#
# espera noves entrades a /var/log/squid/access_log i les processa
# per fer l'analisi de les webs visitades
#

require 'syslog'
require File.join(File.dirname(__FILE__), 'daemonize')

include Daemonize

log = Syslog.open("1984")
log.info 'Starting 1984_squid_watch...'

daemonize()

log.info `/var/www/1984/script/runner LogAnalizer.realtime_analize 2>&1`



