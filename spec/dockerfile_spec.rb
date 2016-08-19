require 'dockerspec'
require 'dockerspec/serverspec'
require_relative "spec_helper"

describe 'Dockerfile' do
  describe docker_build('.', tag: 'jenkins') do
      it { should have_maintainer /Hearst Automation Team/ }

    describe docker_run('jenkins') do
      describe file('/etc/debian_version') do
        it { should be_file }
        its(:content) { should match /^8\./ }
      end

      describe 'jenkins-install' do
        it "has jenkins #{JENKINS_VERSION_MATCH} installed" do
          expect(command("echo $JENKINS_VERSION").stdout).to match(/#{JENKINS_VERSION_MATCH}/)
        end
      end
    end
  end
end
