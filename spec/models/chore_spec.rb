require "rails_helper"


RSpec.describe Chore, type: :model do
  subject {
    described_class.new(title: "Anything",
                        content: "Lorem ipsum")
  }


  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without title valid" do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without content valid" do
    subject.content = nil
    expect(subject).to_not be_valid
  end
end
