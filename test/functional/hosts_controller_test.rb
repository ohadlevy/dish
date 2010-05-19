require 'test_helper'

class HostsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Host.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Host.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Host.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to host_url(assigns(:host))
  end
  
  def test_edit
    get :edit, :id => Host.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Host.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Host.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Host.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Host.first
    assert_redirected_to host_url(assigns(:host))
  end
  
  def test_destroy
    host = Host.first
    delete :destroy, :id => host
    assert_redirected_to hosts_url
    assert !Host.exists?(host.id)
  end
end
