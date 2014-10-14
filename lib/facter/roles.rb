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

# ^([a-z]+)[0-9]+\-([a-z0-9]{5})$, i.e. dc01-lab45 would have a role of dc and be a part of lab lab45
elsif Facter.value(:hostname) =~ /^([a-z]+)[0-9]*\-([a-z0-9]+)$/i
  Facter.add('puppet_role') do
    setcode do
      $1
    end
  end
  Facter.add('puppet_lab') do
    setcode do
      $2
    end
  end
# ^([a-z]+)[0-9]*$, i.e. dc or dc01 have a puppet_role of dc and belong to the default lab
elsif Facter.value(:hostname) =~ /^([a-z]+)[0-9]*$/i
  Facter.add('puppet_role') do
    setcode do
      $1
    end
  end
  Facter.add('puppet_lab') do
      setcode do
        'default'
      end
    end
# Set to hostname if no patterns match
else
  Facter.add('puppet_role') do
    setcode do
      'default'
    end
  end
  Facter.add('puppet_lab') do
      setcode do
        'default'
      end
    end
end
