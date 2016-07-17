require 'spec_helper'

describe Faq do
  let(:faq) {FactoryGirl.create(:faq)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :faq
    }.to change { Faq.count }.by(1)
  end
end