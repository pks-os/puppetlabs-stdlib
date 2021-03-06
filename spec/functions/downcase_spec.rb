require 'spec_helper'

describe 'downcase', :if => Puppet::Util::Package.versioncmp(Puppet.version, '6.0.0') < 0 do
  it { is_expected.not_to eq(nil) }
  it { is_expected.to run.with_params.and_raise_error(Puppet::ParseError, %r{Wrong number of arguments}) }
  it { is_expected.to run.with_params(100).and_raise_error(Puppet::ParseError, %r{Requires either array or string}) }
  it { is_expected.to run.with_params('abc').and_return('abc') }
  it { is_expected.to run.with_params('Abc').and_return('abc') }
  it { is_expected.to run.with_params('ABC').and_return('abc') }

  it { is_expected.to run.with_params(AlsoString.new('ABC')).and_return('abc') }
  it { is_expected.to run.with_params([]).and_return([]) }
  it { is_expected.to run.with_params(['ONE', 'TWO']).and_return(['one', 'two']) }
  it { is_expected.to run.with_params(['One', 1, 'Two']).and_return(['one', 1, 'two']) }
end
