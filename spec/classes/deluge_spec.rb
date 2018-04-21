require 'spec_helper'

describe 'deluge' do
  let(:pre_condition) { 'user {"deluge": ensure => present}' }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
