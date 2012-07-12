require 'spec_helper'

describe Project do
  context 'validations' do
    it 'requires a school' do
      test_project = Project.new
      test_project.should_not be_valid
    end
  end

  context '#create_from_url' do
    it 'creates a project with the right attributes' do
      
    end
  end
end
