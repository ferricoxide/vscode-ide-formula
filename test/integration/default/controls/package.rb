# frozen_string_literal: true

control 'vscode-ide.package.install' do
  title 'Verify VSCode package installation'

  describe package('code') do
    it { should be_installed }
  end
end
