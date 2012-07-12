require 'spec_helper'

describe Widget do
  it "delegates missing methods to its project" do
    p = Project.create(title: "Foo")
    w = p.widgets.create
    w.title.should == "Foo"
  end

  it "Returns true for respond_to? when asked about a project method" do
    p = Project.create(title: "Foo")
    w = p.widgets.create
    w.respond_to?(:title).should be_true
  end

  it "Raises a method missing error if neither it nor a project respond to a method" do
    p = Project.create(title: "Foo")
    w = p.widgets.create
    expect { w.foo }.should raise_error
  end

end
