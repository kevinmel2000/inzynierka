require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ExpressionsController do

  # This should return the minimal set of attributes required to create a valid
  # Expression. As you add validations to Expression, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:name => 'word1'}
  end

  fixtures :collections # include common collection

  describe "GET index" do

    it 'shows only expressions from common collection (NOT LOGGED USER)' do
      c1 = FactoryGirl.build(:collection, :user_id => 1)
      c1.save(:validate => false)
      c1.expressions << e1 = FactoryGirl.create(:expression)

      c2 = Collection.common
      c2.expressions << e2 = FactoryGirl.create(:expression)

      get :index
      assigns(:records).should == [e2] 
    end

    it 'shows expressions belonging to a user (LOGGED USER)' do
      user = Factory.create(:user)
      sign_in user

      c1 = FactoryGirl.build(:collection, :user => user)
      c1.save
      c1.expressions << e1 = FactoryGirl.create(:expression)

      c2 = Collection.common
      c2.expressions << e2 = FactoryGirl.create(:expression)

      get :index
      assigns(:records).should == [e1] 
    end

  end

  describe "GET show" do
    it "assigns the requested expression as @expression" do
      expression = Expression.create! valid_attributes
      get :show, :id => expression.id.to_s
      assigns(:expression).should eq(expression)
    end
  end

  describe "GET new" do
    it "assigns a new expression as @expression" do
      get :new
      assigns(:expression).should be_a_new(Expression)
    end
  end

  describe "GET edit" do
    it "assigns the requested expression as @expression" do
      expression = Expression.create! valid_attributes
      get :edit, :id => expression.id.to_s
      assigns(:expression).should eq(expression)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Expression" do
        expect {
          post :create, :expression => valid_attributes
        }.to change(Expression, :count).by(1)
      end

      it "assigns a newly created expression as @expression" do
        post :create, :expression => valid_attributes
        assigns(:expression).should be_a(Expression)
        assigns(:expression).should be_persisted
      end

      it "redirects to the created expression" do
        post :create, :expression => valid_attributes
        response.should redirect_to(Expression.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved expression as @expression" do
        # Trigger the behavior that occurs when invalid params are submitted
        Expression.any_instance.stub(:save).and_return(false)
        post :create, :expression => {}
        assigns(:expression).should be_a_new(Expression)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Expression.any_instance.stub(:save).and_return(false)
        post :create, :expression => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested expression" do
        expression = Expression.create! valid_attributes
        # Assuming there are no other expressions in the database, this
        # specifies that the Expression created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Expression.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => expression.id, :expression => {'these' => 'params'}
      end

      it "assigns the requested expression as @expression" do
        expression = Expression.create! valid_attributes
        put :update, :id => expression.id, :expression => valid_attributes
        assigns(:expression).should eq(expression)
      end

      it "redirects to the expression" do
        expression = Expression.create! valid_attributes
        put :update, :id => expression.id, :expression => valid_attributes
        response.should redirect_to(expression)
      end
    end

    describe "with invalid params" do
      it "assigns the expression as @expression" do
        expression = Expression.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Expression.any_instance.stub(:save).and_return(false)
        put :update, :id => expression.id.to_s, :expression => {}
        assigns(:expression).should eq(expression)
      end

      it "re-renders the 'edit' template" do
        expression = Expression.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Expression.any_instance.stub(:save).and_return(false)
        put :update, :id => expression.id.to_s, :expression => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    before(:each) do
      @expression = Factory.create(:expression)
    end

    describe 'logged user' do

      before(:each) do
        @user = Factory.create(:user)
        sign_in @user
      end

      it "destroys the requested expression " do
        expect {
          delete :destroy, :id => @expression.id.to_s
        }.to change(Expression, :count).by(-1)
      end

      it "redirects to the expressions list" do
        delete :destroy, :id => @expression.id.to_s
        response.should redirect_to(expressions_url)
      end
    end

    # if you want to disallow not-registered users deleting records, change this
    describe 'not logged user' do

      it "destroys the requested expression " do
        expect {
          delete :destroy, :id => @expression.id.to_s
        }.to change(Expression, :count).by(-1)
      end

      it "redirects to the expressions list" do
        delete :destroy, :id => @expression.id.to_s
        response.should redirect_to(expressions_url)
      end
    end


  end

end
