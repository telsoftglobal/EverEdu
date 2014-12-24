require 'test_helper'

class WorkExperiencesControllerTest < ActionController::TestCase
  # use jp_aes_test_huyendt

  # TDD list work experiences
  test 'list work experiences successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    get :index

    work_experiences = assigns(:work_experiences)

    expected_work_experiences = WorkExperience.where(user_id: user.id).order_by(created_at: -1)

    assert_equal work_experiences, expected_work_experiences

  end


  # TDD create work experiences
  test 'create work experiences successful' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    work_experience = assigns(:work_experience)

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)

    assert_equal work_experience, expected_work_experience

  end

  test 'create work experiences with category is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = nil
    level_id = nil

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:category]
    assert assigns(:work_experience).errors[:level]

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end

  test 'create work experiences with level is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = nil

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:level]

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end

  test 'create work experiences with start year is nil' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = ''
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:start_year]
    puts (assigns(:work_experience).errors[:start_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience

  end

  test 'create work experiences with start year is not number' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id
    level_id = Level.find_by(category_id: category_id, level_order: 1).id

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 'abc'
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all(), :format => 'js'

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}

    assert assigns(:work_experience).errors[:start_year]
    puts (assigns(:work_experience).errors[:start_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience

  end

  test 'create work experiences with start year is less than 1905' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = '1900'
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:start_year]
    puts (assigns(:work_experience).errors[:start_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience

  end

  test 'create work experiences with start year is greater than now' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = Time.now.year + 1
    end_year = 2013
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:start_year]
    puts (assigns(:work_experience).errors[:start_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end


  test 'create work experiences with end year is not number' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 'abc'
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:end_year]
    puts (assigns(:work_experience).errors[:end_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end


  test 'create work experiences with end year is less than 1905' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 1900
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:end_year]
    puts (assigns(:work_experience).errors[:end_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience

  end

  test 'create work experiences with end year is greater than now' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = Time.now.year + 1
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:end_year]
    puts (assigns(:work_experience).errors[:end_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end

  test 'create work experiences with end year is less than start year' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 1995
    work_place = 'work place'
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:end_year]
    puts (assigns(:work_experience).errors[:end_year])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end


  test 'create work experiences with work place length is greater than 200' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 2001
    work_place = ''
    for i in 1..201
      work_place = work_place + 'a'
    end
    description = 'description'

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:work_place]
    puts (assigns(:work_experience).errors[:work_place])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description)
    assert_nil expected_work_experience
  end


  test 'create work experiences with work place with white space first and end' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 2001
    work_place = '       work place       '
    description = 'description'

    #delete data
    assert WorkExperience.delete_all(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place.strip, description: description)

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    work_experience = assigns(:work_experience)

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place.strip, description: description)
    assert_equal expected_work_experience, work_experience
  end

  test 'create work experiences with description length is greater than 200' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2000
    end_year = 2001
    work_place = 'work place'

    description = ''
    for i in 1..201
      description = description + 'a'
    end

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    assert assigns(:work_experience).errors[:description]
    puts (assigns(:work_experience).errors[:description])

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description.strip)
    assert_nil expected_work_experience
  end


  test 'create work experiences with description with white space first and end' do
    #user
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2000
    end_year = 2001
    work_place = 'work place'
    description = '        description    '

    #delete data
    assert WorkExperience.delete_all()

    post :create, :work_experience => {:category_id => category_id, :level_id => level_id, :current => current, :start_year => start_year, :end_year => end_year, :work_place => work_place, :description => description}, :format => 'js'

    work_experience = assigns(:work_experience)

    expected_work_experience = WorkExperience.find_by(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description.strip)
    assert_equal expected_work_experience, work_experience
  end

  #edit successful
  test 'edit successful' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'Fashion/Lifestyle').id.to_s
    edit_level_id = Level.find_by(category_id: edit_category_id, level_order: 1).id.to_s

    # edit_category_id = '5466bc0f4875791039ab0000'
    # edit_level_id = '5466bc0f4875791039ac0000'

    edit_current = true
    edit_start_year = 2012
    edit_end_year = ''
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    post :update, :id => work_experience.id.to_s, :work_experience => { :category_id => edit_category_id, :level_id => edit_level_id, :current => edit_current, :start_year => edit_start_year, :end_year => edit_end_year, :work_place => edit_work_place, :description => edit_description}, :format => 'js'

    work_experience = assigns(:work_experience)

    expected_work_experience = WorkExperience.find_by(id: work_experience.id)
    assert_equal expected_work_experience, work_experience
  end


  #edit not existed
  test 'edit work experience not existed' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description edit test'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    edit_category_id = Category.find_by(category_name: 'Fashion/Lifestyle').id.to_s
    edit_level_id = Level.find_by(category_id: edit_category_id, level_order: 1).id.to_s

    # edit_category_id = '5466bc0f4875791039ab0000'
    # edit_level_id = '5466bc0f4875791039ac0000'

    edit_current = true
    edit_start_year = 2012
    edit_end_year = ''
    edit_work_place = 'updated work place '
    edit_description = 'updated description edit test'

    assert WorkExperience.delete_all(_id: work_experience.id)

    post :update, :id => work_experience.id.to_s, :work_experience => { :category_id => edit_category_id, :level_id => edit_level_id, :current => edit_current, :start_year => edit_start_year, :end_year => edit_end_year, :work_place => edit_work_place, :description => edit_description}, :format => 'js'

    assert_equal flash.now[:error], I18n.t('work_experiences.msg_work_experience_not_found')
  end


  #delete successful
  test 'delete successful' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    # category_id = '5466bc0f48757910390e0100'
    # level_id = '5466bc0f48757910390a0000'
    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description test delete'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    # delete :destroy, :id => work_experience.id, :format => 'js'

    # assert_nil WorkExperience.find_by(id: work_experience.id)
  end

  #delete not existed
  test 'delete work experience not existed' do
    #create data
    user = User.find_by(user_name: 'huyendt')
    session[:user_id] = user.id

    #work experience info
    category_id = Category.find_by(category_name: 'IT').id.to_s
    level_id = Level.find_by(category_id: category_id, level_order: 1).id.to_s

    current = false
    start_year = 2013
    end_year = 2013
    work_place = 'work place '
    description = 'description test delete'

    #delete data
    assert WorkExperience.delete_all()

    work_experience = WorkExperience.new(category_id: category_id, level_id: level_id, current: current, start_year: start_year, end_year: end_year, work_place: work_place, description: description, user_id: user.id)
    assert work_experience.save

    assert WorkExperience.delete_all(_id: work_experience.id)

    delete :destroy, :id => work_experience.id, :format => 'js'

    assert_equal flash.now[:error], I18n.t('work_experiences.msg_work_experience_not_found')
  end


end