#
# Copyright (C) 2011 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EportfoliosController do
  def eportfolio_category
    @category = @portfolio.eportfolio_categories.create!(:name => "some category")
  end
  
  def category_entry
    @entry = @category.eportfolio_entries.create!(:name => "some entry", :eportfolio => @portfolio)
  end
  
  # describe "GET 'index'" do
    # it "should assign variables" do
      # eportfolio_with_user
      # get 'index'
      # response.should be_success
      # assigns[:portfolios].should_not be_nil
    # end
  # end
  
  describe "GET 'user_index'" do
    it "should require authorization" do
      eportfolio_with_user(:active_all => true)
      get 'user_index'
      response.should be_redirect
    end
    
    it "should assign variables" do
      eportfolio_with_user_logged_in(:active_all => true)
      get 'user_index'
      assigns[:portfolios].should_not be_nil
      assigns[:portfolios].should_not be_empty
      assigns[:portfolios][0].should eql(@portfolio)
    end
  end
  
  describe "POST 'create'" do
    it "should require authorization" do
      post 'create', :eportfolio => {:name => "some portfolio"}
      assert_unauthorized
    end
    
    it "should create portfolio" do
      user(:active_all => true)
      user_session(@user)
      post 'create', :eportfolio => {:name => "some portfolio"}
      response.should be_redirect
      assigns[:portfolio].should_not be_nil
      assigns[:portfolio].name.should eql("some portfolio")
    end
  end
  
  describe "GET 'show'" do
  end
  
  describe "PUT 'update'" do
    it "should require authorization" do
      eportfolio_with_user(:active_all => true)
      put 'update', :id => @portfolio.id, :eportfolio => {:name => "new title"}
      assert_unauthorized
    end
    
    it "should update portfolio" do
      eportfolio_with_user_logged_in(:active_all => true)
      put 'update', :id => @portfolio.id, :eportfolio => {:name => "new title"}
      response.should be_redirect
      assigns[:portfolio].should_not be_nil
      assigns[:portfolio].name.should eql("new title")
    end
  end
  
  describe "DELETE 'destroy'" do
    it "should require authorization" do
      eportfolio_with_user(:active_all => true)
      delete 'destroy', :id => @portfolio.id
      assert_unauthorized
    end
    
    it "should delete portfolio" do
      eportfolio_with_user_logged_in(:active_all => true)
      delete 'destroy', :id => @portfolio.id
      assigns[:portfolio].should_not be_nil
      assigns[:portfolio].should_not be_frozen
      assigns[:portfolio].should be_deleted
      @user.reload
      @user.eportfolios.should be_include(@portfolio)
      @user.eportfolios.active.should_not be_include(@portfolio)
    end
  end
  
  describe "POST 'reorder_categories'" do
    it "should require authorization" do
      eportfolio_with_user(:active_all => true)
      post 'reorder_categories', :eportfolio_id => @portfolio.id, :order => ''
      assert_unauthorized
    end
    
    it "should reorder categories" do
      eportfolio_with_user_logged_in(:active_all => true)
      c1 = eportfolio_category
      c2 = eportfolio_category
      c3 = eportfolio_category
      c1.position.should eql(1)
      c2.position.should eql(2)
      c3.position.should eql(3)
      post 'reorder_categories', :eportfolio_id => @portfolio.id, :order => "#{c2.id},#{c3.id},#{c1.id}"
      response.should be_success
      c1.reload
      c2.reload
      c3.reload
      c1.position.should eql(3)
      c2.position.should eql(1)
      c3.position.should eql(2)
    end
  end
  
  describe "POST 'reorder_entries'" do
    it "should require authorization" do
      eportfolio_with_user(:active_all => true)
      post 'reorder_entries', :eportfolio_id => @portfolio.id, :order => '', :eportfolio_category_id => 1
      assert_unauthorized
    end
    
    it "should reorder entries" do
      eportfolio_with_user_logged_in(:active_all => true)
      eportfolio_category
      e1 = category_entry
      e2 = category_entry
      e3 = category_entry
      e1.position.should eql(1)
      e2.position.should eql(2)
      e3.position.should eql(3)
      post 'reorder_entries', :eportfolio_id => @portfolio.id, :eportfolio_category_id => @category.id, :order => "#{e2.id},#{e3.id},#{e1.id}"
      e1.reload
      e2.reload
      e3.reload
      e1.position.should eql(3)
      e2.position.should eql(1)
      e3.position.should eql(2)
    end
  end
end
