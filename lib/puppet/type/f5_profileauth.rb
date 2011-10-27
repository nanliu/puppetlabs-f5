Puppet::Type.newtype(:f5_profileauth) do
  @doc = "Manage F5 auth profiles."

  apply_to_device

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
    desc "The auth profile name."
  end

  newproperty(:authentication_method) do
    desc "The auth profile authentication method."
  end

  newproperty(:configuration_name) do
    desc "The auth profile configuration name."
  end

  newproperty(:credential_source) do
    desc "The auth profile credential source."
  end

  newproperty(:idle_timeout) do
    desc "The auth profile idle timeout."
  end

  newproperty(:profile_mode) do
    desc "The auth profile profile mode."
  end

  newproperty(:rule_name) do
    desc "The auth profile rule name."
  end
end
