require 'test_helper'

class AppsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => App.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    App.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    App.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to app_url(assigns(:app))
  end
  
  def test_edit
    get :edit, :id => App.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    App.any_instance.stubs(:valid?).returns(false)
    put :update, :id => App.first
    assert_template 'edit'
  end
  
  def test_update_valid
    App.any_instance.stubs(:valid?).returns(true)
    put :update, :id => App.first
    assert_redirected_to app_url(assigns(:app))
  end
  
  def test_destroy
    app = App.first
    delete :destroy, :id => app
    assert_redirected_to apps_url
    assert !App.exists?(app.id)
  end
end
