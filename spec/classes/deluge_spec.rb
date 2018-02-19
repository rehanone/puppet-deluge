require 'spec_helper'

describe 'deluge' do
  let(:facts) {{ :is_virtual => 'false' }}

  let(:pre_condition) { 'user {"deluge": ensure => present}' }

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

    end
  end
end
