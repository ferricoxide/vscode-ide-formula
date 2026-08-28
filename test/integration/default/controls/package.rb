# frozen_string_literal: true

control 'VSCode Package Installation' do
  title 'Verify Visual Studio Code package installation'

  if os.windows?
    describe package('Microsoft Visual Studio Code') do
      it { should be_installed }
    end

    describe file('C:/Program Files/Microsoft VS Code/Code.exe') do
      it { should exist }
      it { should be_file }
    end
  else
    describe package('code') do
      it { should be_installed }
    end
  end
end
