require 'puppet/provider/f5'

Puppet::Type.type(:f5_profilehttpclass).provide(:f5_profilehttpclass, :parent => Puppet::Provider::F5) do
  @doc = "Manages f5 httpclass profile"

  confine :feature => :posix
  defaultfor :feature => :posix

  def self.wsdl
    'LocalLB.ProfileHttpClass'
  end

  def wsdl
    self.class.wsdl
  end

  def self.instances
    transport[wsdl].get_list.collect do |name|
      new(:name => name)
    end
  end

  methods = [
    'application_security_module_enabled_state',
    'cookie_match_pattern',
    'default_profile',
    'header_match_pattern',
    'host_match_pattern',
    'path_match_pattern',
    'pool_name',
    'redirect_location',
    'rewrite_url',
    'web_accelerator_module_enabled_state',
  ]

  methods.each do |method|
    define_method(method.to_sym) do
      if transport[wsdl].respond_to?("get_#{method}".to_sym)
        profile_string = transport[wsdl].send("get_#{method}", resource[:name]).first
        {"value" => profile_string.value, "default_flag" => profile_string.default_flag}
      end
    end
  end

  methods.each do |method|
    define_method("#{method}=") do |profile_string|
      if transport[wsdl].respond_to?("set_#{method}".to_sym)
        transport[wsdl].send("set_#{method}",
                              resource[:name],
                              [:value => profile_string["value"],
                               :default_flag => profile_string["default_flag"]])
      end
    end
  end

  methods =  [
    'cookie_match_pattern',
    'header_match_pattern',
    'host_match_pattern',
    'path_match_pattern',
  ]

  methods.each do |method|
    define_method(method.to_sym) do
      if transport[wsdl].respond_to?("get_#{method}".to_sym)
        profile_string = transport[wsdl].send("get_#{method}", resource[:name]).first
        {"value" => profile_string.values.collect{|val| {'pattern' => val.pattern, 'is_glob' => val.is_glob } }, "default_flag" => profile_string.default_flag}
      end
    end
  end

  methods.each do |method|
    define_method("#{method}=") do |profile_string|
      if transport[wsdl].respond_to?("set_#{method}".to_sym)
        transport[wsdl].send("set_#{method}",
                              resource[:name],
                              [:values => profile_string["value"],
                               :default_flag => profile_string["default_flag"]])
      end
    end
  end

  def create
    Puppet.debug("Puppet::Provider::F5_ProfileHttpClass: creating profile #{resource[:name]}")
  end

  def destroy
    Puppet.debug("Puppet::Provider::F5_ProfileHttpClass: destroying profile #{resource[:name]}")
    transport[wsdl].delete_profile([resource[:name]])
  end

  def exists?
    transport[wsdl].get_list.include?(resource[:name])
  end
end
