require 'spec_helper'

describe "expressions/index.html.haml" do
  before(:each) do
    assign(:expressions, [
      stub_model(Expression,
        :name => "MyText",
        :definition => "MyText",
        :notes => "MyText"
      ),
      stub_model(Expression,
        :name => "MyText",
        :definition => "MyText",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of expressions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
