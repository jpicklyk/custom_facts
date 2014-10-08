#
#  A simple way to convert the hostname into roles automatically.
#
#  See https://gist.github.com/jrottenberg/5872127 for more complicated examples
#  using fqdn.

if Facter.value(:hostname) == "puppetmaster"
  Facter.add('puppet_role') do
    setcode do
      'puppet'
    end
  end

# ([a-z]+)[0-9]+, i.e. www01 or logger22 have a puppet_role of www or logger
elsif Facter.value(:hostname) =~ /^([a-z]+)[0-9]+$/
  Facter.add('puppet_role') do
    setcode do
      $1
    end
  end

# ([a-z]+), i.e. www or logger have a puppet_role of www or logger
elsif Facter.value(:hostname) =~ /^([a-z]+)$/
  Facter.add('puppet_role') do
    setcode do
      $1
    end
  end

# Set to hostname if no patterns match
else
  Facter.add('puppet_role') do
    setcode do
      'default'
    end
  end
end