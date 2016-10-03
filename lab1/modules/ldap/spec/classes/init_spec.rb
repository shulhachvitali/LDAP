require 'spec_helper'
describe 'zabbix' do
  context 'with default values for all parameters' do
    it { should contain_class('zabbix') }
  end
end
