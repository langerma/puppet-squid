require 'spec_helper'

describe 'squid' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        context "squid class without any parameters" do
          let(:params) {{ }}

          it {is_expected.to compile.with_all_deps}
    
          it {is_expected.to contain_class('squid')}
          it {is_expected.to contain_class('squid::params')}
          it {is_expected.to contain_class('squid::install').that_comes_before('squid::config')}
          it {is_expected.to contain_class('squid::config').that_comes_before('squid::service')}
          it {is_expected.to contain_class('squid::service')}
    
          it {is_expected.to contain_service('squid').that_subscribes_to('File[/etc/squid/squid.conf]')}
          it {is_expected.to contain_package('squid').with_ensure('present')}
          it {is_expected.to contain_file('/etc/squid/squid.conf')}
          it {is_expected.not_to contain_file('/etc/logrotate.d/squid')}
        end
        context "squid class with logrotate file" do
          let(:params) {{
            :rotateint => 'daily',
          }}
          it {is_expected.to compile.with_all_deps}
          it {is_expected.to contain_file('/etc/logrotate.d/squid')}
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'squid class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it {expect{is_expected.to contain_package('squid')}.to raise_error(Puppet::Error, /Nexenta not supported/)}
    end
  end
end
