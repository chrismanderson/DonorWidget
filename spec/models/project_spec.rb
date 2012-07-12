require 'spec_helper'

describe Project do

  context '.create_from_url' do
    use_vcr_cassette
    it 'creates a project with the right attributes' do
      Project.create_from_url 'http://www.donorschoose.org/project/dna-mysteries/797331/'
      Project.first.pid.should == 797331
    end
  end

  context '.build_from_struct' do
    use_vcr_cassette
    it "creates a hash from a DonorsChoose struct" do
      
    end
  end

end
