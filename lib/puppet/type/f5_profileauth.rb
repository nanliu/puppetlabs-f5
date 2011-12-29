Puppet::Type.newtype(:f5_profileauth) do
  @doc = "Manage F5 auth profiles."

#  apply_to_device

  ensurable do
    desc "Manage F5 auth profile."

    defaultto(:present)

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end
  end

  newparam(:name, :namevar=>true) do
    desc "The ProfileAuth interface enables you to manipulate a local load
    balancer's authentication profile"
  end

  newproperty(:authentication_method) do
    desc "The authentication methods that the specified profiles will be
    using."

    validate do |value|
      raise Puppet::Error, 'Pupppet::Type::F5_ProfileAuth: authentication_method value must be /^AUTHENTICATION_METHOD_(LDAP|RADIUS|SSL_CC_LDAP|SSL_OCSP|TACACS|GENERIC|SSL_CRLDP)$/.' unless value['value'] =~ /^AUTHENTICATION_METHOD_(LDAP|RADIUS|SSL_CC_LDAP|SSL_OCSP|TACACS|GENERIC|SSL_CRLDP)$/
    end
  end

  newproperty(:configuration_name) do
    desc "The names of the authentication configurations that the specified
    profiles will be using."

    validate do |value|
      raise Puppet::Error, 'Pupppet::Type::F5_ProfilePersistence: configuration_name value must be type string.' unless value['value'].is_a? String
    end
  end

  newproperty(:credential_source) do
    desc "The sources of the credentials that the specified profiles will be
    using."

    validate do |value|
      raise Puppet::Error, 'Pupppet::Type::F5_ProfileAuth: credential_source value must be /^CREDENTIAL_SOURCE_HTTP_BASIC_AUTH$/' unless value['value'] =~ /^CREDENTIAL_SOURCE_HTTP_BASIC_AUTH$/
    end
  end

  newproperty(:default_profile) do
    desc "The names of the default profiles from which the specified profiles
    will derive default values for its attributes."
  end

  newproperty(:idle_timeout) do
    desc "The idle timeout for the specified auth profiles."

    validate do |value|
      raise Puppet::Error, 'Pupppet::Type::F5_ProfilePersistence: idle_timeout value must be /^\d+/.' unless value['value'] =~ /^\d+/
    end
  end

  newproperty(:profile_mode) do
    desc "The modes for the specified auth profiles."

    validate do |value|
      raise Puppet::Error, 'Pupppet::Type::F5_ProfileAuth: profile_mode value must be /^PROFILE_MODE_(DISABLED|ENABLED)$/' unless value['value'] =~ /^PROFILE_MODE_(DISABLED|ENABLED)$/
    end
  end

  newproperty(:rule_name) do
    desc "The names of rules that the specified profiles will be using."

    validate do |value|
      raise Puppet::Error, 'Pupppet::Type::F5_ProfilePersistence: rule_name value must be type string.' unless value['value'].is_a? String
    end
  end
end
