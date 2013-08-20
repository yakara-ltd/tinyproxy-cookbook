package "tinyproxy"

service "tinyproxy" do
  action :enable
end

template "/etc/tinyproxy.conf" do
  source "tinyproxy.conf.erb"
  owner "root"
  group "root"
  mode "644"
  notifies :restart, resources(:service => "tinyproxy")
end

# we need to strip out the quotes, so this is a little roundabout
# There are issues around compile time verse runtime, and various
# things being set to nil
filter_file = node[:tinyproxy][:conf]["Filter"]
if(not filter_file.nil? and not filter_file.tr('"\'', '').empty? )
  filters = {}
  data_bag_item('tinyproxy', 'filter_rules').reject {|k, v| k == 'id' }.each do |group, rules|
    filters[group] = rules.map do |rule|
      if rule =~ /\d+\.\d+\.\d+\.\d+\/\d+/
        IPAddr.new(rule).to_range.map { |i| i.to_s }
      else
        rule
      end
    end.flatten
  end
  template filter_file.tr('"\'', '') do
    source "filter.erb"
    owner "root"
    group "root"
    mode "644"
    variables :filters => filters
    notifies :restart, resources(:service => "tinyproxy")
  end
end
