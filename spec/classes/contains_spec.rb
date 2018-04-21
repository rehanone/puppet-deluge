require 'spec_helper'

describe 'deluge' do
  let(:pre_condition) { 'user {"deluge": ensure => present}' }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      describe 'deluge server' do
        let(:params) do
          {
            type: 'server',
          }
        end

        it { is_expected.to compile.with_all_deps }
        describe 'Testing the dependencies between the classes' do
          it { is_expected.to contain_class('deluge::repo') }
          it { is_expected.to contain_class('deluge::install') }
          it { is_expected.to contain_class('deluge::config') }
          it { is_expected.to contain_class('deluge::service') }
          it { is_expected.to contain_class('deluge::logrotate') }
          it { is_expected.to contain_class('deluge::firewall') }

          it { is_expected.to contain_class('deluge::repo').that_comes_before('Class[deluge::install]') }
          it { is_expected.to contain_class('deluge::install').that_comes_before('Class[deluge::config]') }
          it { is_expected.to contain_class('deluge::config').that_comes_before('Class[deluge::service]') }
          it { is_expected.to contain_class('deluge::service').that_comes_before('Class[deluge::logrotate]') }
          it { is_expected.to contain_class('deluge::logrotate').that_comes_before('Class[deluge::firewall]') }
        end
      end

      describe 'deluge client' do
        let(:params) do
          {
            type: 'server',
          }
        end

        it { is_expected.to compile.with_all_deps }
        describe 'Testing the dependencies between the classes' do
          it { is_expected.to contain_class('deluge::repo') }
          it { is_expected.to contain_class('deluge::install') }

          it { is_expected.to contain_class('deluge::repo').that_comes_before('Class[deluge::install]') }
        end
      end
    end
  end
end
