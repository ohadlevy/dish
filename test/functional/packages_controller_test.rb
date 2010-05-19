require 'test_helper'

class PackagesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Package.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Package.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Package.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to package_url(assigns(:package))
  end
  
  def test_edit
    get :edit, :id => Package.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Package.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Package.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Package.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Package.first
    assert_redirected_to package_url(assigns(:package))
  end
  
  def test_destroy
    package = Package.first
    delete :destroy, :id => package
    assert_redirected_to packages_url
    assert !Package.exists?(package.id)
  end
end
