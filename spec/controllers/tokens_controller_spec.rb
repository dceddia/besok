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

describe TokensController do

  # This should return the minimal set of attributes required to create a valid
  # Token. As you add validations to Token, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:name => 'ab23c', :description => 'My site tracker', :user_id => 1}
  end
  
  def user_supplied_attributes
    {:description => 'site tracking', :url => 'http://site.com'}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TokensController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  it "should authenticate the user" do
    get :index
    response.should redirect_to(new_user_session_path)
  end
  
  describe "once the user is logged in" do
    login_user
    describe "GET index" do
      it "assigns all tokens as @tokens" do
        token = Token.create! valid_attributes
        get :index, {}
        assigns(:tokens).should eq([token])
      end
    end

    describe "GET show" do
      it "assigns the requested token as @token" do
        token = Token.create! valid_attributes
        get :show, {:id => token.to_param}
        assigns(:token).should eq(token)
      end
    end

    describe "GET new" do
      it "assigns a new token as @token" do
        get :new, {}
        assigns(:token).should be_a_new(Token)
      end
    end

    describe "GET edit" do
      it "assigns the requested token as @token" do
        token = Token.create! valid_attributes
        get :edit, {:id => token.to_param}
        assigns(:token).should eq(token)
      end
    end

    describe "POST create" do
      describe "with user-entered params" do
        it "creates a new Token" do
          expect {
            post :create, {:token => user_supplied_attributes}
          }.to change(Token, :count).by(1)
        end

        it "assigns a newly created token as @token" do
          post :create, {:token => user_supplied_attributes}
          assigns(:token).should be_a(Token)
          assigns(:token).should be_persisted
        end

        it "redirects to the created token" do
          post :create, {:token => user_supplied_attributes}
          response.should redirect_to(Token.last)
        end
        
        it "overrides user-provided token name" do
          post :create, {:token => valid_attributes}
          assigns(:token).should satisfy { |token| token.name != valid_attributes[:name] }
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved token as @token" do
          # Trigger the behavior that occurs when invalid params are submitted
          Token.any_instance.stub(:save).and_return(false)
          post :create, {:token => {}}
          assigns(:token).should be_a_new(Token)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Token.any_instance.stub(:save).and_return(false)
          post :create, {:token => {}}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested token" do
          token = Token.create! valid_attributes
          # Assuming there are no other tokens in the database, this
          # specifies that the Token created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Token.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => token.to_param, :token => {'these' => 'params'}}
        end

        it "assigns the requested token as @token" do
          token = Token.create! valid_attributes
          put :update, {:id => token.to_param, :token => valid_attributes}
          assigns(:token).should eq(token)
        end

        it "redirects to the token" do
          token = Token.create! valid_attributes
          put :update, {:id => token.to_param, :token => valid_attributes}
          response.should redirect_to(token)
        end
      end

      describe "with invalid params" do
        it "assigns the token as @token" do
          token = Token.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Token.any_instance.stub(:save).and_return(false)
          put :update, {:id => token.to_param, :token => {}}
          assigns(:token).should eq(token)
        end

        it "re-renders the 'edit' template" do
          token = Token.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Token.any_instance.stub(:save).and_return(false)
          put :update, {:id => token.to_param, :token => {}}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested token" do
        token = Token.create! valid_attributes
        expect {
          delete :destroy, {:id => token.to_param}
        }.to change(Token, :count).by(-1)
      end

      it "redirects to the tokens list" do
        token = Token.create! valid_attributes
        delete :destroy, {:id => token.to_param}
        response.should redirect_to(tokens_url)
      end
    end
  end
end
