require 'spec_helper_acceptance'

describe 'deluge class:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  let(:pre_condition) { 'user {"deluge": ensure => present}' }
  let(:params) do
    {
      type: 'server',
    }
  end

  it 'deluge is expected to run successfully' do
    pp = "class { 'deluge': type => 'server', repo_manage => true, }"

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to match(%r{error}i)
    end
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to eq(%r{error}i)

      expect(r.exit_code).to be 2
    end
  end

  context 'package_ensure => present:' do
    it 'runs successfully' do
      pp = "class { 'deluge': type => 'server', repo_manage => true, package_ensure => present }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'package_ensure => absent:' do
    it 'runs successfully' do
      pp = "class { 'deluge': type => 'server', repo_manage => true, package_ensure => absent }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end
end
