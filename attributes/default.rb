# These are basically the defaults from ubuntu.
# set as appropriate for your environment.
#
# Given how chef attributes work, to remove something set,
# set it to ""
#
# Note that some conf values need to be in quotes.
default[:tinyproxy][:conf] = {
  "User" => "nobody",
  "Group" => "nogroup",
  "Port" => "8888",
  "Timeout" => "600",
  "DefaultErrorFile" => '"/usr/share/tinyproxy/default.html"',
  "StatHost" => '"tinyproxy.stats"',
  "StatFile" => '"/usr/share/tinyproxy/stats.html"',
  "Logfile" => '"/var/log/tinyproxy/tinyproxy.log"',
  #"Syslog" => "On",
  "LogLevel" => "Info",
  "PidFile" => '"/var/run/tinyproxy/tinyproxy.pid"',
  #"XTinyproxy" => "Yes",

  "MaxClients" => 100,
  "MinSpareServers" => 5,
  "MaxSpareServers"=>  20,
  "StartServers" => 10,
  "MaxRequestsPerChild" => 0,

  "ViaProxyName" => '"tinyproxy"',
  #"DisableViaHeader" => "Yes",

  "Allow" => [ "127.0.0.1" ],
  #"Filter" => '"/etc/filter"',
  #"FilterURLs" => "On",
  #"FilterExtended" => "On",
  #"FilterCaseSensitive" => "On",
  #"FilterDefaultDeny" => "Yes",
  "ConnectPort" => [ 443 ],
}

# What are the allowed hosts we proxy to?
default[:tinyproxy][:filters] = []
