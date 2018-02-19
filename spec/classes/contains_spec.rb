require 'spec_helper'

describe 'deluge' do
  let(:params) {{ :type => 'server', }}
  let(:facts) {{ :is_virtual => 'false' }}

  let(:pre_condition) { 'user {"deluge": ensure => present}' }

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }
      describe "Testing the dependancies between the classes" do
        it { should contain_class('deluge::repo') }
        it { should contain_class('deluge::install') }
        it { should contain_class('deluge::config') }
        it { should contain_class('deluge::service') }
        it { should contain_class('deluge::logrotate') }
        it { should contain_class('deluge::firewall') }

        it { is_expected.to contain_class('deluge::repo').that_comes_before('Class[deluge::install]') }
        it { is_expected.to contain_class('deluge::install').that_comes_before('Class[deluge::config]') }
        it { is_expected.to contain_class('deluge::config').that_comes_before('Class[deluge::service]') }
        it { is_expected.to contain_class('deluge::service').that_comes_before('Class[deluge::logrotate]') }
        it { is_expected.to contain_class('deluge::logrotate').that_comes_before('Class[deluge::firewall]') }
      end
    end
  end
end

describe 'deluge' do
  let(:params) {{ :type => 'client', }}
  let(:facts) {{ :is_virtual => 'false' }}

  let(:pre_condition) { 'user {"deluge": ensure => present}' }

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }
      describe "Testing the dependancies between the classes" do
        it { should contain_class('deluge::repo') }
        it { should contain_class('deluge::install') }

        it { is_expected.to contain_class('deluge::repo').that_comes_before('Class[deluge::install]') }
      end
    end
  end
end