require 'puppet/provider/f5'

Puppet::Type.type(:f5_profilehttp).provide(:f5_profilehttp, :parent => Puppet::Provider::F5) do
  @doc = "Manages f5 device"

  confine :feature => :posix
  defaultfor :feature => :posix

  def self.wsdl
    'LocalLB.ProfileHttp'
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
    'basic_auth_realm',
    'cookie_encryption',
    'cookie_encryption_passphrase',
    'default_profile',
    'failback_host_name',
    'header_erase',
    'header_insert',
    'insert_xforwarded_for_header_mode',
    'lws_maximum_column',
    'lws_seperator',
    'maximum_header_size',
    'maximum_requests',
    'oneconnect_header_transformation_state',
    'permitted_response_header',
    'pipelining_mode',
    'redirect_rewrite_mode',
    'request_chunk_mode',
    'response_chunk_mode',
    'security_enabled_request_state',
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

  def create
    Puppet.debug("Puppet::Provider::F5_ProfileClientSSL: creating F5 client ssl profile #{resource[:name]}")
  end

  def destroy
    Puppet.debug("Puppet::Provider::F5_ProfileClientSSL: destroying F5 client ssl profile #{resource[:name]}")
    transport[wsdl].delete_profile([resource[:name]])
  end

  def exists?
    transport[wsdl].get_list.include?(resource[:name])
  end
end
