require 'puppet/provider/f5'

Puppet::Type.type(:f5_profileauth).provide(:f5_profileauth, :parent => Puppet::Provider::F5) do
  @doc = "Manages f5 auth profile"

  confine :feature => :posix
  defaultfor :feature => :posix

  def self.wsdl
    'LocalLB.ProfileAuth'
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
    'authentication_method',
    'configuration_name',
    'credential_source',
    'idle_timeout',
    'profile_mode',
    'rule_name',
  ]

  methods.each do |method|
    define_method(method.to_sym) do
      if transport[wsdl].respond_to?("get_#{method}".to_sym)
        profile_string = transport[wsdl].send("get_#{method}", resource[:name]).first

        { "value"        => profile_string.value.to_s,
          "default_flag" => profile_string.default_flag}
      end
    end
  end

  methods.each do |method|
    define_method("#{method}=") do |profile_string|
      if transport[wsdl].respond_to?("set_#{method}".to_sym)
        transport[wsdl].send("set_#{method}", resource[:name],
                              [ :value        => profile_string["value"],
                                :default_flag => profile_string["default_flag"] ] )
      end
    end
  end

  # default profile is the only attribute that does not support default_flag.
  def default_profile
    transport[wsdl].get_default_profile(resource[:name]).first
  end

  def default_profile=(value)
    transport[wsdl].set_default_profile(resource[:name], resource[:default_profile])
  end

  def create
    Puppet.debug("Puppet::Provider::F5_ProfileAuth: creating profile #{resource[:name]}")

  #  require 'ruby-debug'
  #  Debugger.start
  #  debugger

    transport[wsdl].create([resource[:name]],
                           [{ :value        => resource[:configuration_name]['value'],
                              :default_flag => resource[:configuration_name]['default_flag'] }],
                           [{ :value        => resource[:authentication_method]['value'],
                              :default_flag => resource[:authentication_method]['default_flag'] }])
  end

  def destroy
    Puppet.debug("Puppet::Provider::F5_ProfileAuth: destroying profile #{resource[:name]}")

    transport[wsdl].delete_profile([resource[:name]])
  end

  def exists?
    transport[wsdl].get_list.include?(resource[:name])
  end
end
