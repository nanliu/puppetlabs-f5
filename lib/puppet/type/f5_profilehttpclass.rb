Puppet::Type.newtype(:f5_profilehttpclass) do
  @doc = "Manage F5 httpclass profiles."

#  apply_to_device

  ensurable do
    desc "Manage httpclass profile."

    defaultto(:present)

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end
  end

  newparam(:name, :namevar=>true) do
    desc "The httpclass profile name."
  end

  newproperty(:application_security_module_enabled_state) do
    desc "The httpclass profile application security module enabled state."
  end

  newproperty(:cookie_match_pattern) do
    desc "The httpclass profile cookie match pattern."
  end

#  newproperty(:default_profile) do
#    desc "The httpclass profile default."
#  end

  newproperty(:header_match_pattern) do
    desc "The httpclass profile header match pattern."
  end

  newproperty(:host_match_pattern) do
    desc "The httpclass profile host match pattern."
  end

  newproperty(:path_match_pattern) do
    desc "The httpclass profile path match pattern."
  end

  newproperty(:pool_name) do
    desc "The httpclass profile pool name."
  end

  newproperty(:redirect_location) do
    desc "The httpclass profile redirect location."
  end

  newproperty(:rewrite_url) do
    desc "The httpclass profile rewrite url."
  end

  newproperty(:web_accelerator_module_enabled_state) do
    desc "The httpclass profile web accelerator module enabled state."
  end
end
