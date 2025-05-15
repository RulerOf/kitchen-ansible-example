control 'Service Checker' do
  impact 'high'
  title 'Checks that the services configured in the input are running'
  desc 'Validate services are running'

  input('services').each do |service|
    describe service(service) do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
  end
end
