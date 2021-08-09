require 'rails_helper'

RSpec.describe HeadingsParser do
  let(:response) {
    instance_double(HTTParty::Response, body: "<html><head></head><body><h1>Heading 1</h1><section><h2>Heading 2</h2><h3>Heading 3<h3></section>")
  }

  before(:each) do
    allow(HTTParty).to receive(:get).and_return(response)
  end

  it 'parses h1, h2, h3 from url' do
    url = "http://www.example.com"

    parser = HeadingsParser.new(url)

    expect(parser.parse.size).to eq(3)
    expect(parser.parse).to eq(["Heading 1", "Heading 2", "Heading 3"])
  end
end
