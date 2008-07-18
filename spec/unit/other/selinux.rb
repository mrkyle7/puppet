#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../../spec_helper'

require 'puppet/type/selboolean'
require 'puppet/type/selmodule'

describe Puppet::Type::File, " when manipulating file contexts" do
	before :each do
		@file = Puppet.type(:file).create(
			:path => "/tmp/foo",
			:ensure => "file",
			:seluser => "user_u",
			:selrole => "role_r",
			:seltype => "type_t")
	end
	it "should use :seluser to get/set an SELinux user file context attribute" do
		@file[:seluser].should == "user_u"
	end
	it "should use :selrole to get/set an SELinux role file context attribute" do
		@file[:selrole].should == "role_r"
	end
	it "should use :seltype to get/set an SELinux user file context attribute" do
		@file[:seltype].should == "type_t"
	end
end

describe Puppet::Type::Selboolean, " when manipulating booleans" do
	before :each do
		@bool = Puppet.type(:selboolean).create(
			:name => "foo",
			:value => "on",
			:persistent => true)
	end
	it "should be able to access :name" do
		@bool[:name].should == "foo"
	end
	it "should be able to access :value" do
		@bool[:value].should == :on
	end
	it "should set :value to off" do
		@bool[:value] = :off
		@bool[:value].should == :off
	end
	it "should be able to access :persistent" do
		@bool[:persistent].should == :true
	end
	it "should set :persistent to false" do
		@bool[:persistent] = false
		@bool[:persistent].should == :false
	end
end

describe Puppet::Type::Selmodule, " when checking policy modules" do
	before :each do
		@module = Puppet.type(:selmodule).create(
			:name => "foo",
			:selmoduledir => "/some/path",
			:selmodulepath => "/some/path/foo.pp",
			:syncversion => true)
	end
	it "should be able to access :name" do
		@module[:name].should == "foo"
	end
	it "should be able to access :selmoduledir" do
		@module[:selmoduledir].should == "/some/path"
	end
	it "should be able to access :selmodulepath" do
		@module[:selmodulepath].should == "/some/path/foo.pp"
	end
	it "should be able to access :syncversion" do
		@module[:syncversion].should == :true
	end
	it "should set the syncversion value to false" do
		@module[:syncversion] = :false
		@module[:syncversion].should == :false
	end
end
