require 'spec_helper'

describe 'deluge' do
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

      it { should contain_class('deluge::install') }
      it { should contain_class('deluge::config') }

      describe "deluge::config" do
        it { is_expected.to have_resource_count(3) }
      end

      describe 'deluge::install' do
        let(:params) {{ :package_ensure => 'present', :package_name => 'deluge', :package_manage => true, }}

        it { should contain_package('deluge').with(
          :ensure => 'present'
        )}

        describe 'should allow package ensure to be overridden' do
          let(:params) {{ :package_ensure => 'latest', :package_name => 'deluge', :package_manage => true, }}
          it { should contain_package('deluge').with_ensure('latest') }
        end

        describe 'should allow the package name to be overridden' do
          let(:params) {{ :package_ensure => 'present', :package_name => 'hambaby', :package_manage => true, }}
          it { should contain_package('hambaby') }
        end

        describe 'should allow the package to be unmanaged' do
          let(:params) {{ :package_manage => false, :package_name => 'deluge', }}
          it { should_not contain_package('deluge') }
        end
      end

    end
  end
end
