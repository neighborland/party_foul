# frozen_string_literal: true

require 'test_helper'

describe 'Rackless Issue Renderer' do
  before do
    @env = { :params => { :val1 => '1', :val2 => '2' }, :class => 'Worker', :method => 'perform' }
  end

  describe '#params' do
    before do
      @rendered_issue = PartyFoul::IssueRenderers::Rackless.new(nil, @env)
    end

    it 'returns the parameters' do
      @rendered_issue.params[:val1].must_equal '1'
      @rendered_issue.params[:val2].must_equal '2'
    end
  end

  describe '#raw_title' do
    before do
      @exception = Exception.new('message')
      @rendered_issue = PartyFoul::IssueRenderers::Rackless.new(@exception, @env)
    end

    it 'constructs the title with the controller and action' do
      @rendered_issue.send(:raw_title).must_equal %{Worker#perform (Exception) "message"}
    end
  end
end
