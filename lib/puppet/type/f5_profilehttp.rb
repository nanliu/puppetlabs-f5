Puppet::Type.newtype(:f5_profilehttp) do
  @doc = "Manage F5 http profiles."

  apply_to_device

  ensurable do
    desc "Manage F5 http profile."

    defaultto(:present)

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end
  end

  newparam(:name, :namevar=>true) do
    desc "The http profile name."
  end

  newproperty(:basic_auth_realm) do
    desc "The http profile basic auth realm."
  end

#  newproperty(:cookie_encryption) do
#    desc "The http profile cookie encryption."
#  end

#  newproperty(:cookie_encryption_passphrase) do
#    desc "The http profile cookie encryption passphrase."
#  end
#
#  newproperty(:default_profile) do
#    desc "The http default profile."
#  end
#
  newproperty(:failback_host_name) do
    desc "The http profile failback host name."
  end

  newproperty(:header_erase) do
    desc "The http profile header erase."
  end

  newproperty(:header_insert) do
    desc "The http profile header insert."
  end

  newproperty(:insert_xforwarded_for_header_mode) do
    desc "The http profile insert xforwarded for header mode."
  end

  newproperty(:lws_maximum_column) do
    desc "The http profile lws maximum column."
  end

  newproperty(:lws_seperator) do
    desc "The http profile lws seperator."
  end

  newproperty(:maximum_header_size) do
    desc "The http profile maximum header_size."
  end

  newproperty(:maximum_requests) do
    desc "The http profile maximum requests."
  end

  newproperty(:oneconnect_header_transformation_state) do
    desc "The http profile oneconnect header transformation state."
  end

#  newproperty(:permitted_response_header) do
#    desc "The http profile permitted response header."
#  end

  newproperty(:pipelining_mode) do
    desc "The http profile pipelining mode."
  end

  newproperty(:redirect_rewrite_mode) do
    desc "The http profile redirect rewrite mode."
  end

  newproperty(:request_chunk_mode) do
    desc "The http profile request chunk mode."
  end

  newproperty(:response_chunk_mode) do
    desc "The http profile response chunk mode"
  end

  newproperty(:security_enabled_request_state) do
    desc "The http profile security enabled request state."
  end
end
