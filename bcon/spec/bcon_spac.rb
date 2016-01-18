#!/usr/bin/ruby

require 'bacon'

describe Bacon do
  it "is edible" do
    expect(Bacon.edible?).to be_true
  end
end
