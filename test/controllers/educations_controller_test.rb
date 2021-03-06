require 'test_helper'

class EducationsControllerTest < ActionController::TestCase
  # use jp_aes_test_huyendt

  # TDD list education
  test 'list educations successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    get :index

    educations = assigns(:educations)

    expected_educations = Education.where(user_id: user.id).order_by(created_at: -1)

    assert_equal educations, expected_educations

  end

  # TDD create education
  test 'create education successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    education = assigns(:education)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)

    assert_equal education, expected_education
  end

  test 'create education with school name is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = ''
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:school_name]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education
  end

  test 'create education with school name length is greater than 200' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = ''

    for i in 1..201
      school_name = school_name + 'a'
    end
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:school_name]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education
  end

  test 'create education with school name with white space first and end' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = '   school name   '
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    education = assigns(:education)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)

    assert_equal education, expected_education
  end

  test 'create education with start year is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = ''
    end_year = 2013
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  test 'create education with start year is not number' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 'abc'
    end_year = 2013
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  test 'create education with start year is less than 1905' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 1900
    end_year = 2013
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  test 'create education with start year is greater than now' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2015
    end_year = 2013
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:start_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  test 'create education with end year is not number' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = '2000'
    end_year = 'abc'
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  test 'create education with end year is less than 1905' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2000
    end_year = 1900
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  test 'create education with end year is greater than now' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2015
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education

  end

  test 'create education with end year is less than start year' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2000
    school_name = 'abc'
    description = 'description'

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:end_year]
    puts(assigns(:education).errors.full_messages.to_sentence)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education
  end

  test 'create education with description length is greater than 200' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'abc'
    description = ''
    for i in 1..201
      description = description + 'a'
    end

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    assert assigns(:education).errors[:description]
    puts(assigns(:education).errors.full_messages.to_sentence)


    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)
    assert_nil expected_education
  end

  test 'create education with description with white space first and end' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name'
    description = '   description   '

    #delete data
    assert Education.delete_all()

    post :create, :education => {:school_name => school_name, :current => current, :start_year => start_year, :end_year => end_year, :description => description}, :format => 'js'

    education = assigns(:education)

    expected_education = Education.find_by(school_name: school_name.strip, current: current, start_year: start_year, end_year: end_year, description: description.strip)

    assert_equal education, expected_education
  end

  #edit successful
  test 'edit education successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name edit successful'
    description = 'description edit successful'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 2013
    edit_school_name = 'updated school name edit successful'
    edit_description = 'updated description edit successful'

    post :update, :id => education.id.to_s, :education => {:school_name => edit_school_name, :current => edit_current, :start_year => edit_start_year, :end_year => edit_end_year, :description => edit_description}, :format => 'js'

    education = assigns(:education)

    expected_education = Education.find_by(id: education.id.to_s)

    assert_equal education, expected_education
  end

  #edit successful
  test 'edit education not existed' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name not existed'
    description = 'description not existed'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #education information
    edit_current = false
    edit_start_year = 2013
    edit_end_year = 2013
    edit_school_name = 'updated school name not existed'
    edit_description = 'updated description not existed'

    assert Education.delete_all(_id: education.id)

    post :update, :id => education.id.to_s, :education => {:school_name => edit_school_name, :current => edit_current, :start_year => edit_start_year, :end_year => edit_end_year, :description => edit_description}, :format => 'js'

    assert_equal flash.now[:error], I18n.t('educations.msg_education_not_found')
  end

  #delete successful
  test 'delete education successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name not existed'
    description = 'description not existed'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    delete :destroy, :id => education.id, :format => 'js'

    assert_nil Education.find_by(id: education.id)
  end

  #delete successful
  test 'delete education not existed' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #education information
    current = false
    start_year = 2013
    end_year = 2013
    school_name = 'school name not existed'
    description = 'description not existed'

    #delete data
    assert Education.delete_all()

    education = Education.new(school_name: school_name, current: current, start_year: start_year, end_year: end_year, description: description, user_id: user.id)
    assert education.save

    #delete data
    assert Education.delete_all(_id: education.id)

    delete :destroy, :id => education.id, :format => 'js'

    assert_equal flash.now[:error], I18n.t('educations.msg_education_not_found')
  end
end