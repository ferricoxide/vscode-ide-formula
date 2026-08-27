# frozen_string_literal: true

control 'vscode-ide.config.file' do
  title 'Verify system-wide VSCode configuration files'

  describe file('/etc/vscode-ide.conf') do
    it { should exist }
    it { should be_file }
    its('group') { should eq 'root' }
    its('mode') { should cmp '00644' }
    its('owner') { should eq 'root' }
    its('content') do
      should match /"telemetry\.telemetryLevel":\s*"off"/
    end
  end

  describe file('/etc/vscode/settings.json') do
    it { should exist }
    it { should be_file }
    its('group') { should eq 'root' }
    its('mode') { should cmp '00644' }
    its('owner') { should eq 'root' }
    its('content') do
      should match /"editor\.formatOnSave":\s*true/
    end
  end
end
