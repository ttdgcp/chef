#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

describe Chef::Knife::RoleFromFile do
  before(:each) do
    @knife = Chef::Knife::RoleFromFile.new
    @knife.config = {
      :print_after => nil
    }
    @knife.name_args = [ "adam.rb" ]
    @knife.stub!(:json_pretty_print).and_return(true)
    @knife.stub!(:confirm).and_return(true)
    @role = Chef::Role.new() 
    @role.stub!(:save)
    @knife.stub!(:load_from_file).and_return(@role)
  end

  describe "run" do
    it "should load from a file" do
      @knife.should_receive(:load_from_file).with(Chef::Role, 'adam.rb').and_return(@role)
      @knife.run
    end

    it "should not print the role" do
      @knife.should_not_receive(:json_pretty_print)
      @knife.run
    end

    describe "with -p or --print-after" do
      it "should print the role" do
        @knife.config[:print_after] = true
        @knife.should_receive(:json_pretty_print)
        @knife.run
      end
    end
  end
end

