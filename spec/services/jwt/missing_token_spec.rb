# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Jwt::Authenticator, type: :service do
  describe 'call' do
    let(:invalid_token_header) { invalid_token_header }
    
    it 'should raise missing token exception' do
      expect { Jwt::Authenticator.call({}) }.to raise_error(Errors::Jwt::MissingToken)
    end
  end
end
